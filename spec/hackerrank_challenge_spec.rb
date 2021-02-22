require 'hackerrank_challenge'

RSpec.describe Hackerrank_Challenge do
    before :each do
        subject = Hackerrank_Challenge.new
    end

    describe 'topArticles' do
        xit 'should return top N articles by a user' do
            expect(subject.topArticles('olalonde', 1)).to eq(10)
        end
    end

    describe 'getAllArticles' do
        it 'should return all articles for a given user if only 1 page' do
             stub_request(:get, /jsonmock/)
                .to_return(status: 200, body: File.read('mockResponse_1page.json'))

            expect(subject.getAllArticles('olalonde')).to eq(["Show HN: This up votes itself"])
        end
    end
end