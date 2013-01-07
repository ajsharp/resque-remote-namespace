require 'rubygems'
require 'bundler/setup'
require 'rspec'

$: << File.expand_path('../lib', File.dirname(__FILE__))

require 'resque-remote-namespace'

Resque.redis.namespace = 'resque:foo'

# Run a block of code from a different namespace.
#
# @param [ String ] namespace The namespace to execute the block of code from.
# @param [ Proc ] block The block of code to execute from a different
#   namespace.
def from_namespace(namespace, &block)
  original_namespace     = Resque.redis.namespace
  Resque.redis.namespace = namespace

  yield if block_given?
ensure
  Resque.redis.namespace = original_namespace
end
