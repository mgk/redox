module Redox
  # Serialize the Visit response object from Redox
  class Visit
    include Util
    def initialize(visit_hash)
      map_hash_to_attributes(visit_hash.rubyize_keys)
    end
  end
end