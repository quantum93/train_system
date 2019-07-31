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

end
