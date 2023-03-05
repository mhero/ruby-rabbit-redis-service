# frozen_string_literal: true

class Fault
  attr_accessor :code

  def initialize(code)
    self.code = code
  end
end
