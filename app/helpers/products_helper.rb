module ProductsHelper
  def product_image_select product
    image_tag product.image.url(:medium),
      id: "image-preview",
      class: "img-responsive img-rounded" if product.image.exists?
    image_tag "default-image.jpg", 
      id: "image-preview",
      class: "img-responsive img-rounded"
  end
end
