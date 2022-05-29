# frozen_string_literal: true

class CoindixStatsUpdater < ApplicationService
  require 'rake'
  require "uri"
  require "net/http"
  def initialize
      @vaults = PoolStat::VAULTS
    end

    def call
      Rails.application.load_tasks

      pool_stats = PoolStat.first

      if !pool_stats
        Rake::Task['seed_pool_stats'].invoke
        Rake::Task['seed_pools_with_coindix_id'].invoke
      end

      @vaults.each do |vault|
        url = "https://api.coindix.com/vaults/#{vault}"

        vault_response = HTTParty.get(url, headers: { "Authorization" => "Bearer 2bf7194308fca6bc77e14d43d3d3e555c2d6bda9", "User-Agent" => "PostmanRuntime/7.29.0" }).parsed_response

        if vault_response["message"] != "not_exist"
          pool_stat = PoolStat.find_by(coindix_id: vault)
          pool_stat.tvl = vault_response["tvl"]
          pool_stat.apr = vault_response["apy"] * 100
          pool_stat.save
        end        
      end

    end
  end
