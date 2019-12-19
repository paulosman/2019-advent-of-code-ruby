require 'minitest/autorun'

require_relative './intcode_computer.rb'

class IntCodeTest < Minitest::Test

  def test_parameter_modes
    computer = Computer.new(
      [1002, 4, 3, 4, 33]
    )
    assert_equal :*, computer.opcodes(1002)
    assert_equal 0, computer.parameter_modes(1002)[100]
    assert_equal 1, computer.parameter_modes(1002)[1000]
    assert_equal 0, computer.parameter_modes(1002)[10000]

    assert_equal 1, computer.parameter_modes(1102)[100]
    assert_equal 1, computer.parameter_modes(1102)[1000]
    assert_equal 0, computer.parameter_modes(1102)[10000]
    assert_equal 1, computer.parameter_modes(11102)[10000]
  end

end
