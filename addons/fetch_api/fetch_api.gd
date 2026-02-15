extends Node

signal _data_recieved(data : RESPONSE)

func _do_fetch(URL: String, headers:PackedStringArray, 
		callback: Callable , method := HTTPClient.METHOD_GET, 
		body : String = "") -> void:
	
	if URL == null or URL == "" or URL.length() < 8 : 
		printerr("ERROR NO URL - " , URL )
		return
	if callback == null: 
		printerr("ERROR NO CALLBACK")
		return
	var http_request : HTTPRequest = HTTPRequest.new()
	add_child(http_request)
	http_request.max_redirects = 8
	http_request.connect("request_completed", callback)
	print("fetching: ", URL)
	
	# SPECIFIC HEADERS
	var final_headers := PackedStringArray()
	final_headers.append_array(headers)
	final_headers.append("Accept: */*")
	
	var request : Error = http_request.request(URL,final_headers,method,body) 
	if request != OK: 
		printerr("ERROR FETCHING - " , request)
		http_request.queue_free()
		return
	await http_request.request_completed
	http_request.queue_free()
	return 


func _callback_response(result: int, response_code: int, headers:PackedStringArray, body:PackedByteArray)->void:
	var data_to_return : RESPONSE  = RESPONSE.new()
	data_to_return.connection = result
	data_to_return.status = response_code
	data_to_return.headers = headers
	
	if result != HTTPRequest.Result.RESULT_SUCCESS:
		data_to_return.response = "Error in HTTPRequest" + str(result)
		_data_recieved.emit(data_to_return)
		return 
	
	if response_code <200 or response_code >= 300:
		data_to_return.response = "Error in Server" + str(response_code)
		_data_recieved.emit(data_to_return)
		return 
	
	data_to_return.response = body.get_string_from_utf8()
	_data_recieved.emit(data_to_return)
	


func POST(URL:String, headers:PackedStringArray, body:String) -> RESPONSE:
	_do_fetch(URL,headers, _callback_response, HTTPClient.METHOD_POST, body)
	var data : RESPONSE = await self._data_recieved
	return data


func GET(URL:String, headers:PackedStringArray = []) -> RESPONSE:
	_do_fetch(URL,headers, _callback_response)
	var data : RESPONSE = await self._data_recieved
	return data


class RESPONSE: 
	var connection : int # 0 == "OK"
	var status : int
	var headers :  PackedStringArray
	var response :  String
