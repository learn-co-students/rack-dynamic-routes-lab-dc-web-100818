class Application
  # @@items = [Item.new("Cake",15), Item.new("Bread", 4), Item.new("Coke", 2.5)]
  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match("/items/")
      item_name = req.path.split("/items/").last
      item = @@items.find{|i|i.name == item_name}
      if item
        resp.write item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
