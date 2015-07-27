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

def print_placement(pl)
  puts pl.scan /.{5}/ 
  puts
end

def solve(animal)
  placements = get_placements animal

  (0..10).map do |i|
    [*0..24].combination(i) do |candidate|
      next if placements.any? { |pl| candidate.all?{ |x| pl[x] > ?X } }

      puts (0...25).map{|i| candidate.include?(i) ? ?X : ?o }.join.scan /.{5}/
      puts
      return 
    end
  end
end

def see_placements(animal)
  get_placements(animal).map {|pl| print_placement pl}
  p get_placements(animal).count
end

# see_placements SASQUATCH

# solve ZEBRA

solve KANGAROO

solve HIPPO

# solve SASQUATCH # takes too long

#  placements = placements.reject {|pl| pl[chosen] < ?o }


# puts (0...25).map{|i| solution.include?(i) ? ?X : ?o }.join.scan /.{5}/

# p heatmap(get_placements(animal))

FACTORIALS = { 0 => 1, 1 => 1 }
def factorial(n)
  FACTORIALS[n] = n * factorial(n - 1) unless FACTORIALS[n]
  FACTORIALS[n]
end
def comb(n, k)
  factorial(n) / ( factorial(n - k) * factorial(k) )
end
def compute_max_number_of_posibilities
  p (0..25).map {|k| comb(25, k) }.reduce :+
end

# compute_max_number_of_posibilities
