module Helper
  module BasicHelper
    NOT_FOUND = 'Record does not exist.'
    REQUIRED_MESSAGE = 'This field is required.'
    PASSWORD_REQUIREMENTS_MESSAGE = 'Password should have more than 6 characters including 1 lower letter, 1 uppercase letter, 1 number and 1 symbol.'
    EMAIL_EXIST_MESSAGE = 'Email already exist.'
    USER_ID_NOT_FOUND = 'We do not recognize your Account. Please try again.'
    RECORD_EXIST_MESSAGE = 'Record already exist.'
    INCORRECT_PASSWORD = 'Incorrect Password.'

    def valid_float?(value)
      data = Float(value.to_s, exception: false)
      return false if data.nil?

      true
    end

    def valid_number?(value)
      data = value.try(:delete, ' ').to_s.match(/^[0-9]*$/)
      return false if data.nil?

      true
    end

    def valid_amount?(value)
      data = Float(value.to_s, exception: false)
      return false if data.nil? || data.negative? || data.zero?

      true
    end

    def valid_english_alphabets?(value)
      data = value.to_s.match(/^[A-Za-z ]*$/)
      return false if data.nil?

      true
    end

    def valid_company_name?(value)
      data = value.match(/^[a-zA-Z0-9_'&:.,@-]+( [a-zA-Z0-9_'&:.,@-]+)*$/)
      return false if data.nil?

      true
    end

    def valid_date?(value)
      return true if value == 'never'

      !(value.match(/\d{4}-\d{2}-\d{2}/) && Time.zone.strptime(value, '%Y-%m-%d')).nil?
    rescue ArgumentError
      false
    end

    def have_space?(value)
      data = value.match(/\s+/)
      return false if data.nil?

      true
    end

    def is_true_false(value)
      (value.is_a?(TrueClass) || value.is_a?(FalseClass)) || (value.downcase.eql?('true') || value.downcase.eql?('false'))
    end

    def is_true(value)
      (value.is_a?(TrueClass) || value.downcase.eql?('true'))
    end

    def valid_img_type?(value)
      data = value.match(%r{^data:image/(jpg|jpeg|png);base64,})
      return false if data.nil?

      true
    end

    def valid_identity_proof?(value)
      data = value.match(%r{^data:image/(jpg|jpeg|png|pdf);base64,})
      return false if data.nil?

      true
    end

    def valid_base64?(value)
      data = value.gsub(%r{^data:image/(jpg|jpeg|png);base64,}, '')

      data.blank? ? false : data.is_a?(String) && Base64.strict_encode64(Base64.decode64(data)) == data
    end

    def valid_json?(value)
      JSON.parse(value)
      return true
    rescue JSON::ParserError => e
      return false
    end
  end
end
