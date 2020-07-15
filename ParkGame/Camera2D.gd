extends Camera2D

export(int) var speed_multiplier = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position.x += speed_multiplier * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
    position.y += speed_multiplier * (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
