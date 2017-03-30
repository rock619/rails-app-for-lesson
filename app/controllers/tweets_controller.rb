class TweetsController < ApplicationController
  # before_actionを用いてログインしていなければログイン画面へ返す
  # ヒント: authenticate_〇〇!（deviseのヘルパーメソッド）
  before_action :authenticate_user!

  def index
    # allを使ってTweetの全レコードの取得しインスタンス変数に格納
    # @tweets = Tweet.all
      #→ ページングする場合は...  →  参照：「ページング機能を実装しよう」
      @tweets = Tweet.page(params[:page]).per(10)
        #→  並び順かえたい場合は...  →  「rails order」で検索
        @tweets = @tweets.order("created_at DESC")
    # form_forに渡すインスタンスを生成
    @tweet = Tweet.new
  end

  def create
    # ストロングパラメーターを元にインスタンスを生成
    @tweet = Tweet.new(tweet_params)
    # 投稿したuser_idをtweetのuser_idカラムにセット　→　参照：「[railsブログを作ろう②]ユーザーとポストを紐付けよう！」
    @tweet.user_id = current_user.id
    # データベースへ保存する  →  参照：week2「データの保存、抽出」
    @tweet.save
    # ツイート一覧へリダイレクト　→　参照：week2「コントローラーの様々なメソッドを学ぶ」
    redirect_to tweets_url
  end


  def destroy
    # レコードを１件取得　→ 参照：week2「データの保存、抽出」
    @tweet = Tweet.find(params[:id])
    # 取得したレコードの削除　→  参照：week2「データの保存、抽出」
    @tweet.destroy
    # ツイート一覧へリダイレクト　→　参照：week2「簡易掲示板を作ろう３」
    redirect_to tweets_url
  end

  # ここからprivateメソッド
  private
    #ストロングパラメーターを設定
    def tweet_params
      params.require(:tweet).permit(:body, :user_id)
    end
end
