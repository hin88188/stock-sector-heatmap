import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import { viteSingleFile } from 'vite-plugin-singlefile'

// https://vite.dev/config/
export default defineConfig({
  base: './',
  plugins: [
    react(),
    tailwindcss(),
    viteSingleFile(),  // 將 CSS/JS 全部 inline 到單一 HTML 檔案
  ],
  server: {
    proxy: {
      '/api/lbkrs': {
        target: 'https://m-gl.lbkrs.com',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api\/lbkrs/, ''),
        headers: { 'Accept-Language': '' },
      },
      '/api/feargreed': {
        target: 'https://feargreedmeter.com',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api\/feargreed/, ''),
      },
    },
  },
})
