require 'rest-client'
require 'json'

class DiscrepancyDetector < ApplicationService
  def initialize
    @url = 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
    @local_campaigns = JSON.parse(File.read('data/campaigns.json'))
    set_remote_campaigns
  end

  def call
    build_discrepancies
  end

  private

  def set_remote_campaigns
    response = RestClient.get(@url)
    if (response.code == 200) 
      remote = JSON.parse(response)
      @remote_campaigns = remote['ads']
    end
  end

  def build_discrepancies
    remote_ids = @remote_campaigns.map{|campaign| campaign['reference']}

    output = []
    @remote_campaigns.each do |remote_campaign|
      data = {remote_reference: remote_campaign['reference']}

      local_campaign = @local_campaigns.find{ |local| 
        local['external_reference'] == remote_campaign['reference'].to_s
      }

      data[:discrepancies] = []
      has_status_descrepancy = local_campaign && local_campaign['status'] !=
                               remote_campaign['status']
      has_description_descrepancy = local_campaign && local_campaign['ad_description'] !=
                                     remote_campaign['description']

      data[:discrepancies] << { status: { remote: remote_campaign['status'], local: local_campaign['status'] } }  if has_status_descrepancy
      data[:discrepancies] << { description: { remote: remote_campaign['description'], local: local_campaign['ad_description']} } if has_description_descrepancy
      output << data
    end
    
    output
  end
end