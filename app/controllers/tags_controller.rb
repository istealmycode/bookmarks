# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = current_user.tags
  end
end
