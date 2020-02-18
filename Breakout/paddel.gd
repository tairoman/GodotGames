extends KinematicBody2D

var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
func start(pos):
    position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var move = 0
    
    if Input.is_action_pressed("ui_right"):
        move += 1
    if Input.is_action_pressed("ui_left"):
        move -= 1
        
    move_and_collide(Vector2(move * speed * delta, 0))
