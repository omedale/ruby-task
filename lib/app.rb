require_relative 'application_service.rb'
require_relative 'discrepancy_detector.rb'

class App
  def self.get_campaign_discrepancies
    DiscrepancyDetector.call
  end
end

p App.get_campaign_discrepancies
