require "uri"
require "net/http"

class HomeController < ApplicationController
  def index
    @ancUstValue = AncUstProvider.call()
    @lunaUstValue = LunaUstProvider.call()
    @osmoUstValue = OsmoUstProvider.call()

    @lateQuartetValue = LateQuartetProvider.call()

    # @ancUstValue = 1234.23
    # @lunaUstValue = 504.23
    # @osmoUstValue = 1023.90
  end
end
