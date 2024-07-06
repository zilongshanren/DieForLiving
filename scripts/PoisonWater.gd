extends Area2D

var can_die = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = $Timer
	timer.timeout.connect(_on_DeathCooldownTimer_timeout)
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if can_die:
		get_tree().call_group("playerDeathCaring", "on_player_dead", body, body.global_position)
		position.y -= 10
		$Timer.start()
		can_die = false

func _on_DeathCooldownTimer_timeout():
	can_die = true
