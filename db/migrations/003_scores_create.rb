# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:scores) do
      primary_key :id

      Integer     :player_name, null: false
      Integer     :score, null: false

      DateTime :created_at
    end
  end
end
