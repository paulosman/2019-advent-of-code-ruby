# Process the opcode instruction. The first integer in the instruction is the
# opcode. An opcode of 1 means we're adding, 2 means we're multiplying, and 99
# means that the program is finished and should immediately halt. For addition
# and multiplication instructions, the second and third integers are the
# positions of the operands in the original input array. The fourth integer in
# the instruction is the position in the input array that should be overwritten
# with the result of the instruction.
#
# Note that this version returns false when the instruction is a halt operation,
# and modifies original when the instruction contains an addition or
# multiplication opcode.
def process_opcode(opcode, original)
  operation = opcode[0]
  return false if operation == 99

  symbol = operation == 1 ? :+ : :*

  positions = [original[opcode[1]], original[opcode[2]]]
  replace = opcode[3]

  original[replace] = positions[0].send(symbol, positions[1])

  true
end

# We use a brute force approach to find the pair of inputs that produce the
# output 19690720.
noun_value = 0
verb_value = 0
noun_value.upto(99).each do |n|
  verb_value.upto(99).each do |v|
    input = File.new('input/day02.txt').read.split(',').map(&:to_i)
    input[1] = n
    input[2] = v

    input.each_slice(4).each do |slice|
      result = process_opcode(slice, input)
      break unless result

      if input[0] == 19_690_720
        p(input[1])
        p(input[2])
      end
    end
  end
end
