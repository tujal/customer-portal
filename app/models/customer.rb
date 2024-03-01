class Customer < ApplicationRecord
  require 'csv'
    validates :first_name, :last_name, :age, :email , :phone , presence: true
      # after_create :send_multiple
     # paginates_per 2
    has_one_attached :image
    # self.per_page = 3
  
    def self.ransackable_attributes(_auth_object)
        ["age", "email", "last_name", "first_name", "phone",]
      end
      def self.ransackable_associations(auth_object = nil)
        []
      end


    def self.to_csv
      # debugger
      customers = all
      columns = %w(id first_name last_name email age phone)
      CSV.generate do | csv|
        csv << columns
        customers.each do | customer |
          csv << customer.attributes.values_at(*columns)
        end
      end
    end


    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        Customer.create! row.to_hash
      end
    end


    # def send_multiple
    #    @customer = Customer.all
    #     @customer.each do | customer |
    #       CustomerMailer.send_multiple.deliver_later 
    #     end
    # end
end
