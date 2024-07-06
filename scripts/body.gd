extends RigidBody2D

@export var is_freezed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_freezed:
		set_freeze_enabled(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create():
	pass
