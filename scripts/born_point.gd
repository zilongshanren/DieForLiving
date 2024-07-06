extends Sprite2D

var game_manager;

func _ready() -> void:
	game_manager = get_node("/root/Game/GameManager")

func on_player_dead(player, _original_pos, is_freezed):
	if (game_manager.limitless_dead):
		player_spawn(player)
	else:
		player.die()

func player_spawn(player):
	player.position = self.global_position
