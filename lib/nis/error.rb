class Nis
  class Error < StandardError; end
  class NotFoundError < Error; end
  class BadRequestError < Error; end
  class InternalServerError < Error; end
end
