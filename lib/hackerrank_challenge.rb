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
        response = service.get do |req|
            req.params['author'] = username
            req.params['page'] = 1
        end

        parsed_response = JSON.parse(response.body)

        parsed_response['data']
    end
end