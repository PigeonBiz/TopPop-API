# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:daily_videos) do
      primary_key :id

      String      :video_id, unique: true, null: false
      String      :title
      String      :publish_date
      String      :channel_title
      Bigint      :view_count, null: false
      Bigint      :like_count
      Integer     :comment_count
      Integer     :ranking

      DateTime  :created_at
      DateTime  :updated_at
    end
  end
end
