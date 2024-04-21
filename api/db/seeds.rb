# ユーザーの作成
users = User.create!([
  { email: 'test1@test.com', name: 'テスト太郎', password: '111111' },
  { email: 'test2@test.com', name: 'テスト花子', password: '111111' }
])

# 各ユーザーに対する投稿を作成し、タグを紐付け
posts_with_tags = [
  { title: '太郎の技術ブログ１', content: 'テストテスト', user: users[0], tag_name: '技術' },
  { title: '花子の日常1', content: 'テストテスト', user: users[1], tag_name: '日常' }
]

# 投稿とタグの作成を同時に実行
posts_with_tags.each do |pt|
  post = Post.create!(title: pt[:title], content: pt[:content], user: pt[:user])
  # タグ名で既存のタグを検索、なければ新たに作成
  tag = Tag.find_or_create_by(tag_name: pt[:tag_name])
  post.tags << tag
end
