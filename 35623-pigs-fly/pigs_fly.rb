# -*- coding: utf-8 -*-
require 'rspec/autorun'

#-------- Utility methods
def print_arg(a)
  name, is_true = a
  "#{is_true ? '' : ?!}#{name}"
end
def print_rule(r)
  premise, conclusion = r
  "#{print_arg(premise)} => #{print_arg(conclusion)}"
end

#-------- Parsing sentences

P=->s{
  n=/(not )?(able to fly|\w+) (is also|are) (not )?(able to fly|\w+)/.match s
  [[n[2],!n[1]],[n[5],!n[4]]]
}

describe '#p' do
  context 'Pig Rule' do
    it 'parses regular expression' do
      P['Pigs are red.'].should eq [['Pigs', true], ['red', true]]
    end
    it 'parses negated expression' do
      P['Pigs are not red.'].should eq [['Pigs', true], ['red', false]]
    end
  end

  context 'Everything Rule' do
    it 'parses regular expression' do
      P['Everything that is red is also blue.'].should eq \
        [['red', true], ['blue', true]]
    end
    it 'parses regular expression' do
      P['Everything that is not red is also blue.'].should eq \
        [['red', false], ['blue', true]]
    end
    it 'parses regular expression' do
      P['Everything that is red is also not blue.'].should eq \
        [['red', true], ['blue', false]]
    end
    it 'parses regular expression' do
      P['Everything that is not red is also not blue.'].should eq \
        [['red', false], ['blue', false]]
    end
  end

  context 'regression' do
    it 'parses sentences' do
      P["Pigs are green"].should eq [['Pigs', true], ['green', true]]
      P[" Everything that is green is also intelligent"].
        should eq [['green', true], ['intelligent', true]]
      P[" Everything that is able to fly is also not intelligent"].
        should eq [['able to fly', true], ['intelligent', false]]
    end
  end
end

#-------- Rule engine

class RuleEngine
  attr_accessor :rules
  attr_accessor :contradictory
  def initialize
    @rules=[]
  end 

  def add_rule(r)
    return if @rules.member?(r)
    rules<<r

    premise, conclusion = r
    #contradiction detection
    @contradictory|=premise[0]==conclusion[0] && premise[1]!=conclusion[1]

    #negated
    add_rule [[conclusion[0],!conclusion[1]],[premise[0],!premise[1]]]

    #inference
    @rules.map{|q|add_rule([q[0],r[1]])if q[1]==r[0]}
  end

  def print_rules
    @rules.each{|r| puts print_rule(r)}
  end
end

describe RuleEngine do
  context 'adding simple rules:' do
    rule = [['pigs', true], ['red', true]]

    it 'registers one rule' do
      subject.add_rule rule
      subject.rules.include?(rule).should be_true
    end
    it 'registers unique rules only' do
      subject.add_rule rule
      subject.add_rule rule
      subject.rules.uniq.should eq subject.rules
    end
  end

  context 'more complex logic:' do
    red_pigs_rule = [['pigs', true], ['red', true]]

    it 'adds the negated equivalent (A=>B -> !B=>!A)' do
      subject.add_rule red_pigs_rule
      negated_inverse_rule = [['red', false], ['pigs', false]]
      subject.rules.include?(negated_inverse_rule).should be_true
    end

    it 'makes inferences' do
      subject.add_rule [['pigs', true], ['red', true]]
      subject.add_rule [['red', true], ['fly', true]]

      subject.rules.include?([['pigs', true], ['fly', true]]).should be_true
    end

    context 'detects contradictory rules' do
      it 'detects direct contradictions' do
        subject.add_rule [['pigs', true], ['red', true]]
        subject.add_rule [['pigs', true], ['red', false]]

        subject.contradictory.should be_true
      end
    end
  end
end

#-------- Putting it all together

def can_pigs_fly?(text)
  re = RuleEngine.new

  sentences = text.split(?.)
  text.split('.').map{|s|re.add_rule P[s]}

  return "Yes" if(re.contradictory||re.rules.member?([['Pigs',true],['able to fly', true]]))
  return "No" if(re.rules.member?([['Pigs',true],['able to fly', false]]))
  return "Maybe"
end

describe '#can_pigs_fly?' do
  it 'detects when pigs do not fly' do
    result = can_pigs_fly?("Pigs are green. Everything that is green is also intelligent. Everything that is able to fly is also not intelligent.")
    result.should eq('No')
  end
  it 'detects when pigs do fly' do
    result = can_pigs_fly?("Pigs are old. Everything that is not able to fly is also not old.")
    result.should eq('Yes')
  end
  it 'detects contradictions' do
    result = can_pigs_fly?("Pigs are not able to fly. Everything that is red is also sweet. Everything that is sweet is also not red.")
    result.should eq('Yes')
  end
  it 'detects inconclusiveness' do
    result = can_pigs_fly?("Everything that is sweet is also not old. Everything that is intelligent is also blue.")
    result.should eq('Maybe')
  end









  it "ad-hoc test" do
    known_data = "Pigs are cool. Everything that is red is also able to fly. Everything that is cool is also not red."
    puts can_pigs_fly?(known_data)
  end
  

end
