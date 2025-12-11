extends Node

func _ready() -> void:
	var URL : String = "https://pokeapi.co/api/v2/pokemon/pikachu/"
	var result := await  FETCH.GET(URL)
	printt("Connection:", result.connection)
	printt("Headers:", result.headers)
	printt("Status:", result.status)
	printt("response:", JSON.parse_string(result.response).name)
