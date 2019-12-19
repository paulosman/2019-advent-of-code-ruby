require_relative './intcode_computer.rb'

# We use a brute force approach to find the pair of inputs that produce the
# output 19690720.
noun_value = 0
verb_value = 0
noun_value.upto(99).each do |n|
  verb_value.upto(99).each do |v|
    input = File.new('input/day02.txt').read.split(',').map(&:to_i)
    input[1] = n
    input[2] = v
    computer = Computer.new(input)

    input.each_slice(4).each do |slice|
      result = computer.process_instruction(slice)

      break unless result

      if computer.program[0] == 19_690_720
        p(computer.program[1])
        p(computer.program[2])
      end
    end
  end
end
