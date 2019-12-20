# Intcode Computer. An intcode computer is capable of processing 
# intcode programs. An intcode program contains instructions which 
# are a list of integers. The first integer is the opcode. An 
# opcode of 1 means we're adding, 2 means we're multiplying, and 99
# means that the program is finished and should immediately halt. 
# For addition and multiplication instructions, the second and 
# third integers are the positions of the operands in the original 
# input array. The fourth integer in the instruction is the 
# position in the input array that should be overwritten with the 
# result of the instruction.
#
# Note that this version returns false when the instruction is a 
# halt operation, and modifies original when the instruction 
# contains an addition or multiplication opcode.
class Computer
  attr_accessor :program

  def initialize(program)
    @program = program
  end

  def opcodes(number)
    {
      1 => :+,
      2 => :*,
      3 => :input,
      4 => :output,
      5 => :jump_if_true,
      6 => :jump_if_false,
      7 => :less_than,
      8 => :equals,
      99 => :halt
    }[number % 100]
  end

  def parameter_modes(opcode)
    {
      100   => (opcode % 1000) / 100,
      1000  => (opcode % 10000) / 1000,
      10000 => (opcode % 100000) / 10000
    }
  end

  def value_for_mode(mode, value)
    if mode == 0 # position
      program[value]
    else
      value
    end
  end

  def process_instruction(instruction)
    opcode = opcodes(instruction[0])
    return false if opcode == :halt

    operand_one = program[instruction[1]]
    operand_two = program[instruction[2]]

    program[instruction[3]] = operand_one.send(opcode, operand_two)
    program
  end

  def input(pointer)
    puts "INPUT: "
    input = gets.chomp.to_i
    dest = program[pointer + 1]
    program[dest] = input
    pointer + 2
  end

  def output(pointer)
    puts "OUTPUT: #{program[program[pointer + 1]]}"
    pointer + 2
  end

  def jump_if_true(pointer)
    modes = parameter_modes(program[pointer])
    predicate = value_for_mode(modes[100], program[pointer + 1])
    dest = value_for_mode(modes[1000], program[pointer + 2])

    return dest unless predicate == 0

    pointer + 3
  end

  def jump_if_false(pointer)
    modes = parameter_modes(program[pointer])
    predicate = value_for_mode(modes[100], program[pointer + 1])
    dest = value_for_mode(modes[1000], program[pointer + 2])

    return dest if predicate == 0

    pointer + 3
  end

  def less_than(pointer)
    modes = parameter_modes(program[pointer])
    a = value_for_mode(modes[100], program[pointer + 1])
    b = value_for_mode(modes[1000], program[pointer + 2])

    if a < b
      program[program[pointer + 3]] = 1
    else
      program[program[pointer + 3]] = 0
    end

    pointer + 4
  end

  def equals(pointer)
    modes = parameter_modes(program[pointer])
    a = value_for_mode(modes[100], program[pointer + 1])
    b = value_for_mode(modes[1000], program[pointer + 2])

    if a == b
      program[program[pointer + 3]] = 1
    else
      program[program[pointer + 3]] = 0
    end

    pointer + 4
  end

  def binary_op(op, pointer)
    modes = parameter_modes(program[pointer])
    operand_one = value_for_mode(modes[100], program[pointer + 1])
    operand_two = value_for_mode(modes[1000], program[pointer + 2])
    dest = program[pointer + 3]
    program[dest] = operand_one.send(op, operand_two)
    pointer + 4
  end

  def +(pointer)
    binary_op(:+, pointer)
  end

  def *(pointer)
    binary_op(:*, pointer)
  end

  def process(pointer)
    operation = opcodes(program[pointer])
    return nil if operation == :halt

    self.send(operation, pointer)
  end
end
