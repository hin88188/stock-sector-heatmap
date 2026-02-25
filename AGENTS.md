# PROJECT KNOWLEDGE BASE

**Generated:** 2026-02-26
**Branch:** main
**Version:** 1.6.6
**Stack:** React 18.3.1 + Vite 7.3.1 + lightweight-charts 4.2.3 + Tailwind CSS 4.2.1 + vite-plugin-singlefile 2.3.0

## OVERVIEW
React + Vite SPA，展示美股（US）與港股（HK）板塊熱力圖。使用 `lightweight-charts 4.2.3` 繪製 K 線/基準線圖表，Tailwind CSS 4 配合 dark mode，`vite-plugin-singlefile` 輸出單一 HTML。所有邏輯集中於 `src/App.jsx`（4184 行）。

## STRUCTURE
```
.
├── src/
│   ├── App.jsx         # 全部 UI 元件、狀態、工具函式（4184 行）
│   ├── main.jsx        # React DOM 注入（20 行）
│   └── index.css       # Tailwind + 自訂 utility（98 行）
├── screenshots/        # 應用程式介面截圖（文件用）
├── index.html          # Vite 入口點
├── vite.config.js      # plugins: react, tailwindcss, viteSingleFile
├── deploy.sh           # 手動部署腳本（讀 .env.deploy）
└── sector_heatmap.html # build 產出，直接分發用（gitignore dist/，但此檔在根）
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| 任何 UI/邏輯修改 | `src/App.jsx` | 行號區段見 CODE MAP |
| 圖表元件 | App.jsx L1261–L1655 | StockChart, FearGreedChart，使用 lightweight-charts |
| 主資料獲取 | App.jsx L3321–L3467 | fetchData / fetchOtherMarketData，含 AbortController |
| 恐貪指數 | App.jsx L2376–L2880 | FearGreedWidget / FearGreedGauge / FearGreedChart / FearGreedModal |
| 板塊卡片 | App.jsx L389–L603 | SectorCard (forwardRef), MiniSectorCard (memo) |
| 股票詳情 Modal | App.jsx L2011–L2348 | StockDetailModal，含 IntersectionObserver 懶載 |
| 虛擬滾動清單 | App.jsx L869–L1260 | TurnoverList，自製虛擬化（ROW_HEIGHT） |
| 市場廣度 | App.jsx L352–L388 / L2885–L3030 | MarketBreadth 元件 + MarketBreadthModal |
| localStorage cache | App.jsx L3294–L3320 | CACHE_TTL_MS / readCache / writeCache |
| 深色模式 | App.jsx L3042+ | darkMode state + `dark:` Tailwind 前綴 |
| 字型大小設定 | App.jsx L3042+ | fontSizePercent / BASE_FONT_SIZE，存 localStorage |
| 格式化工具函式 | App.jsx L138–L256 | formatPercent, formatNumber, formatLargeNumber 等 |
| 構建設定 | `vite.config.js` | base='./', singlefile inline |
| 部署 | `deploy.sh` + `.env.deploy` | .env.deploy 不進版控，含 DEPLOY_DIR |

## CODE MAP — App.jsx 行號區段
| 行號 | 內容 |
|------|------|
| L1–60 | imports + 常數（MARKETS, LANGUAGES, TIME_RANGES, IND_IDX） |
| L61–256 | 工具函式（parseChartData, calculateDerivedFields, format*, getColor*） |
| L257–388 | SVG Icons + Skeleton + MarketBreadth |
| L389–603 | SectorCard (forwardRef) / MiniSectorCard (memo) / StockTable |
| L604–868 | SearchModal / TimeRangeSwitcher / 雜項小元件 |
| L869–1260 | TurnoverList（自製虛擬滾動） |
| L1261–1655 | StockChart（lightweight-charts BaselineSeries + ResizeObserver） |
| L1656–2010 | StockDetailModal 輔助（DetailTabHeader, TimeRangeSwitcher, StockInfoGrid, KeyMetricsPanel） |
| L2011–2348 | StockDetailModal 主體 |
| L2349–2880 | 恐貪指數生態系（FearGreed* 共 5 個元件） |
| L2881–3030 | MarketBreadthModal |
| L3031–3293 | App 主元件 state / refs 宣告 |
| L3294–3320 | localStorage Cache 工具 |
| L3321–3467 | fetchData / fetchOtherMarketData |
| L3468–3635 | useMemo 衍生資料（processedSectors, breadthStats, sectorAvgChanges 等） |
| L3636–EOF | 事件處理 + JSX Render |

## 元件清單（快速查找）
| 元件 | 類型 | 職責 |
|------|------|------|
| `SectorCard` | forwardRef | 板塊卡片主體，含 widthPercent 熱力尺寸計算 |
| `MiniSectorCard` | memo | 精簡板塊卡（切換視圖用） |
| `StockTable` | 一般 | 股票表格，useMemo 排序（sortConfig） |
| `TurnoverList` | 一般 | 虛擬滾動成交額清單，13 Props，ROW_HEIGHT_EXPANDED/COLLAPSED |
| `StockChart` | 一般 | lightweight-charts，BaselineSeries + crosshairMove tooltip + ResizeObserver |
| `FearGreedWidget` | 一般 | 圓環進度條小工具（嵌入主介面） |
| `FearGreedGauge` | 一般 | SVG 儀表板 |
| `FearGreedChart` | 一般 | 分段彩色 lightweight-charts 歷史圖 |
| `FearGreedModal` | 一般 | 完整 Modal，含百分位計算 |
| `MarketBreadth` | memo | 漲跌比例條（up/down/total） |
| `MarketBreadthModal` | 一般 | 漲跌分布詳細 Modal |
| `SearchModal` | 一般 | 多市場股票搜尋，searchStocks useCallback |
| `StockDetailModal` | 一般 | 股票詳情，IntersectionObserver 懶載圖表 |
| `StockInfoGrid` | 一般 | ~30 個財務指標網格（DETAIL_FIELDS 設定） |
| `KeyMetricsPanel` | 一般 | 關鍵指標面板 |
| `Skeleton` | 一般 | 載入佔位基元件 |
| `MarketBreadth` | memo | 市場廣度小條（L352） |

## IND_IDX 欄位索引（src/App.jsx L38）
```
PRICE=0, CHG_1D=1, AMOUNT=2, BALANCE=3, CHG_5MIN=4,
TURNOVER=5, AMP=6, VOL_RATE=7, DEPTH=8, PB=9,
MCAP=10, CHG_5D=11, CHG_10D=12, CHG_1M=13, CHG_YTD=14,
CHG_6M=15, INDUSTRY=16 (注意: 部分標注 // Unused，陣列位置不可錯位)
```

## API 端點（硬編碼）
| 用途 | 端點 |
|------|------|
| 主市場資料 | `https://m-gl.lbkrs.com/...` (MARKETS[id].url) |
| 股票詳情 | DETAIL_API (App.jsx ~L2009) |
| K 線圖表 | CHART_PROXY + CHART_APIS (App.jsx ~L1988–L1999) |
| 恐貪指數 | `feargreedmeter.com/_next/data/{BUILD_ID}/fear-and-greed-index.json` |
| 恐貪指數 Proxy | `api.codetabs.com/v1/proxy` 包裝上方 URL |

## CONVENTIONS
- **Single-File Build**：`vite-plugin-singlefile` 將所有 JS/CSS inline 到單一 HTML，無 chunk。
- **無型別系統**：純 JavaScript（無 TypeScript），無 ESLint 設定。
- **狀態全集中**：App 元件持有 20+ useState，透過 Props Drilling 往下傳（無 Context/Redux）。
- **效能保護**：useMemo 廣泛用於 sortedStocks / processedSectors 等衍生資料；useCallback 用於事件處理。
- **Cache 策略**：localStorage + CACHE_TTL_MS，key 由 getCacheKey(market, timeRange) 組成。
- **防競態**：fetchIdRef（useRef）+ AbortController，避免舊 fetch 覆蓋新資料。
- **多語言**：zh-HK / zh-CN / en，存 localStorage，預設 zh-HK。

## ANTI-PATTERNS (THIS PROJECT)
- **禁止 Code Splitting / Dynamic Import**：`vite-plugin-singlefile` 不支援多輸出。
- **禁止隨意加 CI/CD**：部署依賴 `deploy.sh` + `.env.deploy`，未確認前勿改流程。
- **恐貪指數 Build ID 脆弱**：`feargreedmeter.com` Next.js Build ID 硬編碼，網站更新即 404，修改時需同步更新。
- **公共 CORS Proxy 不可靠**：`api.codetabs.com/v1/proxy` 為免費服務，可能限流或停用，勿新增對此 Proxy 的依賴。
- **Props Drilling 勿加劇**：TurnoverList 已接收 13 個 Props；新功能若需共享狀態，討論是否引入 Context。
- **IND_IDX 有 Unused 欄位**：部分索引標注 `// Unused`，修改陣列時勿錯位其他欄位對應。
- **勿拆分 App.jsx 為 ES 模組**：Single-File 模式下多檔案 import 問題較複雜，重構前先確認 build 策略。

## UNIQUE STYLES
- `dark:` Tailwind 前綴搭配 `document.documentElement.classList.toggle('dark')`，非 CSS variable。
- `no-scrollbar` 為 index.css 自訂 utility。
- SVG Icons 全部為 inline 函式元件（無外部 icon library，僅 lucide-react 少量使用）。
- `transition-duration: 0.01ms !important`（index.css）用於無障礙媒體查詢 `prefers-reduced-motion`。

## COMMANDS
```bash
npm run dev       # 開發伺服器 (Vite HMR)
npm run build     # 輸出 dist/index.html（單一 HTML，含所有 inline JS/CSS）
npm run preview   # 預覽 dist/
./deploy.sh       # 手動部署（需 .env.deploy 含 DEPLOY_DIR）
```

## NOTES
- `sector_heatmap.html` 在根目錄 = 直接以檔案分發的產出，非標準 web server 部署。
- `agentation` 在 devDependencies：開發環境 UI 標注工具，與主應用無關。
- App.jsx 4184 行為單一 God Component 反模式；未來重構優先拆分：工具函式 → hooks → 子元件。
- `dist/` 在 .gitignore，`sector_heatmap.html` 不在，因此 build 產出透過根目錄檔案進版控追蹤。