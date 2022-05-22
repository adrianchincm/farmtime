class Wallet < ApplicationRecord
    has_many :tokens
    has_one :portfolio, class_name: "Portfolio", foreign_key: "binance_wallet_id"
end
