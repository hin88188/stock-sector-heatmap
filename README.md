# Stock Sector Heatmap (板塊強弱勢排行)

![Version](https://img.shields.io/badge/version-1.6.9-blue.svg)
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
  - **52 週進度指示器**：在成交排行列表中，以漸層圓環顯示股票現價在 52 週高低點的相對位置，支援智慧預載與本地快取秒開。
  - **股票詳情視窗**：點擊任一股票可開啟詳情頁，包含互動式走勢圖、完整財務數據與主要指標儀表板。
- **現代化設計**：
  - **響應式佈局 (Responsive)**：完美支援桌機與行動裝置。
  - **深色模式 (Dark Mode)**：預設深色主題，並可一鍵切換淺色模式，適合長時間看盤。
  - **語言切換**：支援繁體中文、簡體中文、英文三種語言，自動記憶使用者偏好。
  - **設定面板**：可調整字型大小 (50%-200%)、外觀模式及語言，設定自動保存。

## 🚀 快速開始

### 直接執行（推薦給一般使用者）
1. 下載本專案或直接下載 `sector_heatmap.html` 檔案。
2. 使用瀏覽器 (Chrome, Edge, Safari, Firefox) 直接開啟 `sector_heatmap.html` 即可使用。

> **注意**：直接開啟本地 HTML 檔案時，因無 nginx 反向代理，API 資料將無法載入。建議透過 Web 伺服器存取。

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
   瀏覽器會自動開啟 `http://localhost:5173`。Vite 內建 proxy 會自動轉發 API 請求，無需額外設定。

4. 建置正式版本：
   ```bash
   npm run build    # 建置至 dist/ 目錄
   npm run preview  # 預覽正式版本
   ```

## 🚢 部署

本專案使用 nginx-proxy-manager (NPM) 作為反向代理，需要同時設定靜態檔案服務和 API 代理。

### 架構說明

```
瀏覽器 → NPM (nginx) → /api/lbkrs/*  → m-gl.lbkrs.com（市場 API）
                      → /api/feargreed/* → feargreedmeter.com（恐貪指數）
                      → /*             → 靜態 HTML 檔案
```

- **開發環境**：Vite `server.proxy` 內建代理（見 `vite.config.js`）
- **正式環境**：nginx-proxy-manager Custom Locations 反向代理
- **前端程式碼**：統一使用相對路徑 (`/api/lbkrs/...`)，無環境判斷

### 部署步驟

#### 1. 設定部署路徑

```bash
cp .env.deploy.example .env.deploy
# 編輯 .env.deploy 設定 DEPLOY_DIR 為 NPM 的靜態檔目錄
# 範例：DEPLOY_DIR="/path/to/nginx-proxy-manager/data/nginx/my_host"
```

#### 2. 設定 NPM Custom Locations

在 NPM 管理介面中，進入 Proxy Host 設定 → Custom Locations，加入以下兩個 location block（完整設定參考 `nginx/custom-locations.conf`）：

```nginx
# lbkrs.com 市場 API
location /api/lbkrs {
    rewrite ^/api/lbkrs(.*)$ $1 break;
    proxy_pass https://m-gl.lbkrs.com;
    proxy_set_header Host m-gl.lbkrs.com;
    proxy_set_header Accept-Language "";
    proxy_ssl_server_name on;
    proxy_http_version 1.1;
}

# Fear & Greed Index API
location /api/feargreed {
    rewrite ^/api/feargreed(.*)$ $1 break;
    proxy_pass https://feargreedmeter.com;
    proxy_set_header Host feargreedmeter.com;
    proxy_ssl_server_name on;
    proxy_http_version 1.1;
}
```

#### 3. 設定靜態檔案服務

在 NPM 同一個 Proxy Host 的 Custom Locations 中，確保有 `location /` 設定：

```nginx
location / {
    root /data/nginx/my_host;
    index index.html;
}
```

#### 4. 執行部署

```bash
./deploy.sh
```

腳本會自動：
- 執行 `npm run build` 建置單一 HTML
- 複製到 NPM 靜態檔目錄
- 同步更新 repo 根目錄的 `sector_heatmap.html`

> **注意**：`.env.deploy` 包含敏感路徑，已加入 `.gitignore`，不會上傳到 GitHub。

## 🛠️ 技術架構

- **框架**：React 18 + Vite 7
- **樣式**：Tailwind CSS 4
- **圖表**：TradingView Lightweight Charts 4.2
- **建置**：vite-plugin-singlefile（輸出單一 HTML）
- **代理**：Vite server.proxy (dev) / nginx reverse proxy (prod)
- **開發工具**：Agentation (僅開發環境)

## 📂 檔案結構

```
stock-sector-heatmap/
├── index.html              # Vite 入口 HTML
├── package.json            # 專案配置與依賴
├── vite.config.js          # Vite 配置（含 server.proxy）
├── deploy.sh               # 部署腳本
├── .env.deploy.example     # 部署配置範本
├── nginx/
│   └── custom-locations.conf  # NPM Custom Locations 設定參考
├── src/
│   ├── main.jsx            # React 進入點
│   ├── App.jsx             # 主要應用元件
│   └── index.css           # 全域樣式
├── sector_heatmap.html     # 建置產物（單一 HTML）
├── assets/                 # 靜態資源圖檔
├── docs/                   # 專案文件
├── tools/                  # 輔助工具腳本
├── screenshots/            # 截圖
├── CHANGELOG.md            # 更新日誌
├── CLAUDE.md               # AI 開發指引
└── README.md               # 專案說明文件
```

## 📝 版本紀錄

**最新版本: v1.6.9** (2026-06-10)
- 🏗️ 移除第三方 CORS Proxy 依賴，改用 nginx 反向代理 + Vite proxy 架構
- 🐛 修復語言切換（繁/簡/Eng）因 `Accept-Language` header 被 API 覆蓋而失效的問題

👉 [查看完整更新日誌](CHANGELOG.md)

## 🤝 貢獻

歡迎提交 Issue 或 Pull Request 來協助改進這個專案！

## 📄 授權

MIT License
