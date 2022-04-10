desc 'Creates demo portfolio and pools'
task :seed_demo_portfolio_pools => :environment do
  portfolio = Portfolio.create(terra_address: "demo", fantom_address: "demo", osmosis_address: "demo", ref_finance_shares: {"btceth" => "0.0"}, name: "demo")

  Pool.create(tokens: ["osmosis", "terrausd"], name: "OSMO-UST", pool_owner: "Osmosis", current_price: 1234.56, initial_capital: 900, portfolio_id: portfolio.id)
  Pool.create(tokens: ["terra-luna", "terrausd"], name: "LUNA-UST", pool_owner: "Osmosis", current_price: 1234.56, initial_capital: 1100, portfolio_id: portfolio.id)
  Pool.create(tokens: ["cosmos", "osmosis"], name: "ATOM-OSMO", pool_owner: "Osmosis", current_price: 1234.56, initial_capital: 1800, portfolio_id: portfolio.id)
  Pool.create(tokens: ["usd-coin", "fantom", "bitcoin", "ethereum"], name: "Late Quartet", pool_owner: "BeethovenX", current_price: 1234.56, initial_capital: 1200, portfolio_id: portfolio.id)
  Pool.create(tokens: ["bitcoin", "ethereum"], name: "BTC-ETH", pool_owner: "Ref Finance", current_price: 1234.56, initial_capital: 1300, portfolio_id: portfolio.id)
  Pool.create(tokens: ["wrapped-steth", "terrausd"], name: "STETH-UST", pool_owner: "Astroport", current_price: 1234.56, initial_capital: 500, portfolio_id: portfolio.id)

  pools = Pool.where(portfolio_id: portfolio.id)

  pools.each do |pool|
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 01 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 02 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 03 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 04 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 05 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 06 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 07 Apr 2022 14:34:50.557931000 UTC +00:00")
    PoolDaily.create(pool_id: pool.id, current_price: rand(500..1500), portfolio_id: portfolio.id, created_at: "Wed, 08 Apr 2022 14:34:50.557931000 UTC +00:00")    
  end
end