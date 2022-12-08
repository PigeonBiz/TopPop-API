# frozen_string_literal: true

require 'roda'
require 'rack'

module TopPop
  # Web App
  class App < Roda
    plugin :halt
    plugin :all_verbs 
    plugin :common_logger, $stderr

    use Rack::MethodOverride 

    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "TopPop API v1 at /api/v1/ in #{App.environment} mode"

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code
        result_response.to_json
      end

      routing.on 'api/v1' do
        routing.on 'search' do
          routing.on String do |search_keyword|
            # GET /search/search_keyword
            routing.get do
              result = Service::SearchVideos.new.call(search_keyword)

              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code

              Representer::Videos.new(
                result.value!.message
              ).to_json
            end
          end    
        end
      end
    end
  end
end
