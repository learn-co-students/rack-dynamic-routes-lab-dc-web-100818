
class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #
    # item_name = Item.collect {|i| i.name}

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last #item_name == item being searched
      if item = @@items.find {|i| i.name == item_name} #find the instance in items
        resp.write item.price
      else
        resp.status = 400 #resp.status == give it a status code
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish
  end

end
