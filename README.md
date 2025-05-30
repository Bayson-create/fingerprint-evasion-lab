# fingerprint-evasion-lab
A research-driven toolkit and experimental framework for analyzing, evading, and enhancing web application fingerprinting tools like WhatWeb and Wappalyzer. Includes custom plugins, evasive test environments, and deception-based defense techniques inspired by the WASABO model.

# 🕵️‍♂️ Fingerprint Evasion Lab

This project explores how fingerprinting tools can be evaded, extended, and deceived. It centers around a local WordPress deployment hidden behind a Dockerized reverse proxy and targets tools like WhatWeb and Wappalyzer.

## 🔍 Overview

The project includes three main phases:

1. **Attack Experiments** — Apply layered evasion techniques to reduce detectable surface.
2. **Plugin-Level Enhancement** — Build custom WhatWeb plugins to improve detection under obfuscation.
3. **Deceptive Fingerprinting** — Inject misleading headers and HTML content to confuse scanners.
4. **Cross-Tool Validation** — Test the effectiveness of evasion and deception against Wappalyzer.

---

## 🧪 Setup & Usage

### 1. Launch Reverse Proxy

Start the proxy (OpenResty + Lua scripting):

```bash
docker run -d -p 8080:8080 \
-v $(pwd)/conf:/etc/nginx/conf.d \
openresty/openresty:alpine
```

This will forward traffic to your WordPress instance at http://localhost:8080.

### 2. Run WhatWeb Baseline Scan

```bash
bundle exec ./whatweb http://localhost:8080/
```

### 3. Run WASABO Plugins

```bash
bundle exec ./whatweb -p wasabo_path_predict http://localhost:8080/
bundle exec ./whatweb -p wasabo_detect_wordpress http://localhost:8080/
bundle exec ./whatweb -p wasabo_cache_buster http://localhost:8080/
```

### 4. Run Standalone Detection Scripts (Optional)

```bash
python3 path_predictor.py
python3 cache_buster.py
node detect-wordpress.js
```

### 5. Wappalyzer Testing
Open http://localhost:8080 in a browser with the Wappalyzer plugin enabled and observe detection before and after evasion.

## 🔧 Project Components

.
├── detect-wordpress.js       # DOM-based detection using Puppeteer
├── path_predictor.py         # HTTP status-based endpoint scan
├── cache_buster.py           # Randomized URL probe
├── WhatWeb/plugins/          # WASABO plugin implementations
├── conf/docker-nginx-conf/   # Reverse proxy deception config
└── anything/app/public/      # WordPress instance modifications

## 🎯 Key Techniques

Attack Experiments
	•	Remove or obfuscate headers (e.g., Server, X-Powered-By)
	•	Hide CMS meta tags
	•	Obfuscate JavaScript
	•	Block default login/API paths

Plugin-Level Enhancements
	•	Identify hidden paths by HTTP probing
	•	Use headless browser for runtime detection
	•	Circumvent CDN with cache-busting

Deceptive Fingerprinting
	•	Inject false server stack info (e.g., nginx/0.7.65)
	•	Reword CMS versions in live HTML
	•	Redirect or suppress critical fingerprinting paths

 ## ✅ Expected Behavior
 
	•	Before evasion: Tools detect WordPress, PHP, and Nginx correctly
	•	After evasion: Static tools fail to identify the stack
	•	With plugins: Hidden structures and scripts are rediscovered
	•	With deception: Tools report falsified server/CMS versions

 ## 📦 Requirements
	•	Docker
	•	Python 3 (requests)
	•	Node.js (puppeteer)
	•	Ruby (for WhatWeb)

 ## 💡 Notes
	•	Ensure all helper scripts are in the correct relative paths for plugins to function.
	•	You can customize the list of paths, indicators, or header values based on your evasion goals.
