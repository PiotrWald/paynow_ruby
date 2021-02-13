# frozen_string_literal: true

$LOAD_PATH << 'lib'
require 'paynow'

def create_payment
  Paynow::Payment.create(
    amount: 100,
    external_id: 11,
    buyer: { email: 'test@example.com' },
    description: 'description'
  )
end
