require 'Faraday'

class Hackerrank_Challenge
    def topArticles(username, limit)
        # DONE...Get all pages of articles for the user

        # DONE...Sort by num_comments

        # DONE...Map a list of the title names (story_title if null)

        # Limit above list to the input limit
    end

    def getAllArticles(username)
        service = Faraday.new('https://jsonmock.hackerrank.com/api/football_matches')
        current_page = 1
        total_pages = 2
        result = []

        until current_page > total_pages do
            response = service.get do |req|
                req.params['author'] = username
                req.params['page'] = current_page
            end

            parsed_response = JSON.parse(response.body)

            result += parsed_response['data']

            current_page += 1
            total_pages = parsed_response['total_pages']
        end

        result
    end

    def sortArticles(articles)
        articles.sort_by do |article|
            article[:num_comments]
        end.reverse
    end

    def mapTitlesOrStoryTitles(articles)
        articles.map do |article|
            article[:title] || article[:story_title]
        end
    end
end