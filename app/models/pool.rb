class Pool < ApplicationRecord
    has_many :pool_hourlies, dependent: :destroy
end
