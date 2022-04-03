require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @pools = Pool.all.sort_by(&:pool_owner)
  
    @chart_data = PoolHourly.find_by(pool_id: 6)

    pool_hourly = PoolHourly.where(pool_id: 6)

    @pool_hash = Hash.new
    pool_hourly.each { |hourly|  
      @pool_hash[hourly.created_at.strftime("%d-%m-%Y")] = hourly.current_price      
    }

    puts "POOL HASH #{@pool_hash}"
  end
end
