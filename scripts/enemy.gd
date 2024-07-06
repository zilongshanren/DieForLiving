extends RigidBody2D
@export var shooting_interval:float
@export var bullet_velocity:float

# Called when the node enters the scene tree for the first time.
func _ready():
	$Gun.set_shooting_interval(shooting_interval)
	$Gun.set_bullet_velocity(bullet_velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.a
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
