class PoolStat < ApplicationRecord    
    VAULTS = %w[41149 41178 41180 55832 16745].freeze
    FARMTIME_VAULTS = %w[ref-finance-btc-eth].freeze
    has_many :pools
end
