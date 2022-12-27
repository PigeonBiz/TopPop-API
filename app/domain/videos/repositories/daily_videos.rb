# frozen_string_literal: true

module TopPop
  module Repository
    # Repository for Video Entities
    class DailyVideos
      def self.all
        Database::DailyVideoOrm.all.map { |db_video| rebuild_entity(db_video) }
      end

      def self.get_random_video
        max = Database::VideoOrm.all.length()
        min = 1
        random_video_db_id = rand(min...max)
        video_entity = Database::VideoOrm.all[random_video_db_id]
      end

      def self.build_entity(video_entity)
        BuildEntity.new(video_entity).build_entity
      end

      # Extracts entity specific elements from video enitity
      class BuildEntity
        def initialize(video_entity)
          @video_entity = video_entity
        end

        def build_entity
          Entity::Video.new(
            video_id:,
            title:,
            publish_date:,
            channel_title:,
            view_count:
          )
        end

        private

        def video_id
          @video_entity.video_id
        end

        def title
          @video_entity.title
        end

        def publish_date
          @video_entity.publish_date
        end

        def channel_title
          @video_entity.channel_title
        end

        def view_count
          @video_entity.view_count
        end
      end

      def self.find(entity)
        find_video_id(entity.video_id)
      end

      def self.find_video_id(video_id)
        db_record = Database::DailyVideoOrm.first(video_id:)
        rebuild_entity(db_record)
      end

      def self.find_video_ids(video_ids)
        video_ids.map { |video_id| find_video_id(video_id) }
      end

      def self.create(entity)
        return nil if find(entity)

        db_video = PersistVideo.new(entity).create_video
        rebuild_entity(db_video)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::DailyVideo.new(
          db_record.to_hash.merge(
            original_video: Videos.rebuild_entity(db_record),
            ranking: db_record.ranking
          )
        )
      end

      # Helper class to persist daily videos to database
      class PersistVideo
        def initialize(entity)
          @entity = entity
        end

        def create_video
          Database::DailyVideoOrm.create(@entity.to_attr_hash)
        end
      end
    end
  end
end
