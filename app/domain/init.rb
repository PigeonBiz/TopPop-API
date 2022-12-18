# frozen_string_literal: true

folders = %w[players videos]
folders.each do |folder|
  require_relative "#{folder}/init"
end