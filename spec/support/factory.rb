module Factory
  extend self

  def build
    Build.create!(name: 'n', ref: 'master')
  end
end
