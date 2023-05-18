# frozen_string_literal: true

class ErrorMessageSerializer
  def self.serialize(error)
    {
      "errors": [
        {
          "detail": error
        }
      ]
    }
  end
end
