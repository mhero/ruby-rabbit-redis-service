# frozen_string_literal: true

class Event
  attr_accessor :id, :sell_mode, :title,
                :start_at, :end_at, :external_id, :sell_from, :sell_to, :sold_out,
                :zones, :created_at

  def initialize(attributes)
    self.id = attributes[:base_event_id]
    self.sell_mode = attributes[:sell_mode]
    self.title = attributes[:title]
    self.start_at = attributes.fetch(:event, {}).fetch(:event_start_date, nil)
    self.end_at = attributes.fetch(:event, {}).fetch(:event_end_date, nil)
    self.external_id = attributes.fetch(:event, {}).fetch(:event_id, nil)
    self.sell_from = attributes.fetch(:event, {}).fetch(:sell_from, nil)
    self.sell_to = attributes.fetch(:event, {}).fetch(:sell_to, nil)
    self.sold_out = Bool.parse(attributes.fetch(:event, {}).fetch(:sold_out, nil))
    self.zones = build_zones(attributes.fetch(:event, {}).fetch(:zone, []))
    self.created_at = Time.now.utc
  end

  private

  def build_zones(zones)
    (zones.is_a?(Array) ? zones : [zones]).map do |zone|
      Zone.new(zone)
    end
  end
end
