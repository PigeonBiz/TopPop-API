# frozen_string_literal: true

module TopPop
  module Repository
    # Repository for Video Entities
    class Videos
      def self.all
        Database::VideoOrm.all.map { |db_video| rebuild_entity(db_video) }
      end

      def self.find(entity)
        find_video_id(entity.video_id)
      end

      def self.find_video_id(video_id)
        db_record = Database::VideoOrm.first(video_id:)
        rebuild_entity(db_record)
      end

      def self.create(entity)
        return nil if find(entity)

        db_video = PersistProject.new(entity).create_video
        rebuild_entity(db_video)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Video.new(
          video_id: db_record.video_id,
          title: db_record.title,
          publish_date: db_record.publish_date,
          channel_title: db_record.channel_title,
          view_count: db_record.view_count,
          like_count: db_record.like_count,
          comment_count: db_record.comment_count
        )
      end

      # Helper class to persist videos to database
      class PersistProject
        def initialize(entity)
          @entity = entity
        end

        def create_video
          Database::VideoOrm.create(@entity.to_attr_hash)
        end
      end
    end
  end
end
