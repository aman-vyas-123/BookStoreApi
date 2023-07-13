class JwtAuthenticator
  def self.authenticate(token)
    decoded_token = JsonWebToken.jwt_decode(token)

    if decoded_token && token_not_expired?(decoded_token)
      User.find(decoded_token[:user_id])
    else
      false
    end
  end

  private

  def self.token_not_expired?(decoded_token)
    expiration_time = Time.at(decoded_token[:exp])
    expiration_time > Time.now
  end
end