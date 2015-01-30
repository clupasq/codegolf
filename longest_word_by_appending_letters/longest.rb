# http://codegolf.stackexchange.com/questions/45168/find-the-longest-word-that-can-be-constructed-by-appending-single-letters-to-exi

h={}
open('voc').map{|l|h[l.strip]=1}
v=->w,c=[]{w<?a?c:h[w]&&(v[w.chop,z=c+[w]]||v[w[1..-1],z])}
puts h.map{|k,_|(v[k]||[]).reverse.join ?\n}.max_by &:size

# p h.keys.select{|w|v[w]}.compact.first 10


=begin
  
Longest 10:

["brahmanists",
 "franciscans",
 "carabineros",
 "brahmanisms",
 "prestating",
 "prescripts",
 "carabinero",
 "bolivianos",
 "carabiners",
 "brahmanism"]

=end

