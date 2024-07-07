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
	if (!game_manager):
		game_manager = get_node("/root/Game/GameManager")
	$Label.text = "%.1f" % game_manager.total_time + "s"


func _on_timer_timeout() -> void:
	game_manager.total_time -= 0.1
	update_ui()
	if (game_manager.total_time == 0):
		game_manager.limitless_dead = false
		$Timer.stop()

