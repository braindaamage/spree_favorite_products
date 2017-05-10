module Spree
  class Favorite < ActiveRecord::Base
    belongs_to :variant, class_name: "Spree::Variant", :foreign_key => 'product_id'
    
    belongs_to :user
    validates :user_id, :product_id, :presence => true
    validates :product_id, :uniqueness => { :scope => :user_id, :message => "already marked as favorite" }

    validates :variant, :presence => { :message => "is invalid" }, :if => :product_id

    def self.to_csv(options = { col_sep: ';' })
      CSV.generate(options) do |csv|
        csv << ['SKU', 'Nombre Cliente', 'Rut', 'E-Mail']
        self.class.order(user_id: :asc).each do |favorite|
          data = []

          data << (favorite.variant.sku rescue '')
          data << "#{favorite.user.first_name} #{favorite.user.last_name}"
          data << favorite.user.rut
          data << favorite.user.email

          csv << data
        end
      end
    end
  end
end