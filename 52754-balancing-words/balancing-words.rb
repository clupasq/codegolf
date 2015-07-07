require 'minitest/autorun'

F=
->word {
  string_value = -> str {
    (0...str.size).map{|i|(i+1) * (str[i].ord - 64)}.inject :+
  }

  result = "#{word} DOES NOT BALANCE"

  (0...word.size).map {|i|
    prefix, suffix = word[0...i], word[i+1..-1]
    if string_value[prefix.reverse] == string_value[suffix]
      result = prefix + " #{word[i]} " + suffix
    end
  }

  result
}


describe F do
  def test_cases
    assert_equal 'S T EAD', F['STEAD']
    assert_equal 'CONSUBST A NTIATION', F['CONSUBSTANTIATION']
    assert_equal 'WRO N GHEADED', F['WRONGHEADED']
    assert_equal 'UNINTELL I GIBILITY', F['UNINTELLIGIBILITY']
    assert_equal 'SUPERGLUE DOES NOT BALANCE', F['SUPERGLUE']
  end
end

