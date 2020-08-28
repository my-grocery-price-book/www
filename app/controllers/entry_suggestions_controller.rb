# frozen_string_literal: true

class EntrySuggestionsController < ApplicationController
  before_action :authenticate_shopper

  def index
    @names = EntryOwner.name_suggestions(shopper: current_shopper, query: params[:query])
  end
end
