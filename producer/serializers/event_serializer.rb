# frozen_string_literal: true

class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :sell_mode, :title,
             :start_at, :end_at, :external_id, :sell_from, :sell_to, :sold_out,
             :zones, :created_at
end
