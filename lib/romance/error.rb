# frozen_string_literal: true

module Romance
  # The Romance error module.
  module Error
  end
end

Dir[File.join(File.dirname(__FILE__), 'error', '*.rb')].each do |fname|
  require_relative fname
end
