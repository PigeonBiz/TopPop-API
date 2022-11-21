# frozen_string_literal: true

module PlayerInformation
  module Repository
    # Repository for Player Entities
    class Players
      def self.all
        Database::PlayerOrm.all.map { |db_player| rebuild_entity(db_player) }
      end

      def self.find(entity)
        find_player_id(entity.player_id)
      end

      def self.find_player_id(player_id)
        db_record = Database::PlayerOrm.first(player_id:)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        return nil if find(entity)

        db_player = PersistVideo.new(entity).create_player
        rebuild_entity(db_player)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Player.new(
          id: db_record.id,
          name: db_record.name
        )
      end

      # Helper class to persist players to database
      class PersistVideo
        def initialize(entity)
          @entity = entity
        end

        def create_player
          Database::PlayerOrm.create(@entity.to_attr_hash)
        end
      end
    end
  end
end
