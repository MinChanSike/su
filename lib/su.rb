base_directory  = File.expand_path(File.join(File.dirname(__FILE__), '..'))
su_stylesheets_path = File.join(base_directory, 'stylesheets')
su_templates_path = File.join(base_directory, 'templates')
begin
  require 'compass'
  Compass::Frameworks.register('su', :stylesheets_directory => su_stylesheets_path, :templates_directory => su_templates_path)
rescue LoadError
  # compass not found, register on the Sass path via the environment.
  if ENV.has_key?("SASS_PATH")
    ENV["SASS_PATH"] = ENV["SASS_PATH"] + File::PATH_SEPARATOR + su_stylesheets_path
  else
    ENV["SASS_PATH"] = su_stylesheets_path
  end
end
