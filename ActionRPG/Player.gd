extends KinematicBody2D

export var MAX_SPEED : int = 100
export var ACCELERATION : int = 20
export var FRICTION : int = 15

enum {
    MOVE,
    ROLL,
    ATTACK    
}

var state = MOVE

var velocity : Vector2 = Vector2.ZERO

onready var anim_state = $AnimationTree.get("parameters/playback")

func _ready():
    $AnimationTree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()
    
    match state:
        MOVE: move_state(delta)
        ATTACK: attack_state(delta)
        ROLL: roll_state(delta)
    
func attack_state(delta):
    anim_state.travel("Attack")
    
func roll_state(delta):
    pass
    
func move_state(delta):
    var input_vec : Vector2 = Vector2.ZERO
    input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    
    var diff = FRICTION
    if input_vec != Vector2.ZERO:
        diff = ACCELERATION
        $AnimationTree.set("parameters/Idle/blend_position", input_vec)
        $AnimationTree.set("parameters/Run/blend_position", input_vec)
        $AnimationTree.set("parameters/Attack/blend_position", input_vec)
        anim_state.travel("Run")
    else:
        anim_state.travel("Idle")
    velocity = velocity.move_toward(input_vec.normalized() * MAX_SPEED, diff)
        
    velocity = move_and_slide(velocity)
        
    if Input.is_action_just_pressed("ui_attack"):
        state = ATTACK

func attack_animation_finished():
    velocity = Vector2.ZERO
    state = MOVE
