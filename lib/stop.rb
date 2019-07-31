class Stop
  attr_reader :id
  attr_accessor :city, :train, :time

  def initialize(attributes)
    @id = attributes[:id]
    @city = attributes[:city]
    @train = attributes[:train]
    @time = attributes[:time]
  end

  def self.all
    returned_stops = DB.exec("SELECT * FROM stops ORDER BY id;")
    returned_stops.map() do |stop|
      id = stop.fetch("id").to_i
      city_id = stop.fetch("city_id").to_i
      train_id = stop.fetch("train_id").to_i
      time = stop.fetch("time")
      Stop.new({:id => id, :city => City.find(city_id), :train => Train.find(train_id), :time => time})
    end
  end

  def save
    result = DB.exec("INSERT INTO stops (city_id, train_id, time) VALUES (#{@city.id}, #{@train.id}, '#{@time}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    stop = DB.exec("SELECT * FROM stops WHERE id = #{id};").first
    if stop
      city_id = stop.fetch("city_id").to_i
      train_id = stop.fetch("train_id").to_i
      time = stop.fetch("time")
      Stop.new({:id => id.to_i, :city => City.find(city_id), :train => Train.find(train_id), :time => time})
    else
      nil
    end
  end

  def delete
    DB.exec("DELETE FROM stops WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM stops *;")
  end

  def ==(stop_to_compare)
    self.city() == stop_to_compare.city()
    self.train() == stop_to_compare.train()
    self.time() == stop_to_compare.time()
  end

end
