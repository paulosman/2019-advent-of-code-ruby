def fuel_required(mass)
  (mass / 3) - 2
end

def total_fuel(mass)
  required = fuel_required(mass)
  if required <= 0
    0
  else
    required + total_fuel(required)
  end
end

masses = File.new('input/day01.txt').readlines.map(&:chomp).map(&:to_i)
p masses.map { |m| fuel_required(m) }.sum
p masses.map { |m| total_fuel(m) }.sum
