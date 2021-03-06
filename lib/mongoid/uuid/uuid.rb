require 'bson'
require 'moped'

# encoding: utf-8
module Mongoid # :nodoc:
  module Uuid #:nodoc:
    module Uuid
      extend ActiveSupport::Concern

      included do
        field :uuid, type: BSON::Binary, default: -> { BSON::Binary.new(SecureRandom.uuid, :uuid) }
        index({:uuid => 1}, {:unique => true})
        before_validation :generate_uuid
        validates :uuid, :uniqueness => true, :uuid => true
        attr_readonly :uuid
      end

      private

      # Sets unique UUID unless uuid is present.
      def generate_uuid
        self.uuid = BSON::Binary.new(SecureRandom.uuid, :uuid) if uuid.to_s.empty?
      end
    end
  end
end
