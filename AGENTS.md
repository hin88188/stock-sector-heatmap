# PROJECT KNOWLEDGE BASE

**Generated:** 2026-02-26
**Commit:** N/A (uncommitted changes might exist)

## OVERVIEW
Stock Sector Heatmap is a React-based single-page application (SPA) that visualizes stock market data using a treemap layout. It displays stock performance across different sectors for US and HK markets, utilizing Vite for building and Tailwind CSS for styling.

## STRUCTURE
```
./
├── assets/         # Static assets (images, fonts, etc.)
├── docs/           # Documentation and related files
├── screenshots/    # Application screenshots for documentation
├── src/            # Application source code
│   ├── App.jsx     # Main application component (contains most of the logic)
│   ├── index.css   # Global Tailwind CSS styles
│   └── main.jsx    # Application entry point
├── tools/          # Utility scripts or tools
└── dist/           # Production build output
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| Main Logic | `src/App.jsx` | Contains state management, data fetching, sector categorization, and treemap rendering logic. |
| Styling | `src/index.css` | Global styles, Tailwind directives, and custom CSS variables. |
| Build Config | `vite.config.js` | Vite configuration, including plugins and build options. |
| Entry Point | `src/main.jsx` | React root rendering and development tool (`agentation`) setup. |
| Dependencies | `package.json` | Project dependencies, scripts, and metadata. |

## CODE MAP
| Symbol | Type | Location | Role |
|--------|------|----------|------|
| `App` | Component | `src/App.jsx` | Main React component handling the entire heatmap application state and UI. |
| `MARKETS` | Constant | `src/App.jsx` | Configuration object defining available markets (US, HK) and API endpoints. |
| `LANGUAGES` | Constant | `src/App.jsx` | Configuration for supported languages (zh-HK, zh-CN, en). |
| `TIME_RANGES` | Constant | `src/App.jsx` | Configuration for selectable time ranges (1D, 5D, 1M, etc.). |
| `IND_IDX` | Constant | `src/App.jsx` | Mapping of API response array indices to data fields (Price, Change, Turnover, etc.). |

## CONVENTIONS
- **State Management**: Uses React hooks (`useState`, `useEffect`, `useMemo`, `useCallback`, `useRef`) heavily within `App.jsx`. No external state management library (like Redux or Zustand) is currently used.
- **Styling**: Tailwind CSS is the primary styling method, supplemented by custom CSS in `index.css`.
- **Charting**: Uses `lightweight-charts` for potential charting features, though the primary visualization is a custom treemap layout implemented with DOM elements.
- **Data Fetching**: Uses standard `fetch` API directly within `useEffect` hooks in `App.jsx`.

## ANTI-PATTERNS (THIS PROJECT)
- Avoid adding complex logic outside of `App.jsx` if it's tightly coupled to the main state, unless refactoring the entire component structure. The current architecture is highly centralized.
- Do not introduce new state management libraries without careful consideration, given the current single-component state approach.

## UNIQUE STYLES
- The treemap layout algorithm is custom-implemented directly in the component using a squarified approach (implied by typical heatmap visualizations, though details are in `App.jsx`).

## COMMANDS
```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build locally
npm run preview
```

## NOTES
- The application relies heavily on a single large file (`App.jsx`) which contains > 200,000 bytes. This might be a target for future refactoring into smaller, more manageable components.
- The `agentation` tool is conditionally loaded in development mode only.
