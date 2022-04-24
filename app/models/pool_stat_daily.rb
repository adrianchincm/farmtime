class PoolStatDaily < ApplicationRecord
    scope :last_7_days, -> {where("created_at > ?", Time.now-7.days)}    
end
