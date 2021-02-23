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
                .to_return(status: 200, body: File.read('./spec/mockJson/mockResponse_1page.json'))

            actual = subject.getAllArticles('olalonde')

            expect(actual[0]['title']).to eq("Show HN: This up votes itself")
            expect(actual[1]['title']).to be_nil
            expect(actual[1]['story_title']).to eq("Guacamole – A clientless remote desktop gateway")
        end

        it 'should return all articles for a given user with multiple pages' do
            stub_request(:get, /jsonmock/)
                .to_return(
                    {status: 200, body: File.read('./spec/mockJson/mockResponse_1page.json')},
                    {status: 200, body: File.read('./spec/mockJson/mockResponse_2page.json')},
                )

             actual = subject.getAllArticles('olalonde')

             expect(actual.length).to eq(4)
        end
    end
end