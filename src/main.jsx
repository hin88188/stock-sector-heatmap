import { StrictMode, lazy, Suspense } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App.jsx';

// 僅在開發環境載入 Agentation（生產 build 會被 tree-shaking 移除）
const AgentationDev = import.meta.env.DEV
    ? lazy(() => import('agentation').then(module => ({ default: module.Agentation })))
    : null;

createRoot(document.getElementById('root')).render(
    <StrictMode>
        <App />
        {import.meta.env.DEV && AgentationDev && (
            <Suspense fallback={null}>
                <AgentationDev />
            </Suspense>
        )}
    </StrictMode>,
);
