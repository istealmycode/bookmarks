# frozen_string_literal: true

class AddUserToBookmark < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookmarks, :user, null: false, foreign_key: true
  end
end
