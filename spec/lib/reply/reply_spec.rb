require 'spec_helper'

describe Reply do

  class Monkey
    include ActiveAttr::BasicModel
    include ActiveAttr::Attributes

    attribute :name

    validates :name, presence: true
  end

  let(:reply) { Reply.new }

  describe '#simple_status' do

    it "is successful by default" do
      expect(reply).to be_successful
    end

    it 'can be set in the initialiser' do
      reply = Reply.new(simple_status: 0)
      expect(reply).to be_error
    end

    it 'can be set' do
      reply.simple_status = 2
      expect(reply).to be_warning
    end

    it 'rejects unknown' do
      expect{ reply.simple_status = 4 }.to raise_error
    end
  end

  describe '#status' do
    it 'can be set in the initialiser' do
      reply = Reply.new(status: 401)
      expect(reply.status).to eq(401)
    end

    it 'can be set' do
      reply.status = 400
      expect(reply.status).to eq(400)
    end
  end

  describe '#replace_messages' do

    it 'accepts an array' do
      arr = [1,2]
      reply.replace_messages(arr)
      expect(reply.messages).to eq(arr)
    end

    it 'accepts a string' do
      str = 'x'
      reply.replace_messages(str)
      expect(reply.messages).to eq([str])
    end
  end

  describe '#add_messages' do

    it 'accepts an array' do
      arr = [1,2]
      reply.add_messages(arr)
      expect(reply.messages).to eq(arr)
    end

    it 'accepts a string' do
      str = 'x'
      reply.add_messages(str)
      expect(reply.messages).to eq([str])
    end

  end

  describe "#add_error" do
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

  describe '#add_errors' do
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

  describe '#mark_as_success' do
    it "marks the reply as success" do
      reply.mark_as_success
      expect(reply).to be_successful
    end

    it "returns self" do
      expect(reply.mark_as_success).to eq(reply)
    end

    it 'accepts a message' do
      msg = "XYZ"
      reply.mark_as_success(msg)
      expect(reply.messages).to include(msg)
    end

    it 'doesnt remove previous messages' do
      reply.mark_as_success('a')
      reply.mark_as_success('b')
      expect(reply.messages.count).to eq(2)
    end
  end

  describe '#mark_as_error' do
    it "marks the reply as error" do
      reply.mark_as_error
      expect(reply).to be_failure
    end

    it "returns self" do
      expect(reply.mark_as_error).to eq(reply)
    end

    it "accepts an optional message" do
      err = "XYZ"
      reply.mark_as_error(err)
      expect(reply.messages).to include(err)
    end

    it 'doesnt remove previous messages' do
      reply.mark_as_error('a')
      reply.mark_as_error('b')
      expect(reply.messages.count).to eq(2)
    end
  end

  describe '#mark_as_warning' do
    it "marks the reply as warning" do
      reply.mark_as_warning
      expect(reply).to be_warning
    end

    it "returns self" do
      expect(reply.mark_as_warning).to eq(reply)
    end

    it 'accepts a message' do
      msg = "XYZ"
      reply.mark_as_warning(msg)
      expect(reply.messages).to include(msg)
    end

    it 'doesnt remove previous messages' do
      reply.mark_as_warning('a')
      reply.mark_as_warning('b')
      expect(reply.messages.count).to eq(2)
    end
  end

  describe '#success!' do
    it "delegates to mark_as_success" do
      expect(reply.method(:success!)).to eq(reply.method(:mark_as_success))
    end
  end

  describe '#error!' do
    it 'delegates to mark_as_error' do
      expect(reply.method(:error!)).to eq(reply.method(:mark_as_error))
    end
  end

  describe '#fail!' do
    it 'delegates to mark_as_error' do
      expect(reply.method(:fail!)).to eq(reply.method(:mark_as_error))
    end
  end

  describe '#warning!' do
    it "delegates to mark_as_warning" do
      expect(reply.method(:warning!)).to eq(reply.method(:mark_as_warning))
    end
  end

  describe '#replace_messages_with_errors_for' do
    let(:invalid_object) { Monkey.new }

    before do
      invalid_object.valid?
      reply.replace_messages_with_errors_for(invalid_object)
    end

    it "is invalid" do
      expect(invalid_object).not_to be_valid
    end

    it "copies the messages" do
      expect(reply.messages.size).to eq(1)
    end
  end

end
