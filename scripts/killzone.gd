extends Area2D

@onready var timer = $Timer
var last_body_create_timestamp = 0

func _on_body_entered(body):
	# 0.5s内只死亡一次
	var cur_timestamp = Time.get_ticks_msec()
	if cur_timestamp - last_body_create_timestamp < 500:
		return
	last_body_create_timestamp = cur_timestamp
		
	print("You died!")
	#var group_mem = get_tree().get_nodes_in_group("bodyCaring")
	get_tree().call_group("bodyCaring", "on_player_dead", body)
	#var group_node = get_tree().get_nodes_in_group("bodyCaring")
	#body.visible = false
	#Engine.time_scale = 0.5
	#body.get_node("CollisionShape2D").queue_free()
	#timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
