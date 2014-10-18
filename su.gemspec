# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  # General Project Information
  s.name = "su"
  s.version = File.read(File.join(File.dirname(__FILE__), "VERSION"))
  s.licenses = ['BSD-3-Clause']
  s.date = "2014-02-18"

  # RubyForge Information
  s.rubyforge_project = "su"
  s.rubygems_version = "2.0.3"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=

  # Author Information
  s.authors = ["Eric M Suzanne"]
  s.email = ["eric@oddbird.net"]
  s.homepage = "http://ericam.github.com/su/"

  # Project Description
  s.summary = "Sass Grid Engine."
  s.description = "Su is grid-framework engine. Go build your own framework!"

  # Files to Include
  s.require_paths = ["lib"]

  s.files = Dir.glob("lib/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")
  s.files += Dir.glob("templates/**/*.*")
  s.files += ["CHANGELOG.md", "LICENSE", "README.md", "VERSION"]

  # Docs Information
  s.extra_rdoc_files = ["CHANGELOG.md", "LICENSE", "README.md", "lib/su.rb"]
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Su", "--main", "README.md"]

  dependencies = {
    "sass"    => ["~> 3.4"]
  }
  # Project Dependencies
  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      dependencies.each do |project, version|
        s.add_runtime_dependency(project, version)
      end
    else
      dependencies.each do |project, version|
        s.add_dependency(project, version)
      end
    end
  else
    dependencies.each do |project, version|
      s.add_dependency(project, version)
    end
  end
end
