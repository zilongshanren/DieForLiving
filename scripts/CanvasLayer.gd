extends CanvasLayer


func _process(_delta: float) -> void:
	if (Global.main_menu_display):
		visible = false

func _on_timer_timeout():
	$Sprite2D.rotation += 0.1


func _on_button_pressed():
	visible = false
	Global.main_menu_display = true
	queue_free()
