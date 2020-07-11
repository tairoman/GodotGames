extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()
