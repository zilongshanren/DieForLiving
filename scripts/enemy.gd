extends RigidBody2D
#@export shoot_interval = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_notice_area_body_entered(body):
	if body.is_in_group("player"):
		$Gun.bNotice = true
	else:
		print("enter:" + body.to_string())


func _on_notice_area_body_exited(body):
	if body.is_in_group("player"):
		$Gun.bNotice = false
	else:
		print("exit:" + body.to_string())
