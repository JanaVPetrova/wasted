class Account::Cards::TransactionsController < Account::Cards::ApplicationController
  def sync
    result = ::Cards::Transactions::Sync.call(card: current_card)

    if result.success?
      flash[:success] = t('ok')
    else
      flash[:error] = t('fail')
    end

    redirect_to account_cards_path
  end
end
