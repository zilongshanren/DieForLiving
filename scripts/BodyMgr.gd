extends Node2D

@export var body_scene:PackedScene
var last_body_create_timestamp = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#add_to_group("bodyCaring")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_player_dead(player, pos):

	var body = body_scene.instantiate()

	# Choose a random location on Path2D.
	body.position = pos

	# Spawn the mob by adding it to the Main scene.
	add_child(body)
