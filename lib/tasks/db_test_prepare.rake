# test db should not fail if dev db is not migrated
# it should just load from db/schema.rb
Rake::Task['db:test:prepare'].clear_prerequisites
task 'db:test:prepare' => [:environment, :load_config]
