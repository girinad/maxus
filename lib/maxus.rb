require "maxus/version"
require "active_support/core_ext/hash"

module Maxus
  autoload 'Builder', 'maxus/builder'
  autoload 'Creator', 'maxus/creator'

  def self.build(env, &block)
    result = Builder.build(env, &block)
    Creator.create(result)
  end

  class EmptyBlock < RuntimeError ; end
end
