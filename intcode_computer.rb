# Intcode Computer. An intcode computer is capable of processing intcode
# programs. An intcode program contains instructions which are a list of
# integers. The first integer is the opcode.  opcode. An opcode of 1 means
# we're adding, 2 means we're multiplying, and 99 means that the program is
# finished and should immediately halt. For addition and multiplication
# instructions, the second and third integers are the positions of the operands
# in the original input array. The fourth integer in the instruction is the
# position in the input array that should be overwritten with the result of the
# instruction.
#
# Note that this version returns false when the instruction is a halt operation,
# and modifies original when the instruction contains an addition or
# multiplication opcode.
class Computer
  attr_accessor :original

  def initialize(original)
    @original = original
    @modes = {
      100 => 0,
      1000 => 0,
      10000 => 0
    }
  end

  def opcodes(number)
    {
      1 => :+,
      2 => :*,
      3 => :input,
      4 => :output,
      99 => :halt
    }[number % 100]
  end

  def input(val)

  end

  def output(val)

  end

  def parameter_modes(opcode)
    {
      100   => (opcode % 1000) / 100,
      1000  => (opcode % 10000) / 1000,
      10000 => (opcode % 100000) / 10000
    }
  end

  def process(opcode, input=1)
    operation = opcodes(opcode[0])
    return if operation == :halt

    modes = parameter_modes(opcode[0])

    if operation == :input
      p("@original[#{opcode[1]}] = #{input}")
      @original[opcode[1]] = input
      @original
    elsif operation == :output
      @original[opcode[1]]
    else
      operand_one = modes[100]  == 1 ? opcode[1] : @original[opcode[1]]
      operand_two = modes[1000] == 1 ? opcode[2] : @original[opcode[2]]
      p("@original[#{opcode[3]}] = #{operand_one} #{operation} #{operand_two}")
      @original[opcode[3]] = operand_one.send(operation, operand_two)
      @original
    end
  end
end
