desc 'Seed pool stats'
task :seed_pool_stats => :environment do
    PoolStat.where(tokens: ["cosmos","osmosis"], pool_owner: "Osmosis", coindix_id: "41149").first_or_create
    PoolStat.where(tokens: ["osmosis","terrausd"], pool_owner: "Osmosis", coindix_id: "41178").first_or_create
    PoolStat.where(tokens: ["terra-luna","terrausd"], pool_owner: "Osmosis", coindix_id: "41180").first_or_create
    PoolStat.where(tokens: ["wrapped-steth","terrausd"], pool_owner: "Astroport", coindix_id: "55832").first_or_create
    PoolStat.where(tokens: ["usd-coin","fantom","bitcoin","ethereum"], pool_owner: "BeethovenX", coindix_id: "16745").first_or_create
    PoolStat.where(tokens: ["wrapped-steth","terrausd"], pool_owner: "Spectrum Finance", farmtime_id: "spectrum-finance-wsteth-ust", vault_provider: "spectrum_finance").first_or_create
end