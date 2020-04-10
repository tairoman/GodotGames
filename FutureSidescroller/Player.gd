extends KinematicBody2D

enum PlayerState {
    idle,
    shooting,
    jumping,
    running_right,
    running_left
}

signal spawn_bullet(pos, direction)

var speed = 200
var current_state = PlayerState.idle
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
    set_animation()
    $AnimatedSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var move_vec = Vector2()
    move_vec.y = 1
    
    var changed_state : bool = false
    var key_pressed : bool = false
    
    if Input.is_action_pressed("ui_right"):
        key_pressed = true
        changed_state = set_state(PlayerState.running_right)
    if Input.is_action_pressed("ui_left"):
        key_pressed = true
        changed_state = set_state(PlayerState.running_left)
    if Input.is_action_pressed("ui_jump"):
        key_pressed = true
        changed_state = set_state(PlayerState.jumping)
        move_vec.y = -1
    if Input.is_action_pressed("ui_shoot"):
        key_pressed = true
        changed_state = set_state(PlayerState.shooting)
    
    if not key_pressed:
        changed_state = set_state(PlayerState.idle)
    
    if current_state == PlayerState.running_right:
        move_vec.x = 1
    elif current_state == PlayerState.running_left:
        move_vec.x = -1
        
       
    if changed_state: 
        set_animation()

    if (move_vec.x != 0):
        direction = sign(move_vec.x)
    
    move_vec = move_vec.normalized() * speed
    move_and_slide(move_vec,Vector2(0,-1))


func set_state(to):
    if current_state != PlayerState.jumping:
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
        pass
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