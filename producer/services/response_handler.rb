# frozen_string_literal: true

class ResponseHandler
  include CustomLogger

  NOT_FOUND = 404
  SERVER_ERROR = 500
  SUCCESS = 200
  REQUEST_ERROR = (400..499)

  def initialize(response)
    @response = response
    @status = response&.status
    @body = XmlHasher.parse(response&.body)
  end

  def bad_request?
    REQUEST_ERROR.include? @status
  end

  def success?
    @status == SUCCESS && !response_with_empty_data?
  end

  def response_with_empty_data?
    data.empty?
  end

  def handle(klass)
    if success?
      Log.request_info(@response.env)
      data.map do |object|
        klass.new(object)
      end
    elsif response_with_empty_data? || bad_request?
      Log.error_message_400(@response.env)
      Fault.new NOT_FOUND
    else
      Log.error_message_500(@response.env)
      Fault.new SERVER_ERROR
    end
  end

  private

  def data
    @body.fetch(:eventList, {}).fetch(:output, {}).fetch(:base_event, {})
  end
end
