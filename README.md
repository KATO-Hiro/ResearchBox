<img width=40% alt="スクリーンショット 2019-04-19 4 13 33" src="https://user-images.githubusercontent.com/46975885/56385336-c2200300-6259-11e9-83e6-6141a78ab847.png">

# ResearchBox  
url: https://blooming-depths-66785.herokuapp.com
## 概要
読んだ論文を簡潔なフォーマットにまとめて管理し、ユーザー間でシェアするアプリ。以下の3点が強み  
- 読むだけで終わりがちな論文調査作業をアウトプット化して、情報収拾効率をアップさせる  
- 紙やpdfで論文のメモを作成した場合と比較して、散逸しにくい、情報が抽出しやすいため、管理に適している。  
- 読んだ論文のメモを他のユーザーに紹介できる、即ち知的財産の共有が可能。  

### デモ画像
<img width=40% src="https://user-images.githubusercontent.com/46975885/56392952-db32af00-626d-11e9-87b4-a501d2db0d07.png"><img width=40% src="https://user-images.githubusercontent.com/46975885/56392942-d4a43780-626d-11e9-9f58-ba1150c2e697.png"><img width=40% src="https://user-images.githubusercontent.com/46975885/56392959-dff76300-626d-11e9-9fdb-6c0790bfc67f.png"><img width=40% src="https://user-images.githubusercontent.com/46975885/56392966-e4bc1700-626d-11e9-929f-81b8d9e5e874.png">

## 主な機能
- ユーザー管理機能
  - 新規ユーザー登録機能
  - ユーザー詳細表示機能
  - ユーザー一覧表示機能
  - ユーザーアカウント編集・削除機能
  - ユーザーのプロフィール画像アップロード機能
  - ユーザーログイン機能
  - パスワード忘却時の再設定機能
  - メール配信を用いたユーザーの有効化機能
  - ユーザー検索機能
- 記事管理機能
  - 新規記事投稿機能
  - 記事詳細表示機能
  - 記事への複数画像アップロード機能
  - 記事編集・削除機能
  - 記事一覧表示機能
  - 記事検索機能
- 記事のストック機能
  - 記事のストック作成・削除機能
  - ストック数に基づく記事のランキング表示機能
- 記事へのコメント機能
  - 記事へのコメント作成機能
- ユーザー・記事・コメント・検索結果一覧のページネーション機能

## 使用技術
- 開発環境
  - Docker for Mac
- テスト環境
  - RSpec(単体テスト・統合テスト)
- 本番環境
  - Heroku
- DB
  - PostgresQL
- CI / CD
  - CircleCI
- フロント開発
  - Bootstrap
  - Slim
- ユーザー管理機能
  - devise
- 画像アップロード機能
  - CarrierWave
  - fog-aws
- ページネーション機能
  - kaminari
- 検索機能
  - ransack
## 依存関係
- Rails: 5.2.2.1
- Ruby: 2.6.2
- Bootstrap: 4.3.1
- devise: 3.8
## 使いかた
- [使い方の説明](https://blooming-depths-66785.herokuapp.com/about)
- [こちら](https://blooming-depths-66785.herokuapp.com/users/sign_in)にアクセスし、テストユーザーでログイン
- 記事を投稿する
  - 記事一覧ページまたはヘッダーメニューから「投稿する」ボタンをクリック
  - 新規記事投稿ページの入力フォームに、読んだ論文の内容を書き込む
  - トップページ、投稿者の詳細ページに新規記事が追加される。
- 記事を編集・削除する
  - 記事一覧ページまたは自分の詳細ページから、記事カードのフッター部分にある編集または削除ボタンをクリック
- 他のユーザーの記事をストックする
  - 記事一覧ページまたは他人の詳細ページから、記事カードのフッター部分にあるストックボタンをクリック
- 他のユーザーの投稿にコメントする
  - 他のユーザー投稿詳細ページの下層部の「コメントする」ボタンをクリック
## 開発者
Kei Fujikawa  
Twitter: @kei_f_1996  
Qiita: https://qiita.com/kei_f_1996  
GitHub: https://github.com/tenguuweb  
