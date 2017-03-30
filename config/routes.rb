Rails.application.routes.draw do
  devise_for :users
  # deviseが自動生成するルーティング
  resources :tweets
  # ツイート一覧画面へのルーティングを定義



# ---------------------------------------------
# 発展課題
  # resourcesを制限する場合
    resources :users, only: [:index, :show] do
      get :favorites, on: :member
    end


  #お気に入り機能をツイートに紐付ける場合
    resources :tweets do
      resource :favorites, only: [:create, :destroy]
    end
# ---------------------------------------------


# ルートパス　でアクセスした時にツイート一覧へのルーティングを定義
  root 'tweets#index'

end
