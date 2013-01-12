require 'maxus'
describe Maxus do

  before(:all) do
    @maxus = Maxus.build do
      env :develop, parent: :production do
        hello :world
        coordinates do
          x 100
          y 200
        end
      end

      env :test, parent: :rest do
        word :google
      end

      env :production, parent: :test do
        word :yahoo
      end

      env :rest do
        env :staging
      end
    end
  end

  it "creates with empty block" do
    lambda {Maxus.build do end}.should raise_error Maxus::EmptyBlock
  end

  it "creates key value" do
    @maxus.develop.hello.should eq :world
    @maxus.production.word.should eq :yahoo
  end

  it "creates hierarchy" do
    @maxus.develop.coordinates.x.should eq 100
    @maxus.develop.coordinates.y.should eq 200
  end

  it "creates inheritance" do
    @maxus.develop.word.should eq :yahoo
    @maxus.production.word.should eq :yahoo
    @maxus.production.env.should eq :staging
    @maxus.test.word.should eq :google
  end

  it "creates singleton methods" do
    lambda {@maxus.develop.hello.develop}.should raise_error
  end
end


