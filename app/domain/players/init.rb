# frozen_string_literal: true

<<<<<<< HEAD
folders = %w[entities repositories mappers]
folders.each do |folder|
  Dir.glob("#{__dir__}/#{folder}/**/*.rb").each do |file|
    require_relative file
  end
end
=======
# folders = %w[projects contributions]
# folders.each do |folder|
#   require_relative "#{folder}/init"
# end
>>>>>>> 4e9add10aab64f3ce50bbaf5fe6311dd33ec7b11
