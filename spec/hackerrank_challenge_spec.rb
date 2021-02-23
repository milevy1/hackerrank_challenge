require 'hackerrank_challenge'

RSpec.describe Hackerrank_Challenge do
    before :each do
        subject = Hackerrank_Challenge.new
    end

    describe 'topArticles' do
        xit 'should return top N articles by a user' do
            stub_request(:get, /jsonmock/)
                .to_return(status: 200, body: File.read('./spec/mockJson/mockResponse_1page.json'))

            expect(subject.topArticles('olalonde', 1)).to eq("Show HN: This up votes itself")
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
                .to_return(status: 200, body: File.read('./spec/mockJson/mockResponse_2page.json'))

             actual = subject.getAllArticles('olalonde')

             expect(actual.length).to eq(4)
        end
    end

    describe 'sortArticles' do
        it 'should sort a list of articles by the number of comments' do
            article_1 = { "title" => "Article 1", "num_comments" => 1}
            article_2 = { "title" => "Article 2", "num_comments" => 2}
            article_3 = { "title" => "Article 3", "num_comments" => 3}
            articles = [article_1, article_3, article_2]

            actual = subject.sortArticles(articles)

            expect(actual[0]).to eq(article_3)
            expect(actual[1]).to eq(article_2)
            expect(actual[2]).to eq(article_1)
        end

        it 'should treat nil as 0' do
            article_1 = { "title" => "Article 1", "num_comments" => 1}
            article_2 = { "title" => "Article 2", "num_comments" => 2}
            article_3 = { "title" => "Article 3"}
            articles = [article_1, article_3, article_2]

            actual = subject.sortArticles(articles)

            expect(actual[0]).to eq(article_2)
            expect(actual[1]).to eq(article_1)
            expect(actual[2]).to eq(article_3)
        end
    end

    describe 'mapTitlesOrStoryTitles' do
        it 'should return a list of titles' do
            article_1 = { "title" => "Article 1", "num_comments" => 1}
            article_2 = { "title" => "Article 2", "num_comments" => 2}
            article_3 = { "title" => "Article 3", "num_comments" => 3}
            articles = [article_1, article_2, article_3]

            expect(subject.mapTitlesOrStoryTitles(articles)).to eq([
                "Article 1", "Article 2", "Article 3"
            ])
        end

        it 'should return story_title if title is null' do
            article_1 = { "title" => "Article 1", "num_comments" => 1}
            article_2 = { "title" => "Article 2", "num_comments" => 2}
            article_3 = { "story_title" => "Story Title 3", "num_comments" => 3}
            articles = [article_1, article_2, article_3]

            expect(subject.mapTitlesOrStoryTitles(articles)).to eq([
                "Article 1", "Article 2", "Story Title 3"
            ])
        end
    end
end