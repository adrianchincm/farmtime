# frozen_string_literal: true

class CoindixStatsUpdater < ApplicationService
  require 'rake'
  require "uri"
  require "net/http"
  def initialize            
      @vaults = %w[41149 41178 41180 55832 16745]    
    #   41149 - ATOM/OSMO
    #   41178 - UST/OSMO
    #   41180 - LUNA/UST
    #   55832 - STETH/UST
    #   16745 - Late Quartet      
    end  
  
    def call      
      Rails.application.load_tasks

      pool_stats = PoolStat.first    

      if !pool_stats
        Rake::Task['seed_pool_stats'].invoke
      end

      @vaults.each do |vault|        
        url = "https://api.coindix.com/vaults/#{vault}?period=365"
        puts "V: #{vault}"
        
        vault_response = HTTParty.get(url, headers: { "Authorization" => "Bearer 2bf7194308fca6bc77e14d43d3d3e555c2d6bda9", "User-Agent" => "PostmanRuntime/7.29.0" }).parsed_response

        puts " VAULT NAME : #{vault_response["series"]}"
      end
      
    end
  end
  