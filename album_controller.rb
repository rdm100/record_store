require('sinatra')
require('sinatra/contrib/all')
require ('pry-byebug')

require_relative("./models/artist.rb")
require_relative("./models/album.rb")


# get "/" do
#   @artists = Artist.all()
#   @albums = Album.all()
#   erb(:index)
# end

#new
get "/album/new" do
  @albums = Album.all()
  @artists = Artist.all()
  erb(:album_new)
end

#show
get "/album/:id" do
  @album = Album.find(params[:id] )
  erb(:show_album)
end


# #create
post "/album/new" do
new_album = Album.new(params)
new_album.save()
redirect to "/"
end

#edit
get "/album/:id/edit" do
  @album = Album.find(params[:id] )
  @artists = Artist.all
  erb(:edit_album)
end

#update
post "/album/:id/edit" do
  @album = Album.new(params)
  @album.update()
redirect to "/"
end

#destroy
post "/album/:id/delete" do
album = Album.find(params[:id] )
album.delete()
redirect to "/"
end