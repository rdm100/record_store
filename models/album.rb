require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_reader :id, :title, :in_stock, :stock_level, :artist_id, :genre, :album_art

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @in_stock = options['in_stock'].to_i
    @stock_level = set_stock_level()
    @artist_id = options['artist_id'].to_i
    @genre = options['genre']
    @album_art = options['album_art']
  end

  def save()
    #save an album to db
    values = [@title, @in_stock, @stock_level, @artist_id, @genre, @album_art]
    sql = "INSERT INTO albums (title, in_stock, stock_level, artist_id, genre, album_art) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id;"
    results = SqlRunner.run(sql, values)
    #set @id equal to the returned id
    @id = results[0]['id'].to_i
  end

  def self.all()
    #get all albums
    sql = "SELECT * FROM albums;"
    values = []
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album) }
  end

  def self.find(id)
    #find album by id
    sql = "SELECT * FROM albums WHERE id = $1;"
    values = [id]
    album = SqlRunner.run(sql, values).first()
    return Album.new(album)
  end

  def update()
    #update an album's details in db
    sql = "UPDATE albums SET (title, in_stock, stock_level, artist_id, genre, album_art) = ($1, $2, $3, $4, $5, $6) WHERE id = $7;"
    values = [@title, @in_stock, @stock_level, @artist_id, @genre, @album_art, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    #delete an album from db
    sql = "DELETE FROM albums WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist()
    #get the artist of the album
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values).first()
    return Artist.new(artist)
  end


  def set_stock_level()
    #set stock level from values in @in_stock value
    case @in_stock
    when 0
      return "Out of stock"
    when (1..10)
      return "Low"
    when (11..50)
      return "Medium"
    else
      return "High"
    end

  end

  def self.out_of_stock()
    #get out of stock albums from db
    sql = "SELECT * FROM albums WHERE stock_level = $1;"
    values = ["Out of stock"]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album) }
  end

  def self.low_stock()
    #get albums that are low in stock from db
    sql = "SELECT * FROM albums WHERE stock_level = $1;"
    values = ["Low"]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album) }
  end

  def self.medium_stock()
    #get albums that are medium in stock from db
    sql = "SELECT * FROM albums WHERE stock_level = $1;"
    values = ["Medium"]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album) }
  end

  def self.high_stock()
    #get albums that are high in stock from db
    sql = "SELECT * FROM albums WHERE stock_level = $1;"
    values = ["High"]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album) }
  end



end