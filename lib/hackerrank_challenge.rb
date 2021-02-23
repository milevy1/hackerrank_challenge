require 'Faraday'

class Hackerrank_Challenge
    def topArticles(username, limit)
        # Get all pages of articles for the user

        # Sort by num_comments

        # Map a list of the title names (story_title if null)

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
end