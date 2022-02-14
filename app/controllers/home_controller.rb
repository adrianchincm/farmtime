require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @ancUstValue = AncUstProvider.call()
    @lunaUstValue = LunaUstProvider.call()
  end
end
