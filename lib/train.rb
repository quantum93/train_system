class Train
  attr_reader :id

  def initialize(attributes)
    @id = attributes[:id] # This style enables to unit test without  ":id => nil" phrase.
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      id = train.fetch("id").to_i
      trains.push(Train.new({:id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (id) VALUES (#{@id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    if train
      id = train.fetch("id").to_i
      Train.new({:id => id})
    else
      nil
    end
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def self.find_by_city(cty_id)
    trains = []
    returned_stops = DB.exec("SELECT * FROM stops WHERE city_id = #{cty_id};")
    returned_stops.each() do |stop|
      id = stop.fetch("train_id").to_i
      trains.push(Train.new({:id => id}))
    end
    trains
  end

end
