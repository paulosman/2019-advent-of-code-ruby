def orbits(file)
  File.readlines(file).map(&:chomp)
end

distances = {}
orbited = {}
orbiting = {}

orbits('input/day06.txt').each do |orbit|
  orbitee, orbiter = orbit.split(')')
  unless orbited.key? orbitee
    orbited[orbitee] = []
  end
  orbited[orbitee] << orbiter
  orbiting[orbiter] = orbitee
end

orbiting.each do |key, object|
  if key == 'COM'
    distances[object] = 1
    next
  end

  orbited[object].each do |orbiting_object|
    tmp = orbiting_object
    distance = 0
    while true
      tmp = orbiting[tmp]
      distance += 1
      break if tmp == 'COM'
    end
    distances[orbiting_object] = distance
  end
end

p(distances.values.reduce(:+))
