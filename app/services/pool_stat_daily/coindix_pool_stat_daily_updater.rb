# frozen_string_literal: true

class CoindixPoolStatDailyUpdater < ApplicationService
    require 'rake'
    require "uri"
    require "net/http"
    def initialize
        @vaults = PoolStat::VAULTS
      end
  
      def call
        @vaults.each do |vault|
          url = "https://api.coindix.com/vaults/#{vault}"
  
          vault_response = HTTParty.get(url, headers: { "Authorization" => "Bearer 2bf7194308fca6bc77e14d43d3d3e555c2d6bda9", "User-Agent" => "PostmanRuntime/7.29.0" }).parsed_response
  
          
          PoolStatDaily.create(name: vault_response["name"], tvl: vault_response["series"][-1]["tvl"], apy: vault_response["series"][-1]["apy"].to_f * 100, coindix_id: vault)
          
        end
  
      end
    end
  