# frozen_string_literal: true

class MissingDailyStatUpdater < ApplicationService  
    def initialize(coindix_id)
        @coindix_id = coindix_id
    end
  
    def call        
        latest_pool_stat = PoolStatDaily.where(coindix_id: @coindix_id).last        

        url = "https://api.coindix.com/vaults/#{@coindix_id}?period=365"        
        coindix_response = HTTParty.get(url, headers: { "Authorization" => "Bearer #{Figaro.env.coindix_bearer_token}", "User-Agent" => "PostmanRuntime/7.29.0" }).parsed_response
        series = coindix_response["series"]

        seed_dates = series.select {|daily| DateTime.parse(daily["date"]) > latest_pool_stat.created_at}
        
        seed_dates.each do |seed_date|
            PoolStatDaily.create(name: coindix_response["name"], tvl: seed_date["tvl"], apy: seed_date["apy"].to_f * 100, coindix_id: @coindix_id, created_at: seed_date["date"])
        end        
    end
  end
  