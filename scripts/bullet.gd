extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("playerDeathCaring", "on_player_dead", body, body.global_position, false)
		queue_free()
	else:
		print("bullet hit:" + body.to_string())


#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#if body.is_in_group("player"):
		#get_tree().call_group("playerDeathCaring", "on_player_dead", body, body.global_position)
		#queue_free()
