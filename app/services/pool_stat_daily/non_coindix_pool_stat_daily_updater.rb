# frozen_string_literal: true

class NonCoindixPoolStatDailyUpdater < ApplicationService    
    def initialize
      
    end
  
    def call
        RefFinancePoolStatDailyUpdater.call()
        SpectrumFinancePoolStatDailyUpdater.call()
    end
  end
  