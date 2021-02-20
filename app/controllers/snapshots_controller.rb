class SnapshotsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @products = Product.all

    @products.each do |product|
      snapshot = SnapshotService.new(product.asin).call
      snapshot.product_id = product.id

      if snapshot.changed?(product)
        product.variances.create
      end

      snapshot.save
    end

    redirect_to products_path, notice: 'Snapshot was made'
  end
end
