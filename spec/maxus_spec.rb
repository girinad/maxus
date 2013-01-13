require 'maxus'
describe Maxus do

  before(:all) do
    @maxus = Maxus.build :develop do
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

  it "raise error with nothing" do
    lambda {Maxus.build do end}.should raise_error
  end

  it "raise error with unused blok" do
    lambda {Maxus.build :develop do end}.should raise_error Maxus::NonexistentBlock
  end

  it "create empty block" do
    Maxus.build :develop do
      env :develop do
      end
    end
  end



  it "creates key value" do
    @maxus.hello.should eq :world
  end

  it "creates hierarchy" do
    @maxus.coordinates.x.should eq 100
    @maxus.coordinates.y.should eq 200
  end

  it "creates inheritance" do
    @maxus.word.should eq :yahoo
  end

  it "should raise looped inheritance" do
    lambda {
      Maxus.build :develop do
        env :develop, parent: :production do
          hello :world
        end

        env :test, parent: :rest do
          word :google
        end

        env :production, parent: :test do
          word :yahoo
        end

        env :rest, parent: :production  do
          env :staging
        end
      end
    }.should raise_error Maxus::LoopedInheritance
  end

  it "creates singleton methods" do
    lambda {@maxus.hello.develop}.should raise_error
  end
end


