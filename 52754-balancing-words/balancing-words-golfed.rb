require 'minitest/autorun'

F=->s{v=->s{(0...s.size).map{|i|(i+1)*(s[i].ord-64)}.inject :+}
r="#{s} DOES NOT BALANCE"
(0...s.size).map{|i|b,a=s[0...i],s[i+1..-1]
v[b.reverse]==v[a]&&r=b+" #{s[i]} "+a}
r}

describe F do
  def test_cases
    assert_equal 'S T EAD', F['STEAD']
    assert_equal 'CONSUBST A NTIATION', F['CONSUBSTANTIATION']
    assert_equal 'WRO N GHEADED', F['WRONGHEADED']
    assert_equal 'UNINTELL I GIBILITY', F['UNINTELLIGIBILITY']
    assert_equal 'SUPERGLUE DOES NOT BALANCE', F['SUPERGLUE']
  end
end