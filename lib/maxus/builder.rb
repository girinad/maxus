module Maxus
  autoload 'Proxy', 'maxus/proxy'

  class Builder

    attr_reader :_hash

    def self.build(current_env, &block)
      builder = new(current_env, &block)

      builder._hash
    end

    def initialize(current_env, &block)
      @envs = {}

      instance_eval &block

      raise NonexistentBlock if !@envs[current_env]
      @_hash = @envs[current_env][:hash]

      make_inheritance(current_env)
    end

    def env(name, options = {}, &block)
      @envs[name] = options.merge hash: Proxy.build(&block)
    end

    def make_inheritance(current_env)
      parent = @envs[current_env][:parent]

      merged_envs = []
      while parent do
        @_hash = @envs[parent][:hash].deep_merge @_hash
        parent = @envs[parent][:parent]

        merged_envs << parent
        raise LoopedInheritance if loop?(merged_envs)
      end
    end

    def loop?(merged_envs)
      merged_envs.length != merged_envs.uniq.length
    end

  end

end