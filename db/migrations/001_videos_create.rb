# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:videos) do
      primary_key :id

      String      :video_id, unique: true, null: false
      String      :title
      String      :publish_date
      String      :channel_title
      Integer     :view_count, null: false
      Integer     :like_count
      Integer     :comment_count

      DateTime  :created_time
      DateTime  :updated_time
    end
  end
end
