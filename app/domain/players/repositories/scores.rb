# frozen_string_literal: true

module ScoreInformation
  module Repository
    # Repository for Score Entities
    class Scores
      def self.all
        Database::ScoreOrm.all.map { |db_score| rebuild_entity(db_score) }
      end

      def self.find(entity)
        find_score_id(entity.score_id)
      end

      def self.find_score_id(score_id)
        db_record = Database::ScoreOrm.first(score_id:)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        return nil if find(entity)

        db_score = PersistProject.new(entity).create_score
        rebuild_entity(db_score)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Score.new(
          id: db_record.id,
          id: db_record.player_id,
          name: db_record.score
        )
      end

      # Helper class to persist scores to database
      class PersistProject
        def initialize(entity)
          @entity = entity
        end

        def create_score
          Database::ScoreOrm.create(@entity.to_attr_hash)
        end
      end
    end
  end
end
