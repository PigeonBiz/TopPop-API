# frozen_string_literal: true

module TopPop
  module Repository
    # Repository for Score Entities
    class Scores
      def self.find_id(id)
        rebuild_entity Database::ScoreOrm.first(id:)
      end

      def self.find_player_score(player_name)
        db_player_score = Database::ScoreOrm
          .graph(:player_name, :score, :created_at)
          .where(player_name: player_name)
          .all

        rebuild_entity(db_player_score)
      end

      def self.find_player_last_playdate(player_name)
        db_player_score = Database::ScoreOrm
          .graph(:player_name, :score, :created_at)
          .where(player_name: player_name)
          .last

        rebuild_entity(db_player_score)
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
