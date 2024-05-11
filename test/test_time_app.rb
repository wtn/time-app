# frozen_string_literal: true

require 'test_helper'
require 'rack/test'

class TimeAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TimeApp.new
  end

  def test_root_endpoint
    get '/'
    assert_equal 200, last_response.status
    assert_match /\Auptime:[ ]\d+[.]\d+s\z/, last_response.body
  end

  def test_post_endpoint
    post '/post', %q{}
    assert_equal 200, last_response.status
    assert_equal 'OK', last_response.body

    patch '/post'
    assert_equal 405, last_response.status
    assert_equal 'method not allowed', last_response.body
  end

  def test_error_endpoint
    get '/error'
    assert_equal 500, last_response.status
    assert_equal 'error', last_response.body
  end

  def test_not_found
    get '/unknown'
    assert_equal 404, last_response.status
    assert_equal 'not found', last_response.body
  end
end
