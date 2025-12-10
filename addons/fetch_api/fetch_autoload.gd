@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	add_autoload_singleton("FETCH","res://addons/fetch_api/fetch_api.gd" )
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	remove_autoload_singleton("FETCH")
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
