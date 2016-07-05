class SuggestionsController < ApplicationController
  before_action :logged_in_user, :normal_user?

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = current_user.suggestions.build suggestion_params
    if @suggestion.save
      flash[:success] = t "suggestion.created"
    else
      flash[:danger] = t "suggestion.not_created"
    end
    redirect_to :back
  end
  
  private
  def suggestion_params
    params.require(:suggestion).permit :content
  end
end
