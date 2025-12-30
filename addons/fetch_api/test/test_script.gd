extends Node

func _ready() -> void:
	# Test 1: Basic GET request (existing functionality)
	var URL : String = "https://pokeapi.co/api/v2/pokemon/pikachu/"
	var result := await  FETCH.GET(URL)
	printt("Test 1 - Basic GET Request")
	printt("Connection:", result.connection)
	printt("Status:", result.status)
	printt("Response:", JSON.parse_string(result.response).name)
	print("\n")
	
	# Test 2: GET request with Authorization header (new functionality)
	var auth_url : String = "https://pokeapi.co/api/v2/pokemon/bulbasaur/"
	var auth_headers : PackedStringArray = ["Authorization: Bearer test_token_123"]
	var auth_result := await FETCH.GET(auth_url, auth_headers)
	printt("Test 2 - GET Request with Authorization")
	printt("Connection:", auth_result.connection)
	printt("Status:", auth_result.status)
	printt("Response:", JSON.parse_string(auth_result.response).name)
	print("\n")
	
	# Test 3: POST request (for comparison)
	var post_url : String = "https://httpbin.org/post"
	var post_headers : PackedStringArray = ["Content-Type: application/json", "Authorization: Bearer test_token_456"]
	var post_body : String = '{"name": "test"}'
	var post_result := await FETCH.POST(post_url, post_headers, post_body)
	printt("Test 3 - POST Request with Authorization")
	printt("Connection:", post_result.connection)
	printt("Status:", post_result.status)
