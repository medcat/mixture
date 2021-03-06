# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Mixture::Extensions::Attributable do
  # A test model.
  model = Class.new do
    include Mixture::Extensions::Attributable

    attribute :name, some: :option
  end

  inherited = Class.new(model) do
    attribute :foo
  end

  subject { model.new }
  let(:attr) { model.attributes[:name] }
  let(:attributes) { { name: "foo" } }

  describe ".attribute" do
    it "creates accessor methods" do
      expect(subject).to respond_to(:name)
      expect(subject).to respond_to(:name=)
    end
  end

  describe ".attributes" do
    subject { model.attributes }
    it { is_expected.to be_a Mixture::AttributeList }
  end

  describe "#attributes" do
    before(:each) { subject.attributes = attributes }

    it "returns a hash of attributes" do
      expect(subject.attributes).to eq name: "foo"
    end
  end

  describe "#attributes=" do
    it "sets the attributes" do
      subject.attributes = attributes
      expect(subject.name).to eq "foo"
    end

    it "calls update" do
      block = double("block")
      model.attributes.callbacks[:update] = [block]
      expect(block).to receive(:call)
        .once.with(an_instance_of(Mixture::Attribute), "foo")
        .and_return(:bar)
      subject.attributes = attributes
      expect(subject.name).to be :bar
      model.attributes.callbacks[:update] = []
    end
  end

  describe "with inheritance" do
    subject { inherited }
    describe ".attributes" do
      subject { inherited.attributes }

      it { is_expected.to have_key(:name) }
      it { is_expected.to have_key(:foo) }

      context "on the parent" do
        subject { model.attributes }

        it { is_expected.to have_key(:name) }
        it { is_expected.to_not have_key(:foo) }
      end
    end
  end
end
