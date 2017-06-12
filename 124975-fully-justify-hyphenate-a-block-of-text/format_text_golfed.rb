require 'minitest/autorun'
require_relative '../test_utils'

def fmt m,t
#--------------
  j=->(l,t){
    n=t.delete(' ').size
    c=t.split.size-1
    x,y=t.split ' ',2
    return x if c<1
    w=((l.to_f-n)/c).ceil
    d=x+' '*w
    d+j[l-d.size,y]
  }
  w=t.split /(-| )/
  l=[]
  c=""
  while w.any?
    d,s=w.shift 2
    n=c.dup.chomp(?-)+d+(s||"")
    if n.strip.size>m
      l<<j[m,c]
      c=""
      w.unshift d,s
    else
      c=n
    end
  end
  l<<c
#--------------
end


describe :Justification do

  describe "splits to fit into lines" do

    it "test case #1" do
      s = fmt 10, "It's the bl-ack be-ast of Araghhhhh-hhh-h-hhh-h-h-h-hh!"
      assert_equal s, [
        "It's   the",
        "black  be-",
        "ast     of",
        "Araghhhhh-",
        "hhhhhhhhh-",
        "hhh!",
      ]
    end

    it "test case #2" do
      s = fmt 5, "a b c d e f g h i j k l mm nn oo p-p qq rr ss t u vv ww x yy z"
      assert_equal s, [
        "a b c",
        "d e f",
        "g h i",
        "j k l",
        "mm nn",
        "oo pp",
        "qq rr",
        "ss  t",
        "u  vv",
        "ww  x",
        "yy z",
      ]
    end

    it "test case #3" do
      s = fmt 20, "Pro-gram-ming Puz-zles & Code Golf is a ques-tion and ans-wer site for pro-gram-ming puz-zle enth-usi-asts and code golf-ers. It's built and run by you as part of the St-ack Exch-ange net-work of Q&A sites. With your help, we're work-ing to-g-et-her to build a lib-rary of pro-gram-ming puz-zles and their sol-ut-ions."
      assert_equal s, [
        "Programming  Puzzles",
        "&  Code  Golf  is  a",
        "question  and answer",
        "site for programming",
        "puzzle   enthusiasts",
        "and   code  golfers.",
        "It's  built  and run",
        "by  you  as  part of",
        "the  Stack  Exchange",
        "network    of    Q&A",
        "sites.   With   your",
        "help,  we're working",
        "together  to build a",
        "library  of program-",
        "ming   puzzles   and",
        "their solutions.",
      ]
    end

    it "test case #3" do
      s = fmt 80, "Pro-gram-ming Puz-zles & Code Golf is a ques-tion and ans-wer site for pro-gram-ming puz-zle enth-usi-asts and code golf-ers. It's built and run by you as part of the St-ack Exch-ange net-work of Q&A sites. With your help, we're work-ing to-g-et-her to build a lib-rary of pro-gram-ming puz-zles and their sol-ut-ions."
      assert_equal s, [
        "Programming  Puzzles  &  Code Golf is a question and answer site for programming",
        "puzzle  enthusiasts  and  code golfers. It's built and run by you as part of the",
        "Stack  Exchange  network of Q&A sites. With your help, we're working together to",
        "build a library of programming puzzles and their solutions.",
      ]
    end

  end
end


print_size_stats :fmt

