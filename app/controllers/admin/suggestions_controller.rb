class Admin::SuggestionsController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def index
    @suggestions = Suggestion.order_by_time
    .paginate page: params[:page], per_page: Settings.size
  end

  def destroy
    suggestion = Suggestion.find_by id: params[:id]
    if suggestion.nil?
      flash[:danger] = t "suggestion.nil"
      redirect_to :back
    else
      suggestion.destroy
      flash[:success] = t "productindex.delete_success"
      redirect_to admin_suggestions_path
    end
  end
end
