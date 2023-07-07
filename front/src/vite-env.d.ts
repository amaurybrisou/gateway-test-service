/// <reference types="vite/client" />
/// <reference types="vitest" />

interface ImportMetaEnv {
  readonly VITE_HTTP_SERVER_ADDR: string
  readonly VITE_HTTP_SERVER_PORT: number
  // more env variables...
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
