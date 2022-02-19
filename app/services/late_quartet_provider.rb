# frozen_string_literal: true

class LateQuartetProvider < ApplicationService
    def initialize; end
  
    def call
      url =
        'https://api.debank.com/portfolio/project_list?user_addr=0xf7865467a13b46c468b53e067533facae968fc3d'
      getLateQuartet = HTTParty.get(url).parsed_response
      
      totalValue = getLateQuartet["data"][0]["portfolio_list"][0]["stats"]["asset_usd_value"]

      totalValue    
    end
  end
  