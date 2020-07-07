class ApplicationController < ActionController::Base
  unless Rails.env.test?
    http_basic_authenticate_with name: ENV["basic_name"], password: ENV["basic_pw"]
  end  
end
