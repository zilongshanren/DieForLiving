extends Node

@export var total_time := 20
@export var limitless_dead = true

const LEVELS = [
	"level_1",
	"level_2",
	"level_3",
	"level_4",
	"level_5",
	"level_6",
	"level_7",
	"level_8",
	"level_9",
	"level_10",
]
var score = 0
var current_level = 0
var current_level_node;


@onready var score_label = $ScoreLabel
@onready var game_timer  = $timer
@onready var player = get_node("/root/Game/Player")

func _ready() -> void:
	var level1 = get_node("/root/Level1");
	total_time = level1.total_time
	game_timer.update_ui()

func game_end():
	score_label.text = "Game End!"
	limitless_dead = false

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

func get_level_name(index):
	return str("res://levels/", LEVELS[index], ".tscn")

func get_level(index: int):
	return load(get_level_name(index))

func go_to_next_level():
	game_timer.stop_timer()
	current_level +=1

	var last_level = get_node("/root/Level")
	if (last_level):
		last_level.queue_free()

	last_level = get_node("/root/Level1")
	if (last_level):
		last_level.queue_free()

	var level = get_level(current_level)
	load_level(level)

func new_game():
	limitless_dead = true
	get_tree().call_group("bodies", "queue_free")

func load_level(level):

	# Instance the new scene.
	var current_scene = level.instantiate()

	# var script = current_scene.get_script()
	total_time = current_scene.total_time;
	new_game()
	game_timer.start_timer(1)
	var born_point = current_scene.get_node("BornPoint")
	born_point.player_spawn(player)

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene


