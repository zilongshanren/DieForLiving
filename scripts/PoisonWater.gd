extends Area2D

var can_die = true
var uppixel = 8.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("player_character") and can_die:
		get_tree().call_group("playerDeathCaring", "on_player_dead", body, body.global_position)
		#$CollisionShape2D.scale.y += uppixel / (16 * scale.y)
		#$CollisionShape2D.position.y -= uppixel / (2 * scale.y)
		scale.y += uppixel / 16
		position.y -= uppixel / 2
		$Timer.start()
		can_die = false

func _on_DeathCooldownTimer_timeout():
	can_die = true
