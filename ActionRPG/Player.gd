extends KinematicBody2D

export var MAX_SPEED : int = 100
export var ROLL_SPEED : int = MAX_SPEED * 1.4
export var ACCELERATION : int = 20
export var FRICTION : int = 15

export var sword_damage := 1

enum {
    MOVE,
    ROLL,
    ATTACK
}

var state = MOVE

var velocity := Vector2.ZERO
export var direction := Vector2.DOWN

onready var hitbox = $HitboxPivot/SwordHitBox
onready var animation_tree = $AnimationTree
onready var anim_state = animation_tree.get("parameters/playback")

func _ready():
    hitbox.damage_getter = funcref(self, "_sword_damage_getter")
    set_animation_tree_blend_position(direction)
    animation_tree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float) -> void:
    if Input.is_action_pressed("ui_cancel"):
        get_tree().quit()
    
    match state:
        MOVE: _move_state(delta)
        ATTACK: _attack_state(delta)
        ROLL: _roll_state(delta)
    
func _attack_state(_delta : float) -> void:
    anim_state.travel("Attack")
    
func _roll_state(_delta : float) -> void:
    anim_state.travel("Roll")
    var _ignore = move_and_slide(direction * ROLL_SPEED)
    
func _move_state(_delta : float) -> void:
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
    animation_tree.set("parameters/Idle/blend_position", vec)
    animation_tree.set("parameters/Run/blend_position", vec)
    animation_tree.set("parameters/Attack/blend_position", vec)
    animation_tree.set("parameters/Roll/blend_position", vec)

func _sword_damage_getter():
    return sword_damage
