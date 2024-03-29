# Represents a cartesian coordinate
Coordinate = Struct.new(:x, :y) do
  def clone
    Coordinate.new(x, y)
  end
end

def wire_paths(file)
  File.new(file).readlines.map(&:chomp).map { |p| p.split(',') }
end

def distance(point1, point2)
  (point1.x - point2.x).abs + (point1.y - point2.y).abs
end

def direction(move)
  move[0]
end

def amount(move)
  move[1, move.length].to_i
end

def move_function(direction)
  func = {
    R: ->(c) { Coordinate.new(c.x + 1, c.y) },
    L: ->(c) { Coordinate.new(c.x - 1, c.y) },
    U: ->(c) { Coordinate.new(c.x, c.y + 1) },
    D: ->(c) { Coordinate.new(c.x, c.y - 1) }
  }
  func[direction.to_sym]
end

def record_moves(wire)
  locations = [Coordinate.new(0, 0)]
  path = Hash.new(0)
  steps = 1
  wire.each do |step|
    1.upto(amount(step)) do
      locations << move_function(direction(step)).call(locations.last)
      path[locations.last] = steps
      steps += 1
    end
  end
  path
end

def find_intersections(moves_one, moves_two)
  moves_one.map do |coord, steps|
    [coord, steps + moves_two[coord]] if moves_two.key? coord
  end.reject(&:nil?)
end

wires = wire_paths('input/day03.txt')
moves_one = record_moves(wires[0])
moves_two = record_moves(wires[1])

intersections = find_intersections(moves_one, moves_two)

distances = intersections.map do |intersection|
  distance(intersection[0], Coordinate.new(0, 0))
end

p("Intersections: #{intersections}")
p("Distance of intersection closest to 0, 0: #{distances.min}")

steps = intersections.map do |intersection|
  intersection[1]
end

p("Steps for each intersection: #{steps}")
p(steps.min)
