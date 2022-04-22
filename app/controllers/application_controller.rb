class ApplicationController < ActionController::Base
  def hello
    render plain: "Hello Vitali"
  end
end
