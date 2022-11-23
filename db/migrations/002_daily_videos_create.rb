# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:daily_videos) do
      primary_key :id
      foreign_key :vid_id, :videos

      Integer     :ranking, null: false

      DateTime  :created_at
    end
  end
end
