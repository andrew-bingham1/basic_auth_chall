# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: { message: 'must be filled out' }
  validates :email, presence: { message: 'must be filled out' },
                    uniqueness: { message: 'is already taken' }

  def self.all_except_me(user)
    where.not(id: user.id)
  end

end
