require 'hackerrank_challenge'

RSpec.describe Hackerrank_Challenge do
    describe 'topArticles' do
        it 'should return top N articles by a user' do
            subject = Hackerrank_Challenge.new
            expect(subject.topArticles('olalonde', 1)).to eq(10)
        end
    end
end