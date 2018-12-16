class Assignment < ApplicationRecord
  class Role
    include Comparable

    VALID_ROLES = %w(employee manager director owner).freeze

    def initialize(role)
      unless role.in?(VALID_ROLES)
        raise ArgumentError,
              "expected one of #{VALID_ROLES.inspect}, got #{role.inspect}"
      end

      @raw_role = role
    end

    # This needs to be below the initializer.
    VALID_ROLES.each do |role|
      const_set(role.upcase, new(role))
    end

    # Conform to comparable.
    def <=>(other)
      VALID_ROLES.index(to_s) <=> VALID_ROLES.index(other.to_s)
    end

    def to_s
      raw_role
    end

    def inspect
      "#<Assignment::Role::#{to_s.upcase}>"
    end

    private

    attr_reader :raw_role
  end
end
