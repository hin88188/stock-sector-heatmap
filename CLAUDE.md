# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 專案概覽

Stock Sector Heatmap（板塊強弱勢排行）— 單檔 React SPA，視覺化美股/港股板塊漲跌表現。整個應用集中在 `src/App.jsx`（約 4,300 行），使用 Vite + Tailwind CSS v4 建置。透過 `vite-plugin-singlefile` 將所有資源 inline 成單一 HTML 檔案。

## 開發指令

```bash
npm run dev       # 啟動開發伺服器 http://localhost:5173（Vite proxy 自動轉發 API）
npm run build     # 正式建置 → dist/（CSS/JS 全部 inline 的單一 HTML）
npm run preview   # 本地預覽正式建置結果
```

專案無 lint、format、test 指令，無 ESLint/Prettier 設定。

## 架構

**單體元件設計。** 所有邏輯集中在 `src/App.jsx`，包含狀態管理、資料抓取、子元件定義。子元件（TurnoverList、StockDetailModal、StockChart、StockTable、SearchModal、SectorCard、FearGreedModal 等）皆為同檔案內的函式元件。

**API 代理架構（v1.6.9+）：**
- 開發環境：Vite `server.proxy`（`vite.config.js`）將 `/api/lbkrs`、`/api/feargreed` 轉發至對應 API
- 正式環境：nginx 反向代理（NPM Custom Locations）處理相同路徑
- 前端統一使用相對路徑，透過 `API` 路由物件管理，無環境判斷邏輯
- **重要**：代理必須清除 `Accept-Language` header，否則 lbkrs.com API 會以此覆蓋 `locale` 參數

**資料流：**
1. `fetchData()` 透過 `/api/lbkrs/` 相對路徑呼叫 lbkrs.com 市場 API
2. 回應快取於 localStorage，TTL 5 分鐘（key: `stockdata_<market>_<language>`）
3. `processedSectors` useMemo 依產業分群並計算市值加權平均漲跌幅
4. 主要市場載入後，延遲 3 秒預載另一個市場的資料

**狀態管理：** 全部在 `App` 元件內以 React hooks 管理。狀態持久化至 localStorage（市場、時間範圍、檢視模式、深色模式、語言、字型大小、資料快取、52 週快取）。無外部狀態管理套件。

**競態條件防護：** 使用 `fetchIdRef` / `fetchOtherMarketIdRef` 計數器拋棄過時的 API 回應。

## API 結構

- **市場資料**：lbkrs.com API 以陣列回傳每檔股票資料，陣列索引 → 欄位對應定義在 `IND_IDX` 常數
- **時間範圍**：`TIME_RANGES` 將 UI 標籤（1D、5D 等）映射到 API 索引
- **圖表**：使用 Lightweight Charts 顯示股票詳情（1D 分時、5D 多日分時、長週期 K 線）
- **恐懼與貪婪指數**：從 feargreedmeter.com Next.js data endpoint 取得

## 樣式系統

- Tailwind CSS v4 + `@tailwindcss/vite` 插件
- 深色模式：透過 `<html>` 元素的 `.dark` class 控制
- 自訂色系：`quote-up`（綠 #06A870）、`quote-down`（紅 #F03A55）、`quote-neutral`（#646F85）
- 全螢幕固定佈局（`body { position: fixed; overflow: hidden }`）

## 建置與部署

`vite-plugin-singlefile` 將所有資源 inline 成單一 HTML。`deploy.sh` 負責建置並複製到 NPM 的靜態檔目錄。部署前需在 NPM 設定 Custom Locations（參考 `nginx/custom-locations.conf`）。

## 重要常數

- `MARKETS`：美股（limit 2000）與港股（limit 300），`.path` 存 API 相對路徑
- `LANGUAGES`：zh-HK（預設）、zh-CN、en — 控制 API 資料語言，非 UI 語言
- `TIME_RANGES`：1D/5D/10D/1M/6M/YTD 對應 API 索引

## 專案慣例

- 程式碼註解與 UI 文字使用繁體中文
- 版本更新同時修改 `package.json` 與 commit message（如 `feat(v1.6.9):`）
- 52 週圓環功能：可視區域偵測、批次預載（每批 10 筆、間隔 50ms）、localStorage 快取（24 小時 TTL）、失敗重試機制
- `agentation` 開發工具僅在 dev 模式載入（見 `src/main.jsx`）
