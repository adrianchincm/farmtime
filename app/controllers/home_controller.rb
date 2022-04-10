require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @pools = Pool.all.sort_by(&:pool_owner)
      
    pool_hourly = PoolHourly.where(pool_id: 6)

    @pool_hash = Hash.new
    pool_hourly.each { |hourly|  
      @pool_hash[hourly.created_at] = hourly.current_price      
    }

    puts "POOL HASH #{@pool_hash}"
  end
end
