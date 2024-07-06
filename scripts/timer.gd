extends Node2D

@onready var game_manager := %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ui()
	$Timer.start()


func update_ui():
	$Label.text = str(game_manager.total_time)


func _on_timer_timeout() -> void:
	game_manager.total_time -= 1
	update_ui()
	if (game_manager.total_time == 0):
		game_manager.limitless_dead = false
		$Timer.stop()

