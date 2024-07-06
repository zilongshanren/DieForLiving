extends Node2D

@export var body_scene:PackedScene
var last_body_create_timestamp = 0

var game_manager;

func _ready() -> void:
	game_manager = get_node("/root/Game/GameManager")

func on_player_dead(_player, pos):
	var body = body_scene.instantiate()

	# Choose a random location on Path2D.
	body.position = pos

	# Spawn the mob by adding it to the Main scene.
	add_child(body)

	if (!game_manager.limitless_dead):
		print("game end!")
		game_manager.game_end()
		return
