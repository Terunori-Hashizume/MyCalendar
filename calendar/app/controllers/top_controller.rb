class TopController < ApplicationController
  def index
    today = Date.today
    @date = today.strftime("%Y-%-m-%-d")
  end
end
