module HTTParty
	# @abstact Exceptions raised by HTTParty inherit from Error
	class Error < StandardError;
	end

	# Exception raised when you attempt to set a non-existant format
	class UnsupportedFormat < Error;
	end

	# Exception raised when using a URI scheme other than HTTP or HTTPS
	class UnsupportedURIScheme < Error;
	end

	# @abstract Exceptions which inherit from ResponseError contain the Net::HTTP
	# response object accessible via the {#response} method.
	class ResponseError < Error
		# Returns the response of the last request
		# @return [Net::HTTPResponse] A subclass of Net::HTTPResponse, e.g.
		# Net::HTTPOK
		attr_reader :response

		# Instantiate an instance of ResponseError with a Net::HTTPResponse object
		# @param [Net::HTTPResponse]
		def initialize(response)
			@response = response
		end
	end

	# Exception that is raised when request has redirected too many times.
	# Calling {#response} returns the Net:HTTP response object.
	class RedirectionTooDeep < ResponseError;
	end
end
