class Reply
  attr_accessor :status, :messages, :data

  STATUS_ERROR = 0
  STATUS_SUCCESS = 1
  STATUS_WARNING = 2

  def initialize(params={})
    @messages = params[:messages] || []
    @status = params[:status] || STATUS_SUCCESS
    @data = params[:data] || {}
  end

  def clear_messages
    @messages.clear
  end

  def add_message(message)
    @messages << message
  end

  def add_messages(array)
    @messages = @messages | array
  end

  def replace_messages(array)
    @messages = array
  end

  def replace_messages_with_errors_for(object)
    @messages = object.errors.full_messages
  end

  def add_error(message)
    add_message(message)
    mark_as_error
  end

  def add_errors(array)
    add_messages(array)
    mark_as_error
  end

  def mark_as_error
    @status = STATUS_ERROR
  end
  alias :error! :mark_as_error

  def mark_as_warning
    @status = STATUS_WARNING
  end
  alias :warning! :mark_as_warning

  def mark_as_success
    @status = STATUS_SUCCESS
  end
  alias :success! :mark_as_success

  def success?
    @status == STATUS_SUCCESS
  end
  alias :successful? :success?

  def error?
    @status == STATUS_ERROR
  end
  alias :failure? :error?

  def warning?
    @status == STATUS_WARNING
  end
end
