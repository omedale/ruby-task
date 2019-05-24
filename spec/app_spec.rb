require_relative '../lib/app.rb'
describe App do
  context 'Calling get_campaign_discrepancies' do
    it "showuld response with JSON body containing expected DiscrepancyDetector attributes" do
      campaigns = App.get_campaign_discrepancies
      expect { App.get_campaign_discrepancies }.not_to raise_exception
      expect(campaigns.count).to eq(3)
      expect(campaigns.first.keys).to match_array([:discrepancies, :remote_reference])
    end
  end
end