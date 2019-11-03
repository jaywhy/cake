class FuzzyFinder
  attr_reader :matches

  def initialize(list)
    @list = list
    @matches = list.map {|l| FuzzyFinder::Match.new(l)}.reverse
  end

  def search(search_string, algorithm = FuzzyFinder::AlgoV1)
    algorithm.run(@list, search_string)
  end
end


class FuzzyFinder
  Match = Struct.new(:string, :sidx, :eidx, :rank)
end

class FuzzyFinder
  module AlgoV1
    def self.run(list, search_string)
      list.map do |list_item|
        match = list_item.match(/#{search_string.split('').join('.*?')}/)
        Match.new(list_item, match.pre_match.length, match.pre_match.length + match[0].length) if match
      end.compact.sort do |a, b|
        (b.eidx - b.sidx) + (b.string.length * 0.1) + b.sidx <=> (a.eidx - a.sidx) + (a.string.length * 0.1) + a.sidx
      end
    end
  end
end
