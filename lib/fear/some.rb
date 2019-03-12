module Fear
  class Some
    include Option
    include Dry::Equalizer(:get)
    include RightBiased::Right
    include SomePatternMatch.mixin

    attr_reader :value
    protected :value

    # FIXME: nice inspect

    def initialize(value)
      @value = value
    end

    # @return [any]
    def get
      @value
    end

    # @return [any]
    def or_nil
      @value
    end

    # @return [false]
    def empty?
      false
    end

    # @return [Option]
    def select
      if yield(value)
        self
      else
        None
      end
    end

    # @return [Option]
    def reject
      if yield(value)
        None
      else
        self
      end
    end

    # @return [String]
    alias to_s inspect
  end
end
