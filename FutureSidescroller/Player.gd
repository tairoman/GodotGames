extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var move_vec = Vector2()
    
    if Input.is_action_pressed("ui_right"):
        move_vec.x += 1
    if Input.is_action_pressed("ui_left"):
        move_vec.x -= 1
    
    move_vec = move_vec.normalized() * speed
    
    if move_vec.x != 0:
        $AnimatedSprite.animation = "run"
        $AnimatedSprite.flip_h = move_vec.x < 0
    else:
        $AnimatedSprite.animation = "idle"
        
    position += move_vec * delta
