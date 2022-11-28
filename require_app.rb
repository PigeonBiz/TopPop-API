# frozen_string_literal: true

# Requires all ruby files in specified app folders
def require_app(folders = %w[application domain infrastructure presentation])
  app_list = Array(folders).map { |folder| "app/#{folder}" }
  full_list = ['config', app_list].flatten.join(',')

  Dir.glob("./{#{full_list}}/**/*.rb").each do |file|
    require file
  end
end
