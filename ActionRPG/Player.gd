extends KinematicBody2D

export var MAX_SPEED : int = 100
export var ROLL_SPEED : int = MAX_SPEED * 1.4
export var ACCELERATION : int = 20
export var FRICTION : int = 15

enum {
    MOVE,
    ROLL,
    ATTACK    
}

var state = MOVE

var velocity := Vector2.ZERO
export var direction := Vector2.DOWN

onready var anim_state = $AnimationTree.get("parameters/playback")

func _ready():
    set_animation_tree_blend_position(direction)
    $AnimationTree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float) -> void:
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()
    
    match state:
        MOVE: move_state(delta)
        ATTACK: attack_state(delta)
        ROLL: roll_state(delta)
    
func attack_state(_delta : float) -> void:
    anim_state.travel("Attack")
    
func roll_state(_delta : float) -> void:
    anim_state.travel("Roll")
    var _ignore = move_and_slide(direction * ROLL_SPEED)
    
func move_state(_delta : float) -> void:
    var input_vec := Vector2.ZERO
    input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    
    var diff = FRICTION
    if input_vec != Vector2.ZERO:
        diff = ACCELERATION
        direction = input_vec.normalized()
        set_animation_tree_blend_position(input_vec)
        anim_state.travel("Run")
    else:
        anim_state.travel("Idle")
    velocity = velocity.move_toward(input_vec.normalized() * MAX_SPEED, diff)
        
    velocity = move_and_slide(velocity)
        
    if Input.is_action_just_pressed("ui_attack"):
        state = ATTACK
        
    if Input.is_action_just_pressed("ui_roll"):
        state = ROLL

func roll_animation_finished() -> void:
    state = MOVE
    velocity = Vector2.ZERO

func attack_animation_finished() -> void:
    state = MOVE

func set_animation_tree_blend_position(vec : Vector2) -> void:
    $AnimationTree.set("parameters/Idle/blend_position", vec)
    $AnimationTree.set("parameters/Run/blend_position", vec)
    $AnimationTree.set("parameters/Attack/blend_position", vec)
    $AnimationTree.set("parameters/Roll/blend_position", vec)
