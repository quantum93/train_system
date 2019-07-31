require 'spec_helper.rb'

describe('#Train') do
  before(:each) do
    City.clear
    Train.clear
  end

  describe('.all') do
    it("returns a list of all trains") do
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      train2 = Train.new({:name => "Blue line", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      train2 = Train.new({:name => "Blue line", :id => nil})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a train") do
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      expect(Train.all).to(eq([train]))
    end
  end

  describe('.find') do
    it("finds a train by id") do
      train = Train.new({:name => "Giant Steps", :id => nil})
      train.save()
      train2 = Train.new({:name => "Naima", :id => nil})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('#delete') do
    it("deletes an train by id") do
      train = Train.new({:name => "Giant Steps", :id => nil})
      train.save()
      train2 = Train.new({:name => "Naima", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('.find_by_city') do
    it("finds trains for a city") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      train.add_stop(city, '01:00 PM')
      train2 = Train.new({:name => "Blue line", :id => nil})
      train2.save()
      city.add_stop(train2, '12:00 pm')
      expect(Train.find_by_city(city.id)).to(eq([train, train2]))
    end
  end

  describe('.stops') do
    it("finds stops for a train") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      city2 = City.new({:name => "Seattle", :id => nil})
      city2.save()
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      train2 = Train.new({:name => "Blue line", :id => nil})
      train2.save()
      stop = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop.save()
      stop2 = Stop.new({:city => city, :train => train2, :time => '13:00:00'})
      stop2.save()
      stop3 = Stop.new({:city => city2, :train => train2, :time => '15:00:00'})
      stop3.save()
      expect(train.stops()).to(eq([stop]))
      expect(train2.stops()).to(eq([stop2, stop3]))
    end
  end

end
