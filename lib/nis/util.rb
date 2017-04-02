module Nis::Util
  def self.error_handling(hash)
    error_klass = case hash[:error]
      when 'Bad Request' then Nis::BadRequestError
      else Nis::Error
    end
    error_klass.new(hash[:message])
  end
end

Dir[File.expand_path('../util/*.rb', __FILE__)].each { |f| require f }
