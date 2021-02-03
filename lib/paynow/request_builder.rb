# frozen_string_literal: true

require 'json'
require 'base64'

module Paynow
  class RequestBuilder
    attr_reader :body

    def self.build(body)
      new(body).build
    end

    def initialize(body)
      @body = body
    end

    def build
      body.transform_keys(&camelize_proc).to_json
    end

    private

    def camelize_proc
      proc do |key|
        key.to_s.split('_').reduce do |accumulator, value|
          if accumulator
            accumulator + value[0].upcase + value[1..(value.length - 1)]
          else
            value
          end
        end
      end
    end
  end
end
