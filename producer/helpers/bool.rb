# frozen_string_literal: true

class Bool
  def self.parse(bool_or_string)
    bool_or_string.to_s == 'true'
  end
end
