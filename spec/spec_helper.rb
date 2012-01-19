$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'active_record'
require 'has_followers'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ":memory:"}}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations["test"])

load(File.join(File.dirname(__FILE__), 'schema.rb'))

RSpec.configure do |config|
  config.mock_with :rspec
end

class Object
  def self.unset_class(*args)
    class_eval do
      args.each do |klass|
        eval(klass) rescue nil
        remove_const(klass) if const_defined?(klass)
      end
    end
  end
end

alias :doing :lambda

# unset models used for testing purposes
Object.unset_class('User')

class User < ActiveRecord::Base
  has_followers
end