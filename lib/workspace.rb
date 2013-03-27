require 'bundler'
require 'open3'
require 'fileutils'
require 'uri'

class Workspace

  attr_accessor :logger

  def initialize(git_revision)
    @git_revision = git_revision
    @logger = Logger.new(nil)
  end

  def ensure_repo
    return if @prepared

    if exists?
      raw_execute_in_dir 'git clean -qfd'
      raw_execute_in_dir 'git fetch -q'
    else
      FileUtils.mkdir_p root
      raw_execute "git clone -q #{git_url} #{root}"
    end
    raw_execute_in_dir "git checkout -q #{@git_revision}"

    @prepared = true
  end

  def ensure_bundle_installed
    ensure_repo
    unless @bundle_installed
      Bundler.with_clean_env { execute('bundle check || bundle install') }
      @bundle_installed = true
    end
  end

  def specs
    find_files 'spec/**/*_spec.rb'
  end

  def features
    find_files 'features/**/*.feature'
  end

  def find_files(glob)
    ensure_repo
    Dir.chdir(root) do
      Dir[glob]
    end
  end

  def root
    @root ||= File.join(Rails.root, 'workspace', name_from_url)
  end

  def name_from_url
    URI.parse(git_url).path.split('/').last.gsub(/\.git$/, '')
  end

  def exists?
    Dir.exists? root
  end

  def git_url
    Higgins::Application.config.project['git_url']
  end

  def environment
    Higgins::Application.config.project['env'] || {}
  end

  def bundle_exec(command)
    ensure_bundle_installed
    Bundler.with_clean_env { execute("bundle exec #{command}") }
  end

  def execute(command)
    ensure_repo
    raw_execute_in_dir(command, environment, {pgroup: true})
  end

  def raw_execute_in_dir(command, env={}, opts={})
    raw_execute(command, env, opts.merge(chdir: root))
  end

  def raw_execute(command, env={}, opts={})
    logger.info "$ #{command}"
    output, status = Open3.capture2e(env, command, opts)
    logger.info output unless output.empty?
    raise CommandFailed.new(command, output, status) unless status.success?
    output
  end

  class CommandFailed < StandardError
    attr_accessor :command, :output, :status

    def initialize(command, output, status)
      super("\"#{command}\" failed with exit status #{status.exitstatus}")
      self.command, self.output, self.status = command, output, status
    end
  end
  class CommandTimeout < StandardError; end
end
