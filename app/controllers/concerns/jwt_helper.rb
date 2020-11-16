# frozen_string_literal: true

class JwtHelper
  def self.encode(payload, expiration)
    payload[:exp] = expiration
    JWT.encode(payload, 'SECRET')
  end

  def self.decode(token)
    return JWT.decode(token, 'SECRET', true, algorithm: 'HS256')[0]
  rescue
    return nil
  end
end
