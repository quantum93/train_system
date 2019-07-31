class City
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes[:id] # This style enables to unit test without  ":id => nil" phrase.
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities ORDER BY name;")
    returned_cities.map() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      City.new({:name => name, :id => id})
    end
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    if city
      name = city.fetch("name")
      id = city.fetch("id").to_i
      City.new({:name => name, :id => id})
    else
      nil
    end
  end

  def self.find_by_train(tin_id)
    cities = []
    returned_stops = DB.exec("SELECT * FROM stops WHERE train_id = #{tin_id};")
    returned_stops.each() do |stop|
      id = stop.fetch("city_id").to_i
      cities.push(City.new({:name => City.find(id).name, :id => id}))
    end
    cities
  end

  def delete
    DB.exec("DELETE FROM stops WHERE city_id = #{@id};")
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM stops *;")
    DB.exec("DELETE FROM cities *;")
  end

  def update(name)
    @name = name
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def ==(city_to_compare)
    self.name() == city_to_compare.name()
  end

  def add_stop(train, time)
    DB.exec("INSERT INTO stops (time, city_id, train_id) VALUES ('#{time}', #{@id}, #{train.id})")
  end

end
