# http://codegolf.stackexchange.com/questions/45168/find-the-longest-word-that-can-be-constructed-by-appending-single-letters-to-exi

h={}
open('voc').map{|l|h[l.strip]=1}
v=->w{w<?a||h[w]&&(v[w.chop]||v[w[1..-1]])}
p h.keys.max_by{|w|w.size*(v[w]?1:0)}

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

