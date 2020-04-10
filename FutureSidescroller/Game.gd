extends Node

var Bullet = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()


func _on_Player_spawn_bullet(pos, direction):
    var bullet = Bullet.instance()
    bullet.position = pos
    bullet.direction = direction
    add_child(bullet)
