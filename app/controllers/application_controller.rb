class ApplicationController < ActionController::Base
  def hello
    render plain: "Hello Vitali"
  end

  def goodbye
    render plain: "goodbye Vitali"
  end
end
