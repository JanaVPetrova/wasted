class Account::CardsController < Account::ApplicationController
  def index
    @cards = Account::CardDecorator.decorate_collection(current_user.cards)
  end

  def sync
    result = Cards::Sync.call(user: current_user)

    if result.success?
      flash[:success] = t('ok')
    else
      flash[:error] = t('fail')
    end

    redirect_to account_cards_path
  end
end
