#!/usr/bin/env ruby

# frozen_string_literal: true

require 'rack'

class TimeApp
  VERSION = '0'
  SERVER = "#{name}/#{VERSION}"

  def call(env)
    request = Rack::Request.new env
    response = Rack::Response.new
    response['server'] = SERVER

    case request.path
    when '/'
      response.write "uptime: #{Process.clock_gettime(Process::CLOCK_MONOTONIC).floor 1}s"
    when '/post'
      if request.post?
        response.write 'OK'
      else
        response.status = 405
        response.write 'method not allowed'
      end
    when '/error'
      response.status = 500
      response.write 'error'
    else
      response.status = 404
      response.write 'not found'
    end

    response.finish
  end
end
