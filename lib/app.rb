require 'rest-client'
require 'json'
require_relative 'application_service.rb'
require_relative 'discrepancy_detector.rb'


class App < ApplicationService
  def self.get_campaign_discrepancies
    DiscrepancyDetector.call
  end
end

# App.get_campaign_discrepancies
