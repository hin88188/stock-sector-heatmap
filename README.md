# Stock Sector Heatmap (板塊強弱勢排行)

![Version](https://img.shields.io/badge/version-1.6.1-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

一個基於 Web 的即時股市板塊熱力圖工具，專為分析美股 (US) 與港股 (HK) 的板塊強弱勢而設計。透過視覺化的方式，快速掌握市場資金流向與板塊輪動。

## 📸 介面預覽

| 成交排行 | 成交排行（詳細） | 強勢排行 |
|:---:|:---:|:---:|
| ![成交排行](https://github.com/hin88188/stock-sector-heatmap/blob/main/screenshots/turnover_list.png) | ![成交排行（詳細）](https://github.com/hin88188/stock-sector-heatmap/blob/main/screenshots/turnover_list_detail.png) | ![強勢排行](https://github.com/hin88188/stock-sector-heatmap/blob/main/screenshots/strong_ranking.png) |

## ✨ 特色功能

- **多市場支援**：即時切換 **美股 (US)** 與 **港股 (HK)** 數據。
- **多重時間範圍**：支援 1日 (1D)、5日 (5D)、10日 (10D)、1月 (1M)、6月 (6M) 及 年初至今 (YTD) 的漲跌幅分析。
- **加權算法**：採用 **市值加權平均 (Market-Cap Weighted Average)** 計算板塊漲跌幅，更真實反映市場狀況。
- **搜尋股票**：支援跨市場模糊搜尋，快速定位到特定股票。
- **互動式介面**：
  - **板塊熱力圖**：以紅綠色塊直觀顯示板塊漲跌，色塊寬度代表相對強弱幅度。
  - **詳細成分股**：點擊板塊即可展開查看該板塊的所有成分股。
  - **市場寬度 (Market Breadth)**：顯示上漲/下跌家數比例。
  - **恐懼與貪婪指數 (Fear & Greed Index)**：即時顯示市場情緒指標，含歷史走勢圖與極值標記。
  - **股票詳情視窗**：點擊任一股票可開啟詳情頁，包含互動式走勢圖與完整財務數據。
- **現代化設計**：
  - **響應式佈局 (Responsive)**：完美支援桌機與行動裝置。
  - **深色模式 (Dark Mode)**：預設深色主題，並可一鍵切換淺色模式，適合長時間看盤。
  - **語言切換**：支援繁體中文、簡體中文、英文三種語言，自動記憶使用者偏好。
  - **設定面板**：可調整字型大小 (50%-200%)、外觀模式及語言，設定自動保存。

## 🚀 快速開始

### 直接執行（推薦給一般使用者）
1. 下載本專案或直接下載 `sector_heatmap.html` 檔案。
2. 使用瀏覽器 (Chrome, Edge, Safari, Firefox) 直接開啟 `sector_heatmap.html` 即可使用。

### 開發環境（推薦給開發者）

#### 前置需求
- Node.js 18+ (建議使用 LTS 版本)
- npm 或 yarn

#### 安裝步驟

1. Clone 專案：
   ```bash
   git clone https://github.com/hin88188/stock-sector-heatmap.git
   cd stock-sector-heatmap
   ```

2. 安裝依賴：
   ```bash
   npm install
   ```

3. 啟動開發伺服器：
   ```bash
   npm run dev
   ```
   瀏覽器會自動開啟 `http://localhost:5173`

4. 建置正式版本：
   ```bash
   npm run build    # 建置至 dist/ 目錄
   npm run preview  # 預覽正式版本
   ```

#### 開發工具
- **熱模組替換 (HMR)**：修改程式碼後頁面自動更新
- **Agentation**：開發環境自動載入，協助 UI 標注與 AI 協作（僅在 `npm run dev` 時載入）

### 部署（適用於伺服器管理員）

若要部署到自定義伺服器：

1. 複製部署配置範本：
   ```bash
   cp .env.deploy.example .env.deploy
   ```

2. 編輯 `.env.deploy` 設定部署路徑：
   ```bash
   DEPLOY_DIR="/your/server/path"
   ```

3. 執行部署腳本：
   ```bash
   ./deploy.sh
   ```

   腳本會自動：
   - 建置 Vite 專案
   - 複製輸出到部署目錄
   - 同步更新 `sector_heatmap.html`（可直接分發給使用者）

> **注意**：`.env.deploy` 包含敏感路徑，已加入 `.gitignore`，不會上傳到 GitHub。

## 🛠️ 技術架構

- **框架**：React 18 + Vite 6
- **樣式**：Tailwind CSS 4
- **圖表**：TradingView Lightweight Charts 4.2
- **圖示**：Lucide React
- **開發工具**：Agentation (僅開發環境)

## 📂 檔案結構

```
stock-sector-heatmap/
├── index.html              # Vite 入口 HTML
├── package.json            # 專案配置與依賴
├── vite.config.js          # Vite 配置
├── deploy.sh               # 部署腳本
├── .env.deploy.example     # 部署配置範本
├── src/
│   ├── main.jsx            # React 進入點
│   ├── App.jsx             # 主要應用元件
│   └── index.css           # 全域樣式
├── sector_heatmap.html     # 原始單一 HTML 版本
├── assets/                 # 靜態資源圖檔
├── docs/                   # 專案文件
├── tools/                  # 輔助工具腳本
├── screenshots/            # 截圖
├── CHANGELOG.md            # 更新日誌
└── README.md               # 專案說明文件
```

## 📝 版本紀錄

**最新版本: v1.6.1** (2026-02-15)
- ⚡ 效能優化：API 請求量減少 50%，並行載入 K 線圖表
- 🔄 數據優化：改進 K 線數據切片演算法
- 🛠️ 穩定性：修正部分圖表載入問題

👉 [查看完整更新日誌](CHANGELOG.md)

## 🤝 貢獻

歡迎提交 Issue 或 Pull Request 來協助改進這個專案！

## 📄 授權

MIT License
