# paynow_ruby
[gem]: https://rubygems.org/gems/paynow_ruby
[![Gem Version](https://badge.fury.io/rb/paynow_ruby.svg)][gem]

Ruby SDK for paynow payment gateway

### Setup

```ruby
# Gemfile
gem 'paynow_ruby', '~> 0.1'
```

### Example usage
```ruby
# app/models/payment.rb
class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  enum status: %i[new pending confirmed rejected error]
end

class User < ApplicationRecord
  has_many :users
  has_many :payments
end

class Order < ApplicationRecord
  belongs_to :user
  has_many :payments
end

# app/controllers/payments_controller
class PaymentsController < ApplicationController
  def create
    order = Order.find(params[:order_id])

    payment = Payment.create(
      amount: order.total_amount,
      user: order.user,
    )

    paynow_payment = Paynow::Payment.create(
      amount: payment.amount,
      external_id: payment.id,
      description: "Payment for order ##{order.id}",
      buyer: payment.user.email,
    )

    payment.update(external_id: paynow_payment.payment_id)

    redirect_to paynow_payment.redirect_url
  end
end

# app/controllers/paynow_notifications_controller.rb
class PaynowNotificationsController < ApplicationController
  def consume_notification
    if Paynow::Digest.hmac(request.body.string) == request.headers['Signature']
      payment = Payment.find_by(external_id: params[:paymentId])
      
      case params[:status]
      when 'NEW'
        payment&.new
      when 'PENDING'
        payment&.pending
      when 'CONFIRMED'
        payment&.confirmed
      when 'REJECTED'
        payment&.rejected
      when 'ERROR'
        payment&.error
      end

      head :ok
    else
      head :unauthorized
    end
  end
end

```

### Documentation

Paynow API [Documentation](https://docs.paynow.pl/)