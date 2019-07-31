class Train
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @id = attributes[:id] # This style enables to unit test without  ":id => nil" phrase.
    @name = attributes.fetch(:name)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      id = train.fetch("id").to_i
      name = train.fetch("name")
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    if train
      id = train.fetch("id").to_i
      name = train.fetch("name")
      Train.new({:name => name, :id => id})
    else
      nil
    end
  end

  def delete
    DB.exec("DELETE FROM stops WHERE train_id = #{@id};")
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM stops *;")
    DB.exec("DELETE FROM trains *;")
  end

  def self.find_by_city(cty_id)
    trains = []
    returned_stops = DB.exec("SELECT * FROM stops WHERE city_id = #{cty_id};")
    returned_stops.each() do |stop|
      id = stop.fetch("train_id").to_i
      trains.push(Train.new({:name => Train.find(id).name, :id => id}))
    end
    trains
  end

  def ==(train_to_compare)
    self.name() == train_to_compare.name()
    self.id() == train_to_compare.id()
  end

  def add_stop(city, time)
    DB.exec("INSERT INTO stops (time, city_id, train_id) VALUES ('#{time}', #{city.id}, #{@id})")
  end

end
