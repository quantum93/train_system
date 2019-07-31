require 'spec_helper.rb'

describe('#City') do
  before(:each) do
    City.clear
    Train.clear
  end

  describe('.all') do
    it("returns an empty array when there are no cities") do
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a city") do
      city = City.new({:name => "Portland"})
      city.save()
      city2 = City.new({:name => "Seattle"})
      city2.save()
      expect(City.all).to(eq([city, city2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new({:name => "Portland"})
      city.save()
      city2 = City.new({:name => "Seattle"})
      city2.save()
      City.clear
      expect(City.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
        city = City.new({:name => "Portland"})
        city2 = City.new({:name => "Portland"})
      expect(city).to(eq(city2))
    end
  end


  describe('.find') do
    it("finds a city by id") do
      city = City.new({:name => "Portland"})
      city.save()
      city2 = City.new({:name => "Seattle"})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#update') do
   it("updates a city by id") do
     city = City.new({:name => "Portland"})
     city.save()
     city.update("Seattle")
     expect(city.name).to(eq("Seattle"))
   end
 end

 describe('#delete') do
  it("deletes a city by id") do
    city = City.new({:name => "Portland"})
    city.save()
    city2 = City.new({:name => "Seattle"})
    city2.save()
    city.delete()
    expect(City.all).to(eq([city2]))
  end
end

describe('.find_by_train') do
  it("finds cities for a train id") do
    city = City.new({:name => "Portland", :id => nil})
    city.save()
    city2 = City.new({:name => "Seattle", :id => nil})
    city2.save()
    train = Train.new({:name => "Red line", :id => nil})
    train.save()
    train.add_stop(city, '01:00 PM')
    train2 = Train.new({:name => "Blue line", :id => nil})
    train2.save()
    train2.add_stop(city, '10:00:00')
    train2.add_stop(city2, '12:00:00')
    expect(City.find_by_train(train.id)).to(eq([city]))
    expect(City.find_by_train(train2.id)).to(eq([city, city2]))
  end
end

end
