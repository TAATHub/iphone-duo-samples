# iPhone Duo Samples

iPhone Duo の画面サイズと、iOS 27.1 で追加された折りたたみ端末向けの SwiftUI API を確かめるためのサンプルアプリです。5 つのタブに、それぞれ別の機能のサンプルを実装しています。

## 動作環境

- Xcode 27.1 beta
- iOS 27.1
- iPhone Duo シミュレータ（または実機）

## サンプル

| タブ | 内容 | 主な API |
|---|---|---|
| Hinge | ヒンジの角度をリアルタイムに表示する | `onHingeChange` |
| Layout | 画面サイズ、セーフエリア、サイズクラスを色分けして表示する | `GeometryReader`, `safeAreaInsets` |
| Arrangement | 2 つの View を重ねる／並べる配置を、プレイヤーと歌詞表示の例で比べる | `ArrangementView`, `arrangementViewStyle(.overlay / .split)` |
| Regions | ヒンジやカメラなど、ハードウェアに隠される領域を画面上に描く | `GeometryProxy.reservedRegions(kind:options:)` |
| Toolbar | 縦のバーに移るツールバー項目の扱いを見比べる | `axisBehavior`, `visibilityPriority`, `toolbarVerticalBehavior`, `toolbarVerticalCompressionBehavior` |

各タブのコード、シミュレータでの実測値、閉じた状態・半開き・平らに開いた状態での配置の違いは、解説資料 [docs/iphone-duo-sample-guide.html](docs/iphone-duo-sample-guide.html) にまとめています。ダウンロードしてブラウザで開いてください。

## ビルド

1. `iPhoneDuoTest.xcodeproj` を Xcode で開く
2. Signing & Capabilities で自分の開発チームを選ぶ
3. iPhone Duo シミュレータを選んで実行する

## ディレクトリ構成

```
iPhoneDuoTest/
├── App/                     # アプリのエントリポイントとタブの定義
└── Features/
    ├── Hinge/               # タブ 1
    ├── ScreenLayout/        # タブ 2
    ├── Arrangement/         # タブ 3
    ├── ReservedRegions/     # タブ 4
    └── Toolbar/             # タブ 5
docs/
└── iphone-duo-sample-guide.html
```

## 注意点

- シミュレータにはカメラがないため、カメラに関係する挙動（カメラ起動時の予約領域の変化など）は実機で確認する必要があります。
