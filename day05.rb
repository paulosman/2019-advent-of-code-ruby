require_relative './intcode_computer.rb'

input = File.new('input/day05.txt').read.split(',').map(&:to_i)
computer = Computer.new(input)

pointer = 0
while pointer != nil
  pointer = computer.process(pointer)
end
