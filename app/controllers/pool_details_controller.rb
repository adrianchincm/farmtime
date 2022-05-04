# frozen_string_literal: true

class PoolDetailsController < ApplicationController
  helper_method :get_total_pnl_amount

  def show
    @chart_type = params[:chart] ||= 'value'
    @portfolio_name = params[:name]
    @pool_id = params[:pool_id]
    portfolio = Portfolio.find_by(name: @portfolio_name)

    @pool = Pool.find_by(id: @pool_id, portfolio_id: portfolio.id)
    @previous_daily = PreviousDailyProvider.call(@pool_id, portfolio.id)
    @previous_daily_pnl = get_percentage_pnl(@previous_daily).round(2)
    @previous_daily_pnl_amount = get_pnl_amount(@previous_daily).round(2)

    pool_dailies = PoolDaily.where(portfolio_id: portfolio.id, pool_id: @pool.id)

    @pool_price_hash = {}
    @pool_apy_hash = {}
    @pool_tvl_hash = {}
    @base_pool_apy_hash = {}
    @base_pool_tvl_hash = {}

    pool_dailies.each do |daily|
      @pool_price_hash[daily.created_at] = daily.current_price
    end

    get_tvl_apr_hash

    @pool_stats = get_pool_stat(@pool)
    @apy_7d_pnl_percentage = pnl_percentage_apy_7d_average(@pool_stats)
    @tvl_7d_pnl_percentage = pnl_percentage_tvl_7d_average(@pool_stats)
    @total_pnl_percentage = pnl_percentage_total
  end

  def get_pool_stat(pool)
    if pool.vault_provider.nil?
      pool.pool_stat
    else
      @base_pool_stats = pool.pool_stat      
      PoolStat.find_by(tokens: pool.tokens, vault_provider: pool.vault_provider)
    end
  end

  def get_percentage_pnl(previous_daily)
    ((@pool.current_price - previous_daily) / previous_daily) * 100
  end

  def get_pnl_amount(previous_daily)
    @pool.current_price - previous_daily
  end

  def get_total_pnl_amount
    @pool.current_price - @pool.initial_capital
  end

  def get_tvl_apr_hash
    if !@pool.vault_provider.nil?
      pool_farmtime_id = PoolStat.find_by(tokens: @pool.tokens, vault_provider: @pool.vault_provider).farmtime_id
      pool_stat_dailies = PoolStatDaily.where(farmtime_id: pool_farmtime_id)
      check_for_base_pool_stat_dailies
      
    elsif @pool.pool_stat.coindix_id.nil?
      pool_farmtime_id = @pool.pool_stat.farmtime_id
      pool_stat_dailies = PoolStatDaily.where(farmtime_id: pool_farmtime_id)
    else
      pool_coindix_id = @pool.pool_stat.coindix_id
      pool_stat_dailies = PoolStatDaily.where(coindix_id: pool_coindix_id)
    end

    pool_stat_dailies.each do |daily|
      @pool_apy_hash[daily.created_at] = "#{daily.apy}%"
      @pool_tvl_hash[daily.created_at] = daily.tvl
    end
  end

  def check_for_base_pool_stat_dailies
    if !@pool.pool_stat.coindix_id.nil?
      pool_coindix_id = @pool.pool_stat.coindix_id
      base_pool_stat_dailies = PoolStatDaily.where(coindix_id: pool_coindix_id)
    end

    base_pool_stat_dailies.each do |daily|
      @base_pool_apy_hash[daily.created_at] = "#{daily.apy}%"
      @base_pool_tvl_hash[daily.created_at] = daily.tvl
    end
    
  end  

  def pnl_percentage_apy_7d_average(pool_stats)
    ((pool_stats.apr - pool_stats.apy_7d_average) / pool_stats.apr) * 100
  end

  def pnl_percentage_tvl_7d_average(pool_stats)
    ((pool_stats.tvl - pool_stats.tvl_7d_average) / pool_stats.tvl) * 100
  end

  def pnl_percentage_total
    ((@pool.current_price - @pool.initial_capital) / @pool.current_price) * 100
  end
end
