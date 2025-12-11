# 🌐 Simple Fetch Tool Addon for Godot

An addon (plugin) for Godot 4.x that implements a Global Singleton (autoload) named **`FETCH`** to simplify asynchronous HTTP/S requests (`GET` and `POST`).

## ⚙️ Features

* **Global Singleton:** Access networking functionality from any script as `FETCH.POST(...)`.
* **Modern Asynchronous:** Uses Godot's `await` syntax for clean, non-blocking network calls.
* **Safe Cleanup:** Automatically handles the creation and reliable destruction of `HTTPRequest` nodes to prevent memory leaks and network errors.

---

## 🚀 Installation and Usage

#### 1. Installation

1.  Download the contents of the `addons/fetch_api` folder.
2.  Copy the `fetch_api` folder into your Godot project's `addons/` directory.
3.  Go to **Project > Project Settings > Plugins**.
4.  Find **"Simple Fetch Tool"** and ensure it is **Enabled**.

The **`FETCH`** Singleton is now available globally.

#### 2. Usage Examples

The `FETCH` Singleton returns a `FETCH.RESPONSE` object. All calls must be preceded by `await` and be placed inside a function marked as `func _method():`.

#### A. GET Request (getting Data)

```gdscript
# In any script (e.g., your GameController.gd)
const URL = "YOUR_WEB_OR_API_URL"
**

func get_data():
    var result : FETCH.RESPONSE = await FETCH.GET(URL)
    // this returns a RESPONSE class object
  
```
##### B. POST Request (Sending Data)

```gdscript
# In any script (e.g., your GameController.gd)
const URL = "YOUR_WEB_OR_API_URL"

func send_data():
    # Data to send (Example structure)
    var data_to_send = {
        "my": "data here",
        "data": 999
    }
    
    # The body must be a JSON String
    var body_json : String = JSON.stringify(data_to_send)
    
    # Add your own Headers
    var post_headers = [
        "Content-Type: application/json", // "Content-Type: text/plain;charset=utf-8" 
    ]
    
    # Asynchronous Call
    var result : FETCH.RESPONSE = await FETCH.POST(URL, post_headers, body_json)
    // this returns a RESPONSE class object
    
```
##### C. FETCH.RESPONSE (OBJECT)

```gdscript

class RESPONSE: 
	var connection : int // HTTPRequest Result (Internal Godot Class)  RESULT_SUCCESS, RESULT_CONNECTION_ERROR
	var status : int // HTTP code response -> 200, 300, 302 ... 
	var headers :  PackedStringArray // http common headers 
	var response :  String // Server response (usually needs to be transformed into JSON) 
  
```
