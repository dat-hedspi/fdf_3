module ProductsHelper
  def product_image_select product
    if product.image.exists?
      image_tag product.image.url(:medium),
        id: "image-preview",
        class: "img-responsive img-rounded"
    else
      image_tag "http://i.imgur.com/OnL5mP2.jpg",
        id: "image-preview",
        class: "img-responsive img-rounded"
    end
  end
end
