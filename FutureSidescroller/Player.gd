extends KinematicBody2D

enum PlayerState {
    idle,
    shooting,
    jumping,
    running_right,
    running_left
}

signal spawn_bullet(pos, direction)

var run_speed = 200
var fall_speed = 10
var jump_speed = 300
var current_state = PlayerState.idle
var direction = 1

var move_vec : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    set_animation()
    $AnimatedSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    move_vec.y += fall_speed
    
    var changed_state : bool = false
    var key_pressed : bool = false
    
    if Input.is_action_pressed("ui_shoot"):
        key_pressed = true
        changed_state = set_state(PlayerState.shooting)
        move_vec.x = 0
    elif Input.is_action_pressed("ui_right"):
        key_pressed = true
        changed_state = set_state(PlayerState.running_right)
        move_vec.x = run_speed
    elif Input.is_action_pressed("ui_left"):
        key_pressed = true
        changed_state = set_state(PlayerState.running_left)
        move_vec.x = -run_speed
    else:
        move_vec.x = 0
        if is_on_floor():
            changed_state = set_state(PlayerState.idle)
    
    if is_on_floor() && Input.is_action_pressed("ui_jump"):
        key_pressed = true
        changed_state = set_state(PlayerState.jumping)
        move_vec.y = -jump_speed
        
    set_animation()

    if (move_vec.x != 0):
        direction = sign(move_vec.x)
    
    move_and_slide(move_vec, Vector2(0,-1))

func set_state(to):
    if current_state != PlayerState.jumping:
        current_state = to
        return true
    elif current_state == PlayerState.jumping && is_on_floor():
        current_state = to
        return true
    return false
    
func set_animation():
    if current_state == PlayerState.idle:
        $AnimatedSprite.animation = "idle"
    elif current_state == PlayerState.running_right:
        $AnimatedSprite.animation = "run"
        $AnimatedSprite.flip_h = false
    elif current_state == PlayerState.running_left:
        $AnimatedSprite.animation = "run"
        $AnimatedSprite.flip_h = true
    elif current_state == PlayerState.jumping:
        $AnimatedSprite.animation = "jump"
        $AnimatedSprite.flip_h = move_vec.x < 0
    elif current_state == PlayerState.shooting:
        $AnimatedSprite.animation = "shoot"
    else:
        push_warning("Player state has no animation: %s" % current_state)

func _on_AnimatedSprite_frame_changed():
    if (current_state == PlayerState.shooting && $AnimatedSprite.frame == 0):
        spawn_bullet()
        
func spawn_bullet():
    var bulletPos = $BulletPosition.position
    if direction == -1:
        bulletPos.x *= -1
    emit_signal("spawn_bullet", position + bulletPos, direction)

func is_moving_state(state) -> bool:
    return state == PlayerState.running_right || state == PlayerState.running_left || state == PlayerState.jumping