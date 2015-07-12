# encoding: utf-8

RSpec.describe Mixture::Coerce::Object do
  subject { Mixture::Coerce::Object.instance }
  let(:value) { 1.0 }

  it "attempts coercion" do
    expect(subject.to_integer).to be_a Proc
    expect(subject.to_integer.call(value)).to be_an Integer
  end

  it "tries multiple methods" do
    value = double("Value")
    expect(value).to receive(:respond_to?).twice do |name|
      name == :to_integer
    end

    expect(value).to receive(:to_integer).once.and_return(3)
    expect(subject.to_integer.call(value)).to be 3
  end

  it "fails if it can't find a method" do
    expect { subject.to_array.call(value) }
      .to raise_error(Mixture::CoercionError)
  end
end