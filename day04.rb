start = 172_851
ending = 675_869

def adjacent_chars?(password)
  prev = nil
  password.to_s.split('').each do |c|
    return true if c == prev

    prev = c
  end
  false
end

def increasing?(password)
  prev = 0
  password.to_s.split('').each do |n|
    return false if n.to_i < prev

    prev = n.to_i
  end
  true
end

def valid?(password)
  return false if password.to_s.length != 6
  return false unless adjacent_chars?(password)
  return false unless increasing?(password)

  true
end

valid = start.upto(ending).select { |n| valid?(n) }
p(valid.length)
