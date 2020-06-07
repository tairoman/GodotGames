extends KinematicBody2D

export var MAX_SPEED : int = 100
export var ACCELERATION : int = 20
export var FRICTION : int = 15

var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()
    
    var input_vec : Vector2 = Vector2.ZERO
    input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    
    var diff = FRICTION
    if input_vec != Vector2.ZERO:
        diff = ACCELERATION
    velocity = velocity.move_toward(input_vec.normalized() * MAX_SPEED, diff)
        
    move_and_collide(velocity * delta)
        
