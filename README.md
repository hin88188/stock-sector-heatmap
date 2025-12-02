# Stock Sector Heatmap (板塊強弱勢排行)

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

一個基於 Web 的即時股市板塊熱力圖工具，專為分析美股 (US) 與港股 (HK) 的板塊強弱勢而設計。透過視覺化的方式，快速掌握市場資金流向與板塊輪動。

## 📸 介面預覽

![Stock Sector Heatmap UI](https://github.com/hin88188/stock-sector-heatmap/blob/main/screenshots/UI.png)

## ✨ 特色功能

- **多市場支援**：即時切換 **美股 (US)** 與 **港股 (HK)** 數據。
- **多重時間範圍**：支援 1日 (1D)、5日 (5D)、10日 (10D)、1月 (1M)、6月 (6M) 及 年初至今 (YTD) 的漲跌幅分析。
- **加權算法**：採用 **市值加權平均 (Market-Cap Weighted Average)** 計算板塊漲跌幅，更真實反映市場狀況。
- **互動式介面**：
  - **板塊熱力圖**：以紅綠色塊直觀顯示板塊漲跌，色塊寬度代表相對強弱幅度。
  - **詳細成分股**：點擊板塊即可展開查看該板塊的所有成分股。
  - **市場寬度 (Market Breadth)**：顯示上漲/下跌家數比例。
- **現代化設計**：
  - **響應式佈局 (Responsive)**：完美支援桌機與行動裝置。
  - **深色模式 (Dark Mode)**：預設深色主題，並可一鍵切換淺色模式，適合長時間看盤。

## 🚀 快速開始

本專案為單一 HTML 檔案設計，無需繁雜的安裝步驟。

### 直接執行
1. 下載本專案或直接下載 `sector_heatmap.html` 檔案。
2. 使用瀏覽器 (Chrome, Edge, Safari, Firefox) 直接開啟 `sector_heatmap.html` 即可使用。

### 開發環境
若您希望進行修改或開發：

1. Clone 專案：
   ```bash
   git clone https://github.com/hin88188/stock-sector-heatmap.git
   ```
2. 建議使用 VS Code 開啟資料夾。
3. 使用 "Live Server" 擴充套件開啟 `sector_heatmap.html` 以獲得最佳體驗。

## 🛠️ 技術架構

- **核心**：HTML5, JavaScript (ES6+)
- **框架**：React 18 (透過 Babel Standalone 執行)
- **樣式**：Tailwind CSS (透過 CDN 載入)
- **圖示**：Lucide Icons

## 📂 檔案結構

```
stock-sector-heatmap/
├── sector_heatmap.html  # 主程式入口 (包含所有邏輯與樣式)
├── assets/              # 靜態資源圖檔
├── docs/                # 專案文件
├── tools/               # 輔助工具腳本
├── screenshots/         # 截圖
└── README.md            # 專案說明文件
```

## 📝 版本紀錄

### v1.0.0 (2025-12-03)
- 🎉 首次發布
- 實作美股/港股板塊熱力圖
- 實作市值加權漲跌幅計算
- 整合深色/淺色模式切換

## 🤝 貢獻

歡迎提交 Issue 或 Pull Request 來協助改進這個專案！

## 📄 授權

MIT License
