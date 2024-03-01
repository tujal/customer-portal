class CustomerMailer < ApplicationMailer
    # before_action :demo
    default to: -> { Customer.pluck(:email)},
            from: 'customerportal@gmail.com'

    def welcome_email
         @customer = params[:customer]
         attachments.inline['image1.jpg'] = File.read('app/assets/images/image1.jpg')
         attachments.inline['mahi.mp4'] = File.read('app/assets/images/mahi.mp4')
         attachments['git.pdf'] = File.read('app/assets/git.pdf')
        mail(to: @customer.email,bcc: ["bcc@example@gmail.com"],cc: ["deepcc@gmail.com"] ,subject: 'Welcome to the Customer Portal')
    end
    # def welcome_email
    #     
    #     mail(to: email_address_with_name(@customer.email, @customer.first_name), subject: 'Welcome to my awesome website')
    # end

    def update_profile
        @customer = params[:customer]
        mail(to: @customer.email, subject: "Update profile successfully")
    end

#     def welcome_email
#         @customer = params[:customer]
#         attachments.inline['image1.jpg'] = File.read('app/assets/images/image1.jpg')
#         attachments.inline['mahi.mp4'] = File.read('app/assets/images/mahi.mp4')
#         attachments['git.pdf'] = File.read('app/assets/git.pdf')
#        mail(subject: 'Welcome to the Customer Portal')
#    end

   def send_multiple( customer)
        @customer = customer
        attachments.inline['image1.jpg'] = File.read('app/assets/images/image1.jpg')
        attachments.inline['mahi.mp4'] = File.read('app/assets/images/mahi.mp4')
        attachments['git.pdf'] = File.read('app/assets/git.pdf')           
        mail(to: @customer.email, subject: "welcome to the team")
   end

   
    # private
    # def demo
    #     @customer = params[:customer]
    # end

    # def welcome_email
    #     @customer = params[:customer]
    #     mail (to: @customer.email,cc: "tujalsutar1799@gmail.com", bcc:"anjali@gmail.com", subject:"welcome to team")
    # end
end


  