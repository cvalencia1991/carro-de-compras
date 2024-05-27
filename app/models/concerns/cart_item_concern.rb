module CartItemConcern
    extend ActiveSupport::Concern

    included do
      before_save :product_in_stock
      before_save :adjust_product_stock
      before_save :update_subtotal
      before_destroy :restore_product_stock
      validate :product_in_stock
    end

    def subtotal
      quantity * product.precio
    end

    private

      def product_in_stock
        return unless quantity > product.stock
        errors.add(:quantity, 'is greater than available stock')
      end

      def adjust_product_stock
        quantity_diff = if persisted?
                          quantity - quantity_was
                        else
                          quantity
                        end
        product.update!(stock: product.stock - quantity_diff)
      end

      def restore_product_stock
        product.update!(stock: product.stock + quantity)
      end

      def update_subtotal
        self[:subtotal] = subtotal
      end
  end