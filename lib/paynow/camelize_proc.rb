# frozen_string_literal: true

module Paynow
  CAMELIZE_PROC = proc do |key|
    key.to_s.split('_').reduce do |accumulator, value|
      if accumulator
        accumulator + value[0].upcase + value[1..(value.length - 1)]
      else
        value
      end
    end
  end
end
