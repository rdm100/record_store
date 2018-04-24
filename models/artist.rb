require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id, :name, :image

  def initialize(options)
    @id = options['id'].to_i #if options['id']
    @name = options['name']
    @image = options['image']
  end


  def save()
    #save artist in db
    sql = "INSERT INTO artists (name, image) VALUES ($1, $2) RETURNING id;"
    values = [@name, @image] #which come from artist objects created in seeds
    #run sql and return id
    results = SqlRunner.run(sql, values)
    # set id
    @id = results[0]['id'].to_i
  end

  def self.all()
    #read all artists from db
    sql = "SELECT * FROM artists ORDER BY name ASC;"
    values = []
    results = SqlRunner.run(sql, values)
    #map results which is a hash of artists and create an array of artist objects 
    return results.map { |artist| Artist.new(artist) }
  end

  def self.find(id)
    #find an artist by id
    sql = "SELECT * FROM artists WHERE id = $1;"
    #values id argument passed to function parameter
    values = [id]
    artist = SqlRunner.run(sql, values).first()
    #return the artist found from sql query
    return Artist.new(artist)
  end

  def update()
    #update artist details in db
    sql = "UPDATE artists SET (name, image) = ($1, $2) WHERE id = $3;"
    values = [@name, @image, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    #delete all artists from db
    sql = "DELETE FROM artists;"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    #delete artist from db
    sql = "DELETE FROM artists WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def albums()
    # get all albums by this artist from db
    sql = "SELECT * FROM albums WHERE artist_id = $1 ORDER BY in_stock ASC;"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    # map albums (create new album objects)
    return albums.map { |album| Album.new(album) }
  end

end