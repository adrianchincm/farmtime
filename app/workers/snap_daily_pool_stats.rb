require 'sidekiq-scheduler'

class SnapDaily
  include Sidekiq::Worker

  def perform()    
    url = "https://api.coindix.com/vaults/#{vault}"

    vault_response = HTTParty.get(url, headers: { "Authorization" => "Bearer 2bf7194308fca6bc77e14d43d3d3e555c2d6bda9", "User-Agent" => "PostmanRuntime/7.29.0" }).parsed_response
    end    
  end
end