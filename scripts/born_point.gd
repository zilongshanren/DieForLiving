extends Sprite2D

var game_manager;

func _ready() -> void:
	game_manager = get_node("/root/Game/GameManager")

func on_player_dead(player, _original_pos):
	if (game_manager.limitless_dead):
		player.position = self.global_position
	else:
		player.die()
