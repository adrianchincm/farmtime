require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @pools = Pool.all.sort_by(&:pool_owner)
      
   
  end
end
