# import requests

# base_url = "http://localhost:8080"
# paths = [
#     "/wp-login.php", "/wp-admin", "/secret-admin", "/admin", "/dashboard",
#     "/user", "/login", "/cms", "/blog/wp-login", "/wp-json", "/feed"
# ]

# print("🔍 Predicting hidden paths...\n")

# for path in paths:
#     try:
#         url = base_url + path
#         response = requests.get(url, timeout=5)
#         status = response.status_code
#         if status == 200:
#             print(f"[FOUND] {path} → 200 OK")
#         elif status == 302:
#             print(f"[REDIRECT] {path} → 302 Found")
#         elif status == 403:
#             print(f"[BLOCKED] {path} → 403 Forbidden")
#         elif status == 404:
#             pass  # Silence expected failures
#         else:
#             print(f"[OTHER] {path} → {status}")
#     except Exception as e:
#         print(f"[ERROR] {path} → {e}")

import requests
import json

base_url = "http://localhost:8080"
paths = [
    "/wp-login.php", "/wp-admin", "/secret-admin", "/admin", "/dashboard",
    "/user", "/login", "/cms", "/blog/wp-login", "/wp-json", "/feed"
]

print("🔍 Predicting hidden paths...\n")
found_paths = []

for path in paths:
    try:
        url = base_url + path
        response = requests.get(url, timeout=5)
        status = response.status_code
        if status == 200:
            print(f"[FOUND] {path} → 200 OK")
            found_paths.append(path)
        elif status == 302:
            print(f"[REDIRECT] {path} → 302 Found")
        elif status == 403:
            print(f"[BLOCKED] {path} → 403 Forbidden")
        elif status == 404:
            pass
        else:
            print(f"[OTHER] {path} → {status}")
    except Exception as e:
        print(f"[ERROR] {path} → {e}")

# Final JSON result for WhatWeb plugin
print(json.dumps({"found_paths": found_paths}))