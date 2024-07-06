extends Sprite2D
@export var Bullet:PackedScene

var bNotice = false	# 是否看见玩家
var bullet_velocity = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not bNotice:
		if !$ShootingTimer.is_stopped():
			$ShootingTimer.stop()
		return
	
	if $ShootingTimer.is_stopped():
		$ShootingTimer.start()
	
	var player = get_tree().get_first_node_in_group("player")

	look_at(player.global_position)
	
func set_shooting_interval(interval):
	$ShootingTimer.set_wait_time(interval)
	
func set_bullet_velocity(velocity):
	bullet_velocity = velocity
	
func shoot():
	var bullet = Bullet.instantiate()

	bullet.position = global_position

	var player = get_tree().get_first_node_in_group("player")
	var direction = player.global_position - global_position

	bullet.linear_velocity = direction * bullet_velocity

	# Spawn the mob by adding it to the Main scene.
	get_node("/root/Game/").add_child(bullet)


func _on_shooting_timer_timeout():
	shoot()
