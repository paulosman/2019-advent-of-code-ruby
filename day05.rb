require_relative './intcode_computer.rb'

input = File.new('input/day05.txt').read.split(',').map(&:to_i)
computer = Computer.new(input)

p("INPUT[225]: #{input[225]}")
i = 0
while true
  value = input[i]
  instruction = []
  case value
  when 3 || 4
    instruction = input[i..i+1]
    i = i + 2 
  when 1 || 2
    instruction = input[i..i+3]
    i = i + 4
  when 99
    instruction = [input[i]]
    i = i = 1
  else
    instruction = input[i..i+3]
    i = i + 4
  end
  p(instruction)
  result = computer.process(instruction, 1)
end
