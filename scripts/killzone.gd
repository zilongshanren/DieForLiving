extends Area2D

@onready var timer = $Timer
var last_body_create_timestamp = 0
@export var is_freezed = false

func _on_body_entered(body):
	if not body.is_in_group("player_character"):
		return
		
	# 0.5s内只死亡一次
	var cur_timestamp = Time.get_ticks_msec()
	if cur_timestamp - last_body_create_timestamp < 500:
		return
	last_body_create_timestamp = cur_timestamp
		
	print("You died!")
	#var group_mem = get_tree().get_nodes_in_group("bodyCaring")
	get_tree().call_group("playerDeathCaring", "on_player_dead", body, body.global_position, is_freezed)
	#var group_node = get_tree().get_nodes_in_group("bodyCaring")
	#body.visible = false
	#Engine.time_scale = 0.5
	#body.get_node("CollisionShape2D").queue_free()
	#timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
