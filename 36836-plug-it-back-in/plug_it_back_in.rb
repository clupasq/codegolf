# x=->s{y,m,d,h=s.scan(/\d+/)
# h=h.to_i-7
# g=Time.new(y,m,d).wday%6<1?0:1*[0..11,4..9].count{|r|r===h}
# %W{Off Mid On}[(5..10)===m.to_i ? g:(3-g)%3]}

# x=->s{y,m,d,h=s.scan /\d+/
# h=h.to_i-7
# g=Time.new(y,m,d).wday%6<1?0:1*[0..11,4..9].count{|r|r===h}
# %W{Off Mid On}[(5..10)===m.to_i ? g:(3-g)%3]}

# x=->s{y,m,d,h=s.scan /\d+/
# h=h.to_i-7
# g=Time.new(y,m,d).wday%6<1?0:[0..11,4..9].count{|r|r===h}
# %W{Off Mid On}[(5..10)===m.to_i ? g:(3-g)%3]}


# x=->s{y,m,d,h=s.scan(/\d+/).map &:to_i
# g=Time.new(y,m,d).wday%6<1?0:[0..11,4..9].count{|r|r===h-7}
# %W{Off Mid On}[m>4&&m<11 ? g:(3-g)%3]}

# x=->s{y,m,d,h=s.scan(/\d+/).map &:to_i
# g=Time.new(y,m,d).wday%6<1?0:[0..11,4..9].count{|r|r===h-7}
# %W{Off Mid On}[m<5||m>10?(3-g)%3:g]}

x=->s{y,m,d,h=s.scan(/\d+/).map &:to_i
g=Time.new(y,m,d).wday%6<1?0:[0..11,4..9].count{|r|r===h-7}
%W{Off Mid On}[m<5||m>10?(3-g)%3:g]}


def assert_equals(x, y, msg)
  fail "Failed: #{msg} (<#{x}> != <#{y}>)" unless x==y
  puts "OK: #{msg}"
end

assert_equals(x['2014-09-01T17:30:02'], 'Mid', 'Summer - evening')
assert_equals(x['2014-11-03T17:30:02'], 'On', 'Winter - evening')

assert_equals(x['2014-09-01T10:30:02'], 'Mid', 'Summer - morning')
assert_equals(x['2014-11-03T10:30:02'], 'On', 'Winter - morning')

assert_equals(x['2014-09-01T12:30:02'], 'On', 'Summer - afternoon')
assert_equals(x['2014-11-03T12:30:02'], 'Mid', 'Winter - afternoon')

assert_equals(x['2014-09-01T00:30:02'], 'Off', 'Summer - night')
assert_equals(x['2014-11-03T00:30:02'], 'Off', 'Winter - night')

assert_equals(x['2014-09-06T17:30:02'], 'Off', 'Summer - weekend evening')
assert_equals(x['2014-11-01T17:30:02'], 'Off', 'Winter - weekend evening')

assert_equals(x['2014-09-06T10:30:02'], 'Off', 'Summer - weekend morning')
assert_equals(x['2014-11-01T10:30:02'], 'Off', 'Winter - weekend morning')

