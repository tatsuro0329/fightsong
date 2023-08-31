class Stadium < ActiveHash::Base

  scope :exclude_initial_value, -> { where.not(id: 1) }

 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: 'エスコンフィールド北海道' },
   { id: 3, name: '楽天モバイルパーク宮城' },
   { id: 4, name: 'ベルーナドーム' },
   { id: 5, name: 'ZOZOマリンスタジアム' },
   { id: 6, name: '明治神宮野球場' },
   { id: 7, name: '東京ドーム' },
   { id: 8, name: '横浜スタジアム' },
   { id: 9, name: 'バンテリンドーム' },
   { id: 10, name: '京セラドーム大阪' },
   { id: 11, name: 'ほっともっとフィールド神戸' },
   { id: 12, name: '阪神甲子園球場' },
   { id: 13, name: 'MAZDAzoom-zoomスタジアム広島' },
   { id: 14, name: '福岡PayPayドーム' }
 ]
 end