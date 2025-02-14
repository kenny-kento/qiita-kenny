RSpec.describe "Posts", type: :request do

  # Factoryを使ってテスト用のユーザーと投稿を作成。
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }


  describe "記事検索機能" do
    context '検索キーワードにマッチした場合' do
      it 'キーワードと一致する記事を返却する' do
        # キーワードに一致する投稿と一致しない投稿をそれぞれ作成
        matching_post = create(:post, title: 'Rails is awesome', user: user)
        non_matching_post = create(:post, title: 'Python tutorial', user: user)
    
        get '/api/v1/posts/search', params: { keyword: 'Rails' }
    
        json_response = JSON.parse(response.body)
        expect(json_response.map{ |p| p['id'] }).to contain_exactly(matching_post.id)
      end
    end

    context '検索キーワードとマッチする記事が1件もない場合' do
      it '何も返却しない' do
        non_matching_post = create(:post, title: 'Python tutorial', user: user)
    
        get '/api/v1/posts/search', params: { keyword: 'Rails' }
    
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(0)
      end
    end

    context 'キーワードが指定されていない場合' do
      it 'すべての記事を返却する' do
        posts = create_list(:post, 2, user: user)
    
        get '/api/v1/posts/search'
    
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(2)
      end
    end
    
  end
end
