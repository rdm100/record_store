require('sinatra')
require('sinatra/contrib/all')
require ('pry-byebug')

require_relative("./models/artist.rb")
require_relative("./models/album.rb")


# #index
# get "/" do
#   @artists = Artist.all()
#   @albums = Album.all()
#   erb(:index)
# end

#new
get "/artist/new" do
  @artists = Artist.all()
  erb(:artist_new)
end

#show
get "/artist/:id" do
  @artist = Artist.find(params[:id] )
  erb(:show_artist)
end


# #create
post "/artist/new" do
new_artist = Artist.new(params)
new_artist.save()
redirect to "/"
end

# #edit
get "/artist/:id/edit" do
  @artist = Artist.find(params[:id] )
  @albums = Album.all
  erb(:edit_artist)
end

#update
post "/artist/:id/edit" do
  @artist = Artist.new(params)
  @artist.update()
redirect to "/"
end

#destroy
post "/artist/:id/delete" do
artist = Artist.find(params[:id] )
artist.delete()
redirect to "/"
end