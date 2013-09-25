require 'spec_helper'

describe Reply do

  class Monkey
    include ActiveAttr::BasicModel
    include ActiveAttr::Attributes

    attribute :name

    validates :name, presence: true
  end

  let(:reply) { Reply.new }
  let(:invalid_object) { Monkey.new }

  it "is invalid" do
    expect(invalid_object).not_to be_valid
  end

  it "is successful by default" do
    expect(reply).to be_successful
  end

  describe ".add_error" do
    before do
      reply.add_error("Error")
    end

    it "adds the error to the messages" do
      expect(reply.messages.size).to eq(1)
    end

    it "marks the reply as failure" do
      expect(reply).to be_failure
    end
  end

  describe ".add_errors" do
    before do
      reply.add_errors(["Error", "Another Error"])
    end

    it "adds the error to the messages" do
      expect(reply.messages.size).to eq(2)
    end

    it "marks the reply as failure" do
      expect(reply).to be_failure
    end
  end

  describe ".replace_messages_with_errors_for" do
    before do
      invalid_object.valid?
      reply.replace_messages_with_errors_for(invalid_object)
    end

    it "copies the messages" do
      expect(reply.messages.size).to eq(1)
    end
  end

  describe ".mark_as_error" do
    it "marks the reply as error" do
      reply.mark_as_error
      expect(reply).to be_failure
    end
  end

  describe ".error!" do
    it "marks the reply as error" do
      reply.error!
      expect(reply).to be_failure
    end
  end

  describe ".mark_as_success" do
    it "marks the reply as success" do
      reply.mark_as_success
      expect(reply).to be_successful
    end
  end

  describe ".success!" do
    it "marks the reply as success" do
      reply.success!
      expect(reply).to be_successful
    end
  end

  describe ".mark_as_warning" do
    it "marks the reply as warning" do
      reply.mark_as_warning
      expect(reply).to be_warning
    end
  end

  describe ".warning!" do
    it "marks the reply as warning" do
      reply.warning!
      expect(reply).to be_warning
    end
  end

end
