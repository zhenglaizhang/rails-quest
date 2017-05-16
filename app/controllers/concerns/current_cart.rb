module CurrentCart
  # prevent Rails from ever making it available as an action on the controller
  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end

# todo https://signalvnoise.com/posts/3372-put-chubby-models-on-a-diet-with-concerns
# share common code among controllers
