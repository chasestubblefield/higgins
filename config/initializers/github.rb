github_config_path = Rails.root.to_s + '/config/github.yml'

Higgins::Application.config.github =
  if File.exists? github_config_path
    YAML.load_file(github_config_path)[Rails.env]
  else
    nil
  end
