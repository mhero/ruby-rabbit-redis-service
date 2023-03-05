# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Endpoint::Client do
  let(:event_response) do
    VCR.use_cassette(
      'endpoint/event',
      match_requests_on: [:body],
      re_record_interval: 30.days
    ) do
      Endpoint::Client.new.request_events
    end
  end

  it 'can fetch & parse character data' do
    expect(event_response).to be_kind_of(Array)
    expect(event_response.count).to eq(3)
    expect(event_response.first).to be_kind_of(Event)
  end
end
