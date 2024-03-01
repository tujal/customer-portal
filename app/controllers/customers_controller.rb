class CustomersController < ApplicationController
    require 'csv'
    require "prawn"
    before_action :set_id, only: [:edit, :show, :destroy]
    # after_action :message, only: [:create, :destroy]

    def index
        # @customers = Customer.all.page(params[:page])
        # @customers =Customer.paginate(page: params[:page])
        @query = Customer.ransack(params[:query])
        @customers = @query.result(distint: true)#.paginate(page: params[:page])
        respond_to do |format|
            format.html
            format.csv { send_data Customer.to_csv, filename: "customers-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
          end
    end
   
   
      def import
        
        Customer.import(params[:file])
        redirect_to root_url, notice: "Import file successfully"
      end


    def download_pdf
        customer = Customer.find(params[:id])
        send_data generate_pdf(customer),
            filename: "#{customer.first_name}.pdf",
            type: "application/pdf"
    end

    def show
    
    end

    def new
        @customer = Customer.new
    end

    def create
        @customer = Customer.create(customers_params)
        if @customer.save
            flash[:notice] ="Customer created successfully!.."
            # CustomerMailer.with(customer: @customer).welcome_email.deliver_later(wait_until: 1.minutes.from_now)
             CustomerMailer.with(customer: @customer).welcome_email.deliver_later
            
            redirect_to @customer
        else
            render :new, status: :unprocessable_entity      
        end
    end

    def edit
    end

    def update
        @customer = Customer.find(params[:id])
        if @customer.update(customers_params)
             flash[:notice] ="Your Profile has been updated!"
            CustomerMailer.with(customer: @customer).update_profile.deliver_later
            redirect_to @customer 
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @customer.destroy
        flash[:alert] ="Customer destroy  successfully!.."
        redirect_to @customer
    end

    # def profile_update
    #     @customer = Customer.find_by(params[:image])
    #     if @customer.image.attached?
    #             @customer.update(profile_image)
    #             redirect_to @customer
    #     else
    #         render :profile_update, status: :unprocessable_entity
    #     end
    # end

      

    private

    def customers_params
        # we can use fetch in place of require
        params.require(:customer).permit(:first_name, :last_name, :age, :email, :phone, :image, :file)
    end

    def set_id
        @customer = Customer.find(params[:id])
    end

    # def message
    #     Rails.logger.info("customer action complete ")
    # end
    
    def generate_pdf(customer)
        Prawn::Document.new do
            text "Customer Details " , size: 20 , style: :bold, align: :center
            text customer.first_name #align: :center
            text "Email: #{customer.email}"
            text "Phone: #{customer.phone}"
            text "Age: #{customer.age}"
        end.render
    end

    def profile_image
        params.require(:customer).permit(:image, :id)
    end

end
