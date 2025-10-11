# Neovim Configuration

個人用のNeovim設定ファイル（Lua）です。

## ディレクトリ構造

```
.config/nvim/
├── init.lua                # エントリーポイント
├── lazy-lock.json          # lazy.nvimのロックファイル
├── cspell.json             # スペルチェック設定
├── cspell.config.yaml      # スペルチェック設定
├── .stylua.toml            # Luaフォーマッター設定
├── .luarc.json             # Lua言語サーバー設定
├── after/
│   └── lsp/                # LSP個別設定
│       ├── cspell.lua      # cspell LSP設定
│       ├── lua_ls.lua      # Lua言語サーバー設定
│       └── ts_ls.lua       # TypeScript言語サーバー設定
└── lua/
    ├── lazy-init.lua       # lazy.nvim初期化
    ├── core/               # コア設定
    │   ├── options.lua     # Neovimオプション
    │   ├── keymaps.lua     # キーマッピング
    │   ├── autocmds.lua    # 自動コマンド
    │   └── globals.lua     # グローバル変数・関数
    └── plugins/            # プラグイン設定
        ├── init.lua        # プラグインローダー
        ├── production/     # 本番環境のプラグイン
        │   ├── utilities.lua         # 統合設定
        │   ├── alpha-nvim.lua        # スタート画面
        │   ├── gitsigns-nvim.lua     # Git差分表示
        │   ├── hop.lua               # 高速移動
        │   ├── lualine.lua           # ステータスライン
        │   ├── nvim-cmp.lua          # 補完
        │   ├── nvim-hlslens.lua      # 検索結果強調
        │   ├── nvim-lspconfig.lua    # LSP設定
        │   ├── nvim-scrollbar.lua    # スクロールバー
        │   ├── nvim-treesitter.lua   # シンタックスハイライト
        │   └── telescope-nvim.lua    # ファジーファインダー
        └── development/    # 開発・テスト用プラグイン
            └── sample.lua  # サンプルテンプレート
```

## 設定の読み込み順序

1. `init.lua` - エントリーポイント
   - `lazy-init.lua` - lazy.nvimの初期化とプラグイン読み込み
   - `core.options` - Neovimの基本設定
   - `core.keymaps` - キーバインド設定
   - `core.autocmds` - 自動コマンド設定

2. `lua/plugins/init.lua` - プラグイン設定の読み込み
   - `production/` 配下の全ての`.lua`ファイル
   - `development/` 配下の全ての`.lua`ファイル

3. `after/lsp/` - LSP個別設定（遅延読み込み）

## 主要なプラグイン

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Colorscheme**: [vim-hybrid](https://github.com/w0ng/vim-hybrid)
- **LSP**: nvim-lspconfig, fidget.nvim, lsp_lines.nvim
- **Completion**: nvim-cmp
- **Fuzzy Finder**: telescope.nvim
- **Syntax**: nvim-treesitter
- **Git**: gitsigns.nvim, gopr.nvim, gobf.nvim, goacf.nvim
- **UI**: lualine.nvim, alpha-nvim, nvim-scrollbar

## プラグインの追加

新しいプラグインを追加する際：

1. **テスト環境で試す**: `lua/plugins/development/` に新しい`.lua`ファイルを作成
2. **本番環境に移行**: 動作確認後、`lua/plugins/production/` に移動

詳細は `lua/plugins/README.md` を参照してください。

## カスタマイズ

- **オプション**: `lua/core/options.lua`
- **キーマップ**: `lua/core/keymaps.lua`
- **自動コマンド**: `lua/core/autocmds.lua`
- **グローバル設定**: `lua/core/globals.lua`
- **LSP設定**: `after/lsp/*.lua`
