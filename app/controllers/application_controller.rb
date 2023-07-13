require 'jwt'

#require_relative 'app/controllers/concerns/json_web_token.rb'

class ApplicationController < ActionController::API


  include JsonWebToken

  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = if decoded && decoded.key?(:user_id)
                      User.find(decoded[:user_id])
                    else
                      nil
                    end  
  end

  # def decode_token(token)
  #   secret_key = Rails.application.secrets.secret_key_base
  #   JWT.decode(token, secret_key, true, algorithm: 'HS256').first
  # end

end
