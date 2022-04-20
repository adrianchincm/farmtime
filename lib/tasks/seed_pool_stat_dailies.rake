desc 'Seed pool stat dailies from coindix'
task :seed_pool_stats_dailies => :environment do
    coindix_ids = %w[41149 41178 41180 55832 16745]    
    coindix_ids.each do |id|
        
        url = "https://api.coindix.com/vaults/#{id}?period=365"        
        coindix_response = HTTParty.get(url, headers: { "Authorization" => "Bearer #{Figaro.env.coindix_bearer_token}", "User-Agent" => "PostmanRuntime/7.29.0" }).parsed_response
        series = coindix_response["series"]
        
        series.each do |daily|
            PoolStatDaily.create(name: coindix_response["name"], tvl: daily["tvl"], apy: daily["apy"], created_at: daily["date"])
        end
    end    
end