# frozen_string_literal: true

require 'roda'
require 'rack'

module TopPop
  # Web App
  class App < Roda
    plugin :halt
    plugin :caching
    plugin :all_verbs
    plugin :common_logger, $stderr

    use Rack::MethodOverride

    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "TopPop API v1 at /api/v1/ in #{App.environment} mode"

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message:)
        )

        response.status = result_response.http_status_code
        result_response.to_json
      end

      routing.on 'api/v1' do
        routing.on 'search' do
          routing.is do
            # GET /search
            routing.get do
              response.cache_control public: true, max_age: 300
              get_all_video = Service::AllVideos.new.call

              if get_all_video.failure?
                failed = Representer::HttpResponse.new(get_all_video.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(get_all_video.value!)
              response.status = http_response.http_status_code

              Representer::Videos.new(
                get_all_video.value!.message
              ).to_json
            end
          end

          routing.on String do |search_keyword|
            # GET /search/search_keyword
            routing.get do
              search_result = Service::SearchVideos.new.call(search_keyword)

              if search_result.failure?
                failed = Representer::HttpResponse.new(search_result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(search_result.value!)
              response.status = http_response.http_status_code

              Representer::Videos.new(
                search_result.value!.message
              ).to_json
            end
          end
        end

        routing.on 'add' do
          routing.on String do |video_id|
            # GET /add/video_id
            routing.get do
              add_result = Service::AddVideo.new.call(video_id)

              if add_result.failure?
                failed = Representer::HttpResponse.new(add_result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(add_result.value!)
              response.status = http_response.http_status_code
              http_response.to_json
            end
          end
        end

        routing.on 'delete' do
          routing.on String do |video_id|
            # GET /delete/video_id
            routing.get do
              delete_result = Service::DeleteVideo.new.call(video_id)

              if delete_result.failure?
                failed = Representer::HttpResponse.new(delete_result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(delete_result.value!)
              response.status = http_response.http_status_code
              http_response.to_json
            end
          end
        end

        routing.on 'test' do
          Messaging::Queue
            .new(App.config.QUEUE_URL, App.config)
            .send('TopPop')

          message = 'Sent message to queue. Check the worker console.'

          result_response = Representer::HttpResponse.new(
            Response::ApiResult.new(status: :ok, message:)
          )

          response.status = result_response.http_status_code
          result_response.to_json
        end
      end
    end
  end
end
