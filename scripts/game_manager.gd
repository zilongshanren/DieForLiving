extends Node

const LEVELS = [
	"level_1",
	"level_2",
	"level_3",
	"level_4",
]
var score = 0


@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."

func get_level(index: int):
	return load(str("res://levels/", LEVELS[index], ".tscn"))

func _enter_tree() -> void:
	var level = get_level(0)

	# Instance the new scene.
	# var current_scene = level.instantiate()

	# Add it to the active scene, as child of root.
	# get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	# get_tree().current_scene = current_scene

