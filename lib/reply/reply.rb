class Reply
  # simple_status either 0, 1, 2
  # status can be any code e.g. 200, 401
  attr_accessor :status, :data
  attr_reader :simple_status, :messages

  SIMPLE_STATUS_ERROR = 0
  SIMPLE_STATUS_SUCCESS = 1
  SIMPLE_STATUS_WARNING = 2
  SIMPLE_STATUSES = [SIMPLE_STATUS_SUCCESS, SIMPLE_STATUS_WARNING, SIMPLE_STATUS_ERROR]

  def initialize(params={})
    @messages = params[:messages] || []
    @data = params[:data] || {}
    @status = params[:status] || nil
    @simple_status = params[:simple_status] || SIMPLE_STATUS_SUCCESS
  end

  def simple_status=(s)
    raise(ArgumentError) unless SIMPLE_STATUSES.include?(s)
    @simple_status = s
  end

  #-------------------------------------------------------------------------
  # 
  #-------------------------------------------------------------------------

  def clear_messages
    @messages.clear
  end

  def add_messages(array_or_str)
    array = wrap_arr(array_or_str)
    @messages = @messages | array
  end
  alias :add_message :add_messages

  def replace_messages(array_or_str)
    array = wrap_arr(array_or_str)
    @messages = array
  end

  def replace_messages_with_errors_for(object)
    @messages = object.errors.full_messages
  end

  def add_errors(array_or_str)
    add_messages(array_or_str)
    mark_as_error
  end
  alias :add_error :add_errors

  def mark_as_success(msg=nil)
    @simple_status = SIMPLE_STATUS_SUCCESS
    add_messages(msg) if msg
    self
  end
  alias :success! :mark_as_success

  def mark_as_error(msg=nil)
    @simple_status = SIMPLE_STATUS_ERROR
    add_errors(msg) if msg
    self
  end
  alias :error! :mark_as_error
  alias :fail! :mark_as_error

  def mark_as_warning(msg=nil)
    @simple_status = SIMPLE_STATUS_WARNING
    add_messages(msg) if msg
    self
  end
  alias :warning! :mark_as_warning

  #-------------------------------------------------------------------------
  # Predicates
  #-------------------------------------------------------------------------

  def success?
    @simple_status == SIMPLE_STATUS_SUCCESS
  end
  alias :successful? :success?

  def error?
    @simple_status == SIMPLE_STATUS_ERROR
  end
  alias :failure? :error?

  def warning?
    @simple_status == SIMPLE_STATUS_WARNING
  end

  private

    # Wraps the object in an Array unless it's an Array.  Converts the
    # object to an Array using #to_ary if it implements that.
    def wrap_arr(object)
      case object
      when nil
        []
      when Array
        object
      else
        if object.respond_to?(:to_ary)
          object.to_ary
        else
          [object]
        end
      end
    end

end
