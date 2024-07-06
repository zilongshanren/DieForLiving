extends Area2D



func _on_body_entered(_body:Node2D) -> void:
	var game_manager = get_node("/root/Game/GameManager")
	game_manager.go_to_next_level()
