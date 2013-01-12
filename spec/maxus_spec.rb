require 'maxus'
describe Maxus do
  it "creates with empty block" do
    @maxis = Maxus.build do
    end
  end

  it "creates key value" do
    @maxis = Maxus.build do
      word "yahoo"
    end
  end
end


