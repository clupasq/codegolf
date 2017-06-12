require 'rspec/autorun'

def justify length, text
  non_whitespace = text.delete(' ').size
  word_count = text.split.size-1
  pre, suf = text.split(' ',2)
  return pre if word_count<1
  whitespace_width = ((length.to_f - non_whitespace)/word_count).ceil
  crt = pre + ' '*whitespace_width
  crt+justify(length-crt.size, suf)
end

def fmt max_length, text
  words = text.split /(-| )/
  lines=[]
  crtline=""
  while words.any?
    crt, sep = words.shift 2

    newcrtline = crtline.dup.chomp(?-) + crt + (sep||"")

    if newcrtline.strip.size > max_length
      lines << justify(max_length, crtline)
      crtline = ""
      words.unshift crt,sep
    else
      crtline = newcrtline
    end
  end
  lines<<crtline
end


describe :Justification do

  it "can justify line" do
    expect(justify(10, "It's the")).to eql "It's   the"
    expect(justify(20, "network of Q&A")).to eql "network    of    Q&A"
  end

  describe "splits to fit into lines" do

    it "test case #1" do
      s = fmt 10, "It's the bl-ack be-ast of Araghhhhh-hhh-h-hhh-h-h-h-hh!"
      expect(s).to eql [
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
      expect(s).to eql [
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
      expect(s).to eql [
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
      expect(s).to eql [
        "Programming  Puzzles  &  Code Golf is a question and answer site for programming",
        "puzzle  enthusiasts  and  code golfers. It's built and run by you as part of the",
        "Stack  Exchange  network of Q&A sites. With your help, we're working together to",
        "build a library of programming puzzles and their solutions.",
      ]
    end

  end
end


