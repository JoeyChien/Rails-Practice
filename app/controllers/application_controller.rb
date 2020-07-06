class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["basic_name"], password: ENV["basic_pw"]
end
