# frozen_string_literal: true

class Zone
  attr_accessor :id, :capacity, :price, :name, :numbered

  def initialize(attributes)
    self.id = attributes[:zone_id]
    self.capacity = attributes[:capacity].to_i
    self.price = attributes[:price]
    self.name = attributes[:name]
    self.numbered = Bool.parse(attributes[:numbered])
  end
end
