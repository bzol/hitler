import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
	plugins: [react()],
	resolve: {
		alias: {
			"react-native": "react-native-web",
		},
	},
	build: {
		rollupOptions: {
			output: {
				dir: "dist/",
				entryFileNames: "cosmos.js",
				// assetFileNames: "plugin.css",
				// chunkFileNames: "chunk.js",
				// manualChunks: undefined,
			},
		},
	},
});
