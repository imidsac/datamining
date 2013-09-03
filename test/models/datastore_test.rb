require "test_helper"

describe Datastore do
  describe ".load" do
    it "should return false with wrong path" do
      refute Datastore.load("buggy/path")
    end

    it "should return datastore with valid path" do
      assert Datastore.load("datas/datas_01.csv").is_a?(Datastore)
    end
  end

  describe "#duplicated_lines" do
    let(:d1) { Datastore.load('datas/datas_01.csv') }
    let(:d2) { Datastore.load('datas/datas_02.csv') }

    it "should return duplicated_lines based on the key" do
      lines = d1.duplicated_lines(d2, 'email')
      lines.map { |line| line.data['email'] }.must_equal ['Nico.Mills@sarah.net', 'Virginia.Prohaska@stanford.name']
    end
  end
end
