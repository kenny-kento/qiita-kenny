RSpec.describe "Likes", type: :request do

  let(:user) { create(:user) }
  let(:my_post) { create(:post, user: user) }
  let(:like) { create(:like, user: user, post: my_post) }

  before do
    # ユーザー認証のAPIを呼び出し
    post '/api/auth/sign_in', params: { email: user.email, password: user.password }
    # レスポンスから認証トークンを取得
    @auth_token = response.headers['authorization']
  end

  describe "いいねを付与する" do
    context '有効なパラメータが渡ってきた場合' do  
      it 'likeレコードの作成を行う' do
        expect {
          post api_v1_likes_path,
               params: { like: { post_id: my_post.id } },
               headers: { authorization: @auth_token }
        }.to change(Like, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context '無効なパラメータが渡ってきた場合' do
      it 'likeレコードの作成を行わない' do
        expect {
          post api_v1_likes_path, params: { like: { post_id: "文字列" } }, headers: { authorization: @auth_token }
        }.not_to change(Like, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe "いいねを解除する" do
    context '対象の投稿が既にいいね済みの場合' do
      it 'いいねを解除(いいねのレコードを削除する)' do
        delete api_v1_like_path(like.post_id),headers: { authorization: @auth_token }
        expect(response).to have_http_status(:no_content)
      end
    end

    context '対象の投稿がまだいいねされていない場合' do
      it 'not_foundのみを返却する' do
        delete api_v1_like_path(99999),headers: { authorization: @auth_token }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
