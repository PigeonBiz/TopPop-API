# frozen_string_literal: true

require 'dry/monads'

module TopPop
  module Service
    # Search history score
    class SearchScore
      include Dry::Monads::Result::Mixin

      def call(player_name)
        projects = Repository::For.klass(Entity::score)
          .find_player_score(Player_name)

        Success(projects)
      rescue StandardError
        Failure('Could not access database')
      end
    end
  end
end