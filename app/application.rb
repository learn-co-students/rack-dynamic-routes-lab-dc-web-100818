class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item = @@items.find {|item| item.name == item_name}
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
       end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end


#
#     it 'Returns an error and 400 if the item is not there' do
#       Application.class_variable_set(:@@items, [Item.new("Figs",3.42),Item.new("Pears",0.99)])
#       get '/items/Apples'
#       expect(last_response.body).to include("Item not found")
#       expect(last_response.status).to be(400)
#     end
#
#   end
# end
