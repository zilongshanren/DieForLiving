extends Node2D

@onready var game_manager := %GameManager
@onready var player := get_node("/root/Game/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ui()
	# $Timer.start()
	player.connect("player_start_playing", _begin_timer)

func stop_timer():
	$Timer.stop()

func _begin_timer():
	$Timer.start()

func start_timer(time):
	update_ui()
	$Timer.start(time)

func update_ui():
	$Label.text = str(game_manager.total_time)


func _on_timer_timeout() -> void:
	game_manager.total_time -= 1
	update_ui()
	if (game_manager.total_time == 0):
		game_manager.limitless_dead = false
		$Timer.stop()

