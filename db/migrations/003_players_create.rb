# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:players) do
      primary_key :id

      String      :name, unique: true, null: false
      Integer     :score, null: false

      DateTime :created_at
    end
  end
end
