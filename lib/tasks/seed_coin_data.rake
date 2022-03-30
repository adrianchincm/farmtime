desc 'Seeds existing coins with metadata'
task :seed_coin_data => :environment do
  coins = Coin.all

  coins.each do |coin|
    id = coin.coingecko_id
    case id
    when "osmosis"
        coin.name = "Osmosis"
        coin.symbol = "OSMO"
    when "terra-luna"
        coin.name = "Luna"
        coin.symbol = "LUNA"
    when "cosmos"
        coin.name = "Atom"
        coin.symbol = "ATOM"
    when "usd-coin"
        coin.name = "USDC"
        coin.symbol = "USDC"
    when "fantom"
        coin.name = "Fantom"
        coin.symbol = "FTM"
    when "ethereum"
        coin.name = "Ethereum"
        coin.symbol = "ETH"
    when "bitcoin"
        coin.name = "Bitcoin"
        coin.symbol = "BTC"
    when "terrausd"
        coin.name = "UST"
        coin.symbol = "UST"    
    end

    coin.save
  end
end