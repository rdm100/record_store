DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;

-- \i C:/Users/1/codeclan/record_store/db/record_store.sql
CREATE TABLE artists(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  image VARCHAR(255)
);

CREATE TABLE albums(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  in_stock INT4,
  stock_level VARCHAR(20),
  artist_id INT8 REFERENCES artists(id) ON DELETE CASCADE,
  genre VARCHAR(255) NOT NULL,
  album_art VARCHAR(255),
  buy_price FLOAT8,
  sell_price FLOAT8,
  profit_margin FLOAT8,
  customer_rating INT4,
  percentage_of_profit FLOAT8
);