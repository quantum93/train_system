require 'spec_helper.rb'

describe('#Stop') do
  before(:each) do
    City.clear
    Train.clear
    Stop.clear
  end

  describe('.all') do
    it("returns an empty array when there are no stops") do
      expect(Stop.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a stop") do
      city = City.new({:name => "Portland"})
      city.save()
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      stop = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop.save()
      stop2 = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop2.save()
      expect(Stop.all).to(eq([stop, stop2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new({:name => "Portland"})
      city.save()
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      stop = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop.save()
      stop2 = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop2.save()
      Stop.clear
      expect(Stop.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a stop by id") do
      city = City.new({:name => "Portland"})
      city.save()
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      stop = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop.save()
      stop2 = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop2.save()
      expect(Stop.find(stop.id)).to(eq(stop))
      expect(Stop.find(stop2.id)).to(eq(stop2))
    end
  end

  describe('#delete') do
    it("deletes a stop by id") do
      city = City.new({:name => "Portland"})
      city.save()
      train = Train.new({:name => "Red line", :id => nil})
      train.save()
      stop = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop.save()
      stop2 = Stop.new({:city => city, :train => train, :time => '13:00:00'})
      stop2.save()
      stop.delete()
      expect(Stop.all).to(eq([stop2]))
    end
  end

end
