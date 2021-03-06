module Redox
  module Models
    class Model < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared
      include Hashie::Extensions::IndifferentAccess

      property :Meta, from: :meta, required: false
      property :Patient, from: :patient, required: false
      property :PotentialMatches, from: :potential_matches, required: false
      property :Extensions, from: :extensions, required: false
      property :response, required: false

      alias_method :potential_matches, :PotentialMatches
      alias_method :patient, :Patient
      alias_method :meta, :Meta

      def initialize(data = {})
        if data.is_a?(Hash)
          if data.include?(key)
            data = data[key]
          elsif data.include?(key.to_sym)
            data = data[key.to_sym]
          end
        end

        super(data)
      end

      def to_h
        return { key => super.to_h }
      end

      def to_json
        return self.to_h.to_json
      end

      class << self
        def from_response(response)
          model = Model.new
          model.response = response

          %w[Meta Patient PotentialMatches].each do |k|
            begin
              model.send("#{k}=", Module.const_get("Redox::Models::#{k}").new(response[k])) if response[k]
            rescue
            end
          end

          return model
        end
      end

      private

      def key
        return self.class.to_s.split('::').last.to_s
      end
    end
  end
end
