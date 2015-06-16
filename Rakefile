#
# constants
#
CHEF_VERSION = '11.16.4'

#
# common tasks
#
desc "run all tests"
task :test => ['test:foodcritic', 'test:rubocop', 'test:chefspec', 'test:library', 'test:serverspec'] do
  puts "Tests complete!"
end

namespace :test do
  desc "run foodcritic lint"
  task :foodcritic do
    sh "bundle exec foodcritic --chef-version #{CHEF_VERSION} --tags ~FC003 -f correctness ."
  end

  desc "run rubocop lint"
  task :rubocop do
    sh "bundle exec rubocop --format simple"
  end

  desc "run chefspec tests"
  task :chefspec do
    sh "bundle exec rspec --color -fd test/unit/template/chefspec/*_spec.rb"
  end

  desc "run library spec tests"
  task :library do
    sh "bundle exec rspec --color -fd test/unit/libraries/rspec/*_spec.rb"
  end

  desc "run serverspec tests"
  task :serverspec do
    sh "bundle exec kitchen test"
  end
end

#
# test kitchen tasks
#
namespace :kitchen do
  desc "converge"
  task :converge do
    sh "bundle exec kitchen converge"
  end

  desc "verify"
  task :verify do
    sh "bundle exec kitchen verify"
  end

  desc "destroy"
  task :destroy do
    sh "bundle exec kitchen destroy"
  end

  task "login"
  task :login do
    sh "bundle exec kitchen login"
  end
end

#
# encrypted databag tasks
#
namespace :encrypted_databag do
  passwd = File.read('test/data/secret.txt').chomp
  options = "--data-bag-path data_bags"

  desc "list encrypted data bags"
  task :list do
    sh "bundle exec knife solo data bag list #{options}"
  end

  #
  # rake encrypted_databag:create[test,foobar,foobar.json]
  #
  desc "create encrypted data bag"
  task :create, [:bag_name, :item_name, :filename] do |_t, args|
    sh "bundle exec knife solo data bag create #{args[:bag_name]} #{args[:item_name]} -s #{passwd} --json-file #{args[:filename]} #{options}"
  end

  #
  # rake encrypted_databag:edit[app,app-test]
  #
  desc "edit encrypted data bag"
  task :edit, [:bag_name, :item_name] do |_t, args|
    sh "bundle exec knife solo data bag edit #{args[:bag_name]} #{args[:item_name]} -s #{passwd} #{options}"
  end
end
