extends Sprite2D

var bNotice = false	# 是否看见玩家

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not bNotice:
		return
	
	var player = get_tree().get_first_node_in_group("player")

	look_at(player.global_position)
