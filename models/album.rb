require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('artist')

class Album

  attr_reader :id, :title, :in_stock, :stock_level, :artist_id, :genre, :album_art, :buy_price, :sell_price, :profit_margin, :customer_rating, :percentage_of_profit

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @in_stock = options['in_stock'].to_i
    @stock_level = set_stock_level()
    @artist_id = options['artist_id'].to_i
    @genre = options['genre']
    @album_art = options['album_art']
    @buy_price = options['buy_price'].to_f
    @sell_price = options['sell_price'].to_f
    @profit_margin = profit_margin()
    @customer_rating = options['customer_rating'].to_i
    @percentage_of_profit = percentage_of_profit()
  end

  def save()
    #save an album to db
    values = [@title, @in_stock, @stock_level, @artist_id, @genre, @album_art, @buy_price, @sell_price, @profit_margin, @customer_rating, @percentage_of_profit]
    sql = "INSERT INTO albums (title, in_stock, stock_level, artist_id, genre, album_art, buy_price, sell_price, profit_margin, customer_rating, percentage_of_profit) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) RETURNING id;"
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
    sql = "UPDATE albums SET (title, in_stock, stock_level, artist_id, genre, album_art, buy_price, sell_price, profit_margin, customer_rating, percentage_of_profit) = ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) WHERE id = $12;"
    values = [@title, @in_stock, @stock_level, @artist_id, @genre, @album_art, @buy_price, @sell_price, @profit_margin, @customer_rating, @percentage_of_profit, @id]
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

  def profit_margin()
    @profit_margin = @sell_price - @buy_price
    return @profit_margin
  end

   def percentage_of_profit()
    @percentage_of_profit = ((@sell_price - @buy_price) / (@sell_price)) * 100
    return @percentage_of_profit.round(2)
   end

  def self.total_value_of_stock()
    sql = "SELECT SUM (in_stock * sell_price) AS total_value_of_stock FROM albums;"
    result = SqlRunner.run(sql)
    return result[0]["total_value_of_stock"].to_i
  end 

  def self.total_number_of_albums()
    sql = "SELECT SUM (in_stock) AS total_number_of_albums FROM albums;"
    result = SqlRunner.run(sql)
    return result[0]["total_number_of_albums"].to_i
  end 

  def self.average_buy_price()
    sql = "SELECT AVG (buy_price) AS average_buy_price FROM albums;"
    result = SqlRunner.run(sql)
    return result[0]["average_buy_price"].to_i
  end 

end