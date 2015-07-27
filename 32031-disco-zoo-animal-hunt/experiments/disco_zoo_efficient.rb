require 'pp'
require_relative 'animals'

SIZE = 5

def get_placements(animal)
  linear_animal = animal.join(?o*(SIZE - animal[0].size))
  d = SIZE*SIZE
  (0..d-linear_animal.size)
    .select{|i| i/5 == (i+animal[0].size-1)/5} # to avoid wrap-around positions
    .map { |i|
      (?o*i + linear_animal + ?o*d)[0...d]
    }
end

def heatmap(placements)
  placements[0].size.times.map do |i|
    placements.count {|p|p[i] < ?o}
  end
end

animal = WOOLY_RHINO

placements = get_placements animal
solution = []

while placements.any?
  h = heatmap(placements)

  solution << chosen = h.index(h.max)

  placements = placements.reject {|pl| pl[chosen] < ?o }
end

puts (0...25).map{|i| solution.include?(i) ? ?X : ?o }.join.scan /.{5}/

# p heatmap(get_placements(animal))
