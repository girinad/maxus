require "maxus/version"
require "active_support/core_ext/hash"

module Maxus
  autoload 'Builder', 'maxus/builder'
  autoload 'Creator', 'maxus/creator'

  def self.build(env, &block)
    result = Builder.build(env, &block)
    Creator.create(result)
  end

  class MaxusError < RuntimeError ; end
  class NonexistentBlock < MaxusError ; end
  class LoopedInheritance < MaxusError ; end


end
