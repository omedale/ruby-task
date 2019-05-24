require_relative 'application_service'
require_relative 'discrepancy_detector'

class App
  def self.get_campaign_discrepancies
    DiscrepancyDetector.call
  end
end

p App.get_campaign_discrepancies
