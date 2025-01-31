extends Node

@export var total_time := 20.0
@export var limitless_dead = true
@export var all_levels:Array[PackedScene]


var max_level_num = 20
var score = 0
var current_level = -1
var current_level_node;
var current_level_time := 0

@onready var score_label = $ScoreLabel
@onready var game_timer  = get_node("/root/Game/Player/timer")
@onready var player = get_node("/root/Game/Player")
@onready var game_end_panel = $AllBlackHUD

func time_up():
	total_time = 0
	limitless_dead = false
	player.will_die_after_dead()

func _ready() -> void:
	for i in max_level_num:
		var level1 = get_node("/root/Level"+str(i));
		if (level1):
			total_time = level1.total_time
	
	$AllBlackHUD.visible = false

	if (!game_timer):
		get_node("/root/Game/Player/timer")
	game_timer.update_ui()
	# go_to_next_level(false)

func game_end():
	score_label.text = "Game End!"
	limitless_dead = false

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."


func get_level(index: int):
	if (index <= 0):
		index = 0
	if (index >= all_levels.size() - 1):
		index = all_levels.size() - 1
	return all_levels[index]

func free_previous_levels():
	var last_level = get_node("/root/Level")
	if (last_level):
		last_level.free()

	for i in max_level_num:
		last_level = get_node("/root/Level" + str(i))
		if (last_level):
			last_level.free()

func go_to_prev_level(is_new_game):
	game_timer.stop_timer()
	current_level -=1
	if (current_level <= 0):
		current_level = 0

	free_previous_levels()

	var level = get_level(current_level)
	load_level(level, is_new_game)

func go_to_next_level(is_new_game):
	game_timer.stop_timer()
	current_level +=1
	if (current_level >= all_levels.size()):
		current_level = all_levels.size() - 1
		print("congratulations! All level clears!")
		game_end_panel.visible = true
		player.queue_free()
		return

	free_previous_levels()
	await get_tree().create_timer(0.3).timeout
	$AllBlackHUD.visible = false

	var level = get_level(current_level)
	load_level(level, is_new_game)

func new_game():
	limitless_dead = true
	total_time = current_level_time
	if ($score_label):
		$score_label.visible = false
	get_tree().call_group("bodies", "queue_free")
	game_timer.stop_timer()
	game_timer.update_ui()
	player.reset()
	var current_scene = get_tree().current_scene
	if (current_scene):
		var born_point = current_scene.get_node("BornPoint")
		if (born_point):
			born_point.player_spawn(player)

func load_level(level, is_new_game):
	# Instance the new scene.
	var current_scene = level.instantiate()


	# var script = current_scene.get_script()
	total_time = current_scene.total_time;
	current_level_time = total_time

	print("time = " + str(current_level_time))

	if (is_new_game):
		new_game()

	var born_point = current_scene.get_node("BornPoint")
	born_point.player_spawn(player)

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene


func _exit_button_pressed():
	print("press exit button")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released(("retry")):
		print("Retry")
		new_game()
		# var start_hud  = get_node("/root/Game/GameManager/StartPage")
		# start_hud.visible = false
		var game_end_label = get_node("/root/Game/GameManager/ScoreLabel")
		game_end_label.visible = false
		get_tree().reload_current_scene()
			
	
	if Input.is_action_just_released(("next_level")):
		print("next level")
		go_to_next_level(true)

	if Input.is_action_just_pressed(("prev_level")):
		print("prev level")
		go_to_prev_level(true)
