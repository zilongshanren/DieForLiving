extends Node2D

@export var body_scene:PackedScene
@export var body_static_scene:PackedScene
var last_body_create_timestamp = 0

var game_manager;

func _ready() -> void:
	game_manager = get_node("/root/Game/GameManager")

func on_player_dead(_player, pos, is_freezed):
	# 0.5s内只死亡一次
	var cur_timestamp = Time.get_ticks_msec()
	if cur_timestamp - last_body_create_timestamp < 500:
		return
	last_body_create_timestamp = cur_timestamp
	
	if is_freezed:
		var body = body_static_scene.instantiate()
		# Choose a random location on Path2D.
		body.position = pos
		# Spawn the mob by adding it to the Main scene.
		add_child(body)
	else:
		var body = body_scene.instantiate()
		# Choose a random location on Path2D.
		body.position = pos
		# Spawn the mob by adding it to the Main scene.
		add_child(body)


	if (!game_manager.limitless_dead):
		print("game end!")
		game_manager.game_end()
		return
