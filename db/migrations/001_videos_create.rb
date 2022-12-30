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
      Bigint      :view_count, null: false
      String      :thumbnail_url

      DateTime  :created_at
      DateTime  :updated_at
    end
  end
end
