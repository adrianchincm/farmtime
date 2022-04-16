desc 'Seed pool stats'
task :seed_pool_stats => :environment do
    PoolStat.create(tokens: ["cosmos","osmosis"], pool_owner: "Osmosis", coindix_id: "41149")
    PoolStat.create(tokens: ["osmosis","terrausd"], pool_owner: "Osmosis", coindix_id: "41178")
    PoolStat.create(tokens: ["osmosis","terrausd"], pool_owner: "Osmosis", coindix_id: "41178")
    PoolStat.create(tokens: ["wrapped-steth","terrausd"], pool_owner: "Astroport", coindix_id: "55832")
    PoolStat.create(tokens: ["usd-coin","fantom","bitcoin","ethereum"], pool_owner: "BeethovenX", coindix_id: "16745")  
end