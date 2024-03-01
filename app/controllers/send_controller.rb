class SendController < ApplicationController
    def send_email
        @customer = Customer.all
        @customer.each do | customer | 
            CustomerMailer.send_multiple(customer).deliver_now
        end
    end
end
