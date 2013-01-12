module Maxus
  autoload 'Proxy', 'maxus/proxy'

  class Builder

    attr_reader :_hash

    def self.build(env, &block)
      builder = new(env, &block)

      builder._hash
    end

    def initialize(env, &block)
      @envs = {}

      instance_eval &block

      @_hash = @envs[env]
      parent = @envs[env][:parent]

      while parent do
        @_hash = @envs[parent].deep_merge @_hash
        parent = @envs[parent][:parent]
      end
    end

    def env(name, options = {}, &block)
      @envs[name] = options.merge :hash => Proxy.build(&block)
    end

  end

end