require 'fuzzy_finder'

describe FuzzyFinder::Rank do
  it '' do
    matches = [
      FuzzyFinder::Match.new("foobar", "foo", 0),
      FuzzyFinder::Match.new("foobar", "foo", 0),
      FuzzyFinder::Match.new("foobar", "foo", 0),
      FuzzyFinder::Match.new("foobar", "foo", 0),
      FuzzyFinder::Match.new("foobar", "foo", 0),
      FuzzyFinder::Match.new("foobar", "foo", 0)
    ]

    ranked_matches = FuzzyFinder::Rank.rank(matches)
  end
end
