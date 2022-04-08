class Pool < ApplicationRecord
    has_many :pool_hourlies, dependent: :destroy
    belongs_to :portfolio, dependent: :destroy
end
