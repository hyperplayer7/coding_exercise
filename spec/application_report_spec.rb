require_relative './../app/application_report'

RSpec.describe ApplicationReport do
  let(:service) { described_class.new('applications.json') }
  let(:expected_response) do
    {
      0=>1,
      1=>3,
      2=>2,
      3=>3,
      4=>1,
      5=>2,
      6=>1,
      7=>1,
      8=>1,
      9=>4,
      10=>3,
      11=>4,
      12=>3,
      13=>4,
      14=>2,
      15=>3,
      16=>2,
      17=>3,
      18=>3,
      19=>3,
      20=>3,
      21=>4,
      22=>1,
      23=>3
    }
  end

  it 'returns the averages by hour' do
    expect(service.retrieve_trend('all')).to eq expected_response
  end

  it 'returns the total count for all' do
    expect(service.check_count('all')).to eq 189
  end

  it 'returns the total count for nil' do
    expect(service.check_count).to eq 189
  end

  it 'returns the total count for epmty' do
    expect(service.check_count('')).to eq 189
  end

  it 'returns the total count for sales' do
    expect(service.check_count('sales')).to eq 64
  end

  it 'returns the total count for website' do
    expect(service.check_count('website')).to eq 64
  end

  it 'returns the total count for qr' do
    expect(service.check_count('qr')).to eq 61
  end
end
