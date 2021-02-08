# frozen_string_literal: true

require "fear/pattern_match"

module Fear
  # Either pattern matcher
  #
  # @example
  #   pattern_match =
  #     EitherPatternMatch.new
  #       .right(Integer, ->(x) { x > 2 }) { |x| x * 2 }
  #       .right(String) { |x| x.to_i * 2 }
  #       .left(String) { :err }
  #       .else { 'error '}
  #
  #   pattern_match.call(42) => 'NaN'
  #
  #  @example the same matcher may be defined using block syntax
  #    EitherPatternMatch.new do |m|
  #      m.right(Integer, ->(x) { x > 2 }) { |x| x * 2 }
  #      m.right(String) { |x| x.to_i * 2 }
  #      m.left(String) { :err }
  #      m.else { 'error '}
  #    end
  #
  # @note it has two optimized subclasses +Fear::LeftPatternMatch+ and +Fear::RightPatternMatch+
  # @api private
  class EitherPatternMatch < Fear::PatternMatch
    # Match against +Fear::Right+
    #
    # @param conditions [<#==>]
    # @return [Fear::EitherPatternMatch]
    def right(*conditions, &effect)
      branch = Fear.case(Fear::Right, &:right_value).and_then(Fear.case(*conditions, &effect))
      or_else(branch)
    end
    alias success right

    # Match against +Fear::Left+
    #
    # @param conditions [<#==>]
    # @return [Fear::EitherPatternMatch]
    def left(*conditions, &effect)
      branch = Fear.case(Fear::Left, &:left_value).and_then(Fear.case(*conditions, &effect))
      or_else(branch)
    end
    alias failure left
  end
end

require "fear/left_pattern_match"
require "fear/right_pattern_match"
