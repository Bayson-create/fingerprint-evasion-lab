import requests
import random

base_url = "http://localhost:8080"
paths = [
    "/js/script-obf.js",
    "/wp-content/themes/twentytwentyfive/style.css",
    "/favicon.ico",
    "/wp-includes/js/dist/script-modules/block-library/navigation/view.min.js"
]

print("🔍 Testing cache-busting...\n")

for path in paths:
    suffix = f"?cb={random.randint(1000,9999)}"
    url = base_url + path + suffix

    try:
        response = requests.get(url, timeout=5)
        size = len(response.text)
        print(f"[{response.status_code}] {path+suffix} → {size} bytes")
    except Exception as e:
        print(f"[ERROR] {url} → {e}")