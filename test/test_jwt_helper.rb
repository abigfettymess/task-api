# frozen_string_literal: true
require 'test_helper'

class TestJwtHelper < ActiveSupport::TestCase
  test 'it works' do
    assert 1 == 1
  end

  test 'it works 2' do
    token = JwtHelper.encode({ :test => 'test' }, Time.now.to_i + 30.minutes)
    assert token != nil
    assert JwtHelper.decode(token)['test'] == 'test'
  end

  test 'it doe not work' do
    token = JwtHelper.encode({ :test => 'test' }, -1000)
    assert token != nil
    assert JwtHelper.decode(token) == nil
  end
end