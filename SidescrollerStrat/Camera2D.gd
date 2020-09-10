extends Camera2D

export(int) var speed_multiplier = 500

func _process(delta):
    position.x += speed_multiplier * delta * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
    position.y += speed_multiplier * delta * (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
