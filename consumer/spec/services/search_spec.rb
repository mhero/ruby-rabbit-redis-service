# frozen_string_literal: true

RSpec.describe Search do
  subject do
    described_class.new(
      redis_client,
      start_at,
      end_at,
      offset:,
      limit:
    ).call
  end

  let(:redis_client) { Redis.new }
  let(:offset) { 0 }
  let(:limit) { 2 }

  let(:payload) do
    '{"data":[{"id":"291","type":"event","attributes":{"id":"291","sell_mode":"online","title":"Camela en concierto","start_at":"2021-06-30T21:00:00","end_at":"2021-06-30T21:30:00","external_id":"291","sell_from":"2020-07-01T00:00:00","sell_to":"2021-06-30T20:00:00","sold_out":false,"zones":[{"id":"40","capacity":200,"price":"20.00","name":"Platea","numbered":true},{"id":"38","capacity":0,"price":"15.00","name":"Grada 2","numbered":false},{"id":"30","capacity":80,"price":"30.00","name":"A28","numbered":true}],"created_at":"2023-01-05T10:03:07.720Z"}},
    {"id":"1591","type":"event","attributes":{"id":"1591","sell_mode":"online","title":"Los Morancos","start_at":"2021-07-31T20:00:00","end_at":"2021-07-31T21:00:00","external_id":"1642","sell_from":"2021-06-26T00:00:00","sell_to":"2021-07-31T19:50:00","sold_out":false,"zones":[{"id":"186","capacity":0,"price":"75.00","name":"Amfiteatre","numbered":true},{"id":"186","capacity":12,"price":"65.00","name":"Amfiteatre","numbered":false}],"created_at":"2023-01-05T10:03:07.720Z"}},
    {"id":"444","type":"event","attributes":{"id":"444","sell_mode":"offline","title":"Tributo a Juanito Valderrama","start_at":"2021-09-30T20:00:00","end_at":"2021-09-30T20:00:00","external_id":"1642","sell_from":"2021-02-10T00:00:00","sell_to":"2021-09-31T19:50:00","sold_out":false,"zones":[{"id":"7","capacity":22,"price":"65.00","name":"Amfiteatre","numbered":false}],"created_at":"2023-01-05T10:03:07.720Z"}}]}'
  end

  describe '#call' do
    before do
      Store.new(client: redis_client).save(payload:)
    end

    context 'between 2021-06-20 and 2021-07-01' do
      let(:start_at) { '2021-06-20T17:32:28Z' }
      let(:end_at) { '2021-07-01T17:32:28Z' }

      it 'returns only the events between the dates' do
        expect(subject.count).to eq 1
        expect(JSON.parse(subject.first)['id']).to eq '291'
      end
    end

    context 'between 2021-06-20 and 2021-07-01' do
      let(:start_at) { '2021-06-20T17:32:28Z' }
      let(:end_at) { '2021-08-01T17:32:28Z' }

      it 'returns only the events between the dates' do
        expect(subject.count).to eq 2
        expect(JSON.parse(subject.first)['id']).to eq '291'
        expect(JSON.parse(subject.last)['id']).to eq '1591'
      end
    end
  end
end
