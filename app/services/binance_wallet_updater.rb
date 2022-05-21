# frozen_string_literal: true
require 'openssl'

class BinanceWalletUpdater < ApplicationService
    def initialize; end
      def call
        timestamp = DateTime.now.strftime('%Q')
        yesterday_timestamp = (DateTime.now - 1.days).strftime('%Q')
        query_string = "type=SPOT&timestamp=#{timestamp}"
        savings_query_string = "timestamp=#{timestamp}"
        secret = ''
        signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, query_string)
        savings_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, savings_query_string)

        url =
        "https://api.binance.com/sapi/v1/accountSnapshot?type=SPOT&timestamp=#{timestamp}&signature=#{signature}"
        get_pool_response = HTTParty.get(url, headers: { 'X-MBX-APIKEY' => '' }).parsed_response
        puts get_pool_response["snapshotVos"].last.to_json
        puts "DATE : #{yesterday_timestamp}"

        url =
        "https://api.binance.com/sapi/v1/lending/daily/token/position?timestamp=#{timestamp}&signature=#{savings_signature}"
        savings_wallet_response = HTTParty.get(url, headers: { 'X-MBX-APIKEY' => '' }).parsed_response
        puts savings_wallet_response.to_json        
        
      end
    end