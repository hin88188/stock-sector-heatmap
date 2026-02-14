#!/bin/bash
# 部署腳本：將 Vite 單檔 build 輸出部署到自定義目錄
# 用法：./deploy.sh
#
# 設定方式：
# 1. 複製 .env.deploy.example 為 .env.deploy
# 2. 編輯 .env.deploy 設定 DEPLOY_DIR 路徑

set -e

# 路徑設定
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 載入部署配置（不上傳到 GitHub）
if [ -f "$PROJECT_DIR/.env.deploy" ]; then
    source "$PROJECT_DIR/.env.deploy"
fi

# 檢查 DEPLOY_DIR 是否已設定
if [ -z "$DEPLOY_DIR" ]; then
    echo "❌ 錯誤：請設定 DEPLOY_DIR"
    echo ""
    echo "請執行以下步驟："
    echo "1. 複製 .env.deploy.example 為 .env.deploy"
    echo "2. 編輯 .env.deploy 設定 DEPLOY_DIR 路徑"
    echo ""
    echo "範例："
    echo "  cp .env.deploy.example .env.deploy"
    echo "  nano .env.deploy"
    exit 1
fi

echo "🔨 正在建置（單一 HTML 檔案）..."
cd "$PROJECT_DIR"
npm run build

echo "📦 複製 index.html 到部署目錄..."
cp "$PROJECT_DIR/dist/index.html" "$DEPLOY_DIR/index.html"

# 同步更新現時目錄的 sector_heatmap.html
echo "📦 同步更新 sector_heatmap.html..."
cp "$PROJECT_DIR/dist/index.html" "$PROJECT_DIR/sector_heatmap.html"

echo "✅ 部署完成！"
echo "   部署目錄：$DEPLOY_DIR"
echo "   index.html 大小：$(du -h "$DEPLOY_DIR/index.html" | cut -f1)"
echo "   sector_heatmap.html 大小：$(du -h "$PROJECT_DIR/sector_heatmap.html" | cut -f1)"
