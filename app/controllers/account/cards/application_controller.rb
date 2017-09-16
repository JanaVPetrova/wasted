class Account::Cards::ApplicationController < Account::ApplicationController
  def current_card
    @current_card ||= current_user.cards.find(params[:card_id])
  end
end
