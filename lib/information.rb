# frozen_string_literal: true

module CodePraise
  # Model for Information
  class Information
    def initialize(information_data, data_source)
      @information = information_data
      @data_source = data_source
    end

    def name
      @information['name']
    end

    def birthday
      @information['birthday']
    end

    def email
      @information['email']
    end

    def friends_total_count
      @information['friends_total_count']
    end
  end
end
