require 'maxus'
describe Maxus do
  it "creates with empty block" do
    lambda {Maxus.build do end}.should raise_error Maxus::EmptyBlock
  end

  it "creates key value" do
    hash = {hello: :word}

    @maxus = Maxus.build do
      env "develop" do
        hello hash
        coordinates do
          x 100
          y 200
        end
      end

      env "production" do
        word "Yahoo"
      end
    end

    @maxus.develop.hello.should eq hash
    @maxus.production.word.should eq "Yahoo"
  end

  it "creates hierarchy" do
    hash = {hello: :word}

    @maxus = Maxus.build do
      env "develop" do
        hello hash
        coordinates do
          x 100
          y 200
        end
      end

      env "production" do
        word "Yahoo"
      end
    end

    @maxus.develop.hello.should eq hash
    @maxus.develop.coordinates.x.should eq 100
    @maxus.develop.coordinates.y.should eq 200
  end

  it "creates singleton methods" do
    lambda {@maxus.develop.hello.develop}.should raise_error
  end
end


