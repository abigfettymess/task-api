# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload, expiration)
    payload[:exp] = expiration
    JWT.encode(payload, 'SECRET')
  end

  def self.decode(token)
    return JWT.decode(token, 'SECRET')[0]
  rescue
    return nil
  end
end
