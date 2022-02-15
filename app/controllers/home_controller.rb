require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @ancUstValue = AncUstProvider.call()
    @lunaUstValue = LunaUstProvider.call()
    @osmoUstValue = OsmoUstProvider.call()
  end
end
