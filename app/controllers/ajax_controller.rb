class AjaxController < ApplicationController
  def upanel
    @time = Time.now.to_s
  end
end
