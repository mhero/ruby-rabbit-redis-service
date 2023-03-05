# frozen_string_literal: true

require 'spec_helper'
require 'rack/test'

RSpec.describe Event do
  subject { described_class.new(attributes) }

  context 'valid attributes' do
    let(:attributes) do
      {
        base_event_id: '291',
        sell_mode: 'online',
        title: 'Camela en concierto',
        event: {
          event_start_date: '2021-06-30T21:00:00',
          event_end_date: '2021-06-30T21:30:00',
          event_id: '291',
          sell_from: '2020-07-01T00:00:00',
          sell_to: '2021-06-30T20:00:00',
          sold_out: 'false',
          zone: [
            { zone_id: '40', capacity: '200', price: '20.00', name: 'Platea', numbered: 'true' },
            { zone_id: '38', capacity: '0', price: '15.00', name: 'Grada 2', numbered: 'false' },
            { zone_id: '30', capacity: '80', price: '30.00', name: 'A28', numbered: 'true' }
          ]
        }
      }
    end

    it 'builds event with valid attributes' do
      expect(subject).to have_attributes(
        id: '291',
        sell_mode: 'online',
        title: 'Camela en concierto',
        start_at: '2021-06-30T21:00:00',
        end_at: '2021-06-30T21:30:00',
        external_id: '291',
        sell_from: '2020-07-01T00:00:00',
        sell_to: '2021-06-30T20:00:00',
        sold_out: false
      )
      expect(subject.zones).to match_array([
                                             have_attributes(
                                               id: '40', capacity: 200, price: '20.00', name: 'Platea', numbered: true
                                             ),
                                             have_attributes(
                                               id: '38', capacity: 0, price: '15.00', name: 'Grada 2', numbered: false
                                             ),
                                             have_attributes(
                                               id: '30', capacity: 80, price: '30.00', name: 'A28', numbered: true
                                             )
                                           ])
    end
  end

  context 'partial attributes' do
    let(:attributes) do
      {
        base_event_id: '291',
        sell_mode: 'online',
        title: 'Camela en concierto'
      }
    end

    it 'builds event with valid attributes' do
      expect(subject).to have_attributes(
        id: '291',
        sell_mode: 'online',
        title: 'Camela en concierto',
        start_at: nil,
        end_at: nil,
        external_id: nil,
        sell_from: nil,
        sell_to: nil,
        sold_out: false
      )

      expect(subject.zones).to be_empty
    end
  end
end
