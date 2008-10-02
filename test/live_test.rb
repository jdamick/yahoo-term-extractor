$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'test/unit'
require 'yahoo-term-extractor'


RAILS_ROOT = File.dirname(__FILE__) unless defined?(RAILS_ROOT)

class LiveTest < Test::Unit::TestCase
  def test_get_terms
#    results = Yahoo::TermExtractor.get_terms(
text = 'Diabetes treatment plans consist of a healthy diet, exercise, medications and sleep'
#text = "i testd this morning  and it was positive but than it disappeared in 20 mins. Is it still positive? and than i testd again later this mornin and it waas very very faint and it wasnt pink it was ghost like but it appeared before the 5 mins. Am i pregnant?"
    results = Yahoo::TermExtractor.find_terms(text)
    require 'pp'
    pp results
    assert_not_nil results
  end
end
