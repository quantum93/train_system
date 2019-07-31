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

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE city_id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def update(name)
    @name = name
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

end
