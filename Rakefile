require 'rake'
require 'rake/gempackagetask'
require 'rake/clean'
require 'rake/testtask'
require 'find'

gem_spec = Gem::Specification.new do |s|
  s.name = 'mack-localization'
  s.version = '0.5.0'
  s.summary = %{mack-localization}
  s.description = %{Localization support for Mack Framework}
  s.author = "Darsono Sutedja"
  s.email = "Darsono.Sutedja@gmail.com"

  s.test_files = FileList['test/**/*']

  s.files = FileList['lib/**/*.rb', 'README', 'doc/**/*.*']
  s.require_paths << 'lib'

  #s.bindir = "bin"
  #s.executables = "mack-localization"
  #s.default_executable = ""
  #s.add_dependency("", "")
  #s.add_dependency("", "")
  #s.extensions << ""
  #s.extra_rdoc_files = ["README"]
  #s.has_rdoc = true
  #s.platform = "Gem::Platform::Ruby"
  #s.required_ruby_version = ">= 1.8.5"
  #s.requirements << "An ice cold beer."
  #s.requirements << "Some free time!"
  #s.rubyforge_project = "mack-localization"
end

Rake::GemPackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
  rm_f FileList['pkg/**/*.*']
end

desc "Run test code"
Rake::TestTask.new(:default) do |t|
  t.libs << "test"
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end