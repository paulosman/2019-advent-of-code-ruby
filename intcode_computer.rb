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

  def value_for_mode(mode, program, value)
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

  def process(pointer)
    operation = opcodes(program[pointer])
    return nil if operation == :halt

    modes = parameter_modes(program[pointer])

    if operation == :input
      puts "INPUT: "
      input = gets.chomp.to_i
      dest = program[pointer + 1]
      program[dest] = input
      pointer + 2
    elsif operation == :output
      puts "OUTPUT: #{program[program[pointer + 1]]}"
      pointer + 2
    else
      operand_one = value_for_mode(modes[100], program, program[pointer + 1])
      operand_two = value_for_mode(modes[1000], program, program[pointer + 2])
      dest = program[pointer + 3]
      program[dest] = operand_one.send(operation, operand_two)
      pointer + 4
    end
  end
end
