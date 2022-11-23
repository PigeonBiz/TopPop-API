# frozen_string_literal: true

require 'sequel'

<<<<<<< HEAD
module TopPop
=======
module PlayerInformation
>>>>>>> 4e9add10aab64f3ce50bbaf5fe6311dd33ec7b11
  # Model for Database
  module Database
    # Object-Relational Mapper for Scores
    class ScoreOrm < Sequel::Model(:scores)
      many_to_one :player,
                  class: :'PlayerInformation::Database::PlayerOrm'

      plugin :timestamps, update_on_create: true

      def self.find_or_create(score_info)
        first(player_name: score_info[:player_name]) || create(score_info)
      end
    end
  end
end
