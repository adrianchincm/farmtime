class Portfolio < ApplicationRecord
    serialize :ref_finance_shares
    has_many :pools
end
