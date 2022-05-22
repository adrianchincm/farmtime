class Token < ApplicationRecord
    belongs_to :coin, optional: true
end
