# frozen_string_literal: true

module TopPop
  module Repository
    # Repository for Score Entities
    class Scores
      def self.find_id(id)
        rebuild_entity Database::ScoreOrm.first(id:)
      end

      def self.find_player_name(player_name)
        rebuild_entity Database::ScoreOrm.all(player_name:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Score.new(
          id: db_record.id,
          player_name: db_record.player_name,
          score: db_record.score
        )
      end

      def self.rebuild_many(db_records)
        db_records.map do |db_member|
          Scores.rebuild_entity(db_member)
        end
      end

      def self.find_or_create(entity)
        Database::ScoreOrm.find_or_create(entity.to_attr_hash)
      end
    end
  end
end
