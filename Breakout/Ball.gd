extends KinematicBody2D

var velocity = Vector2()
var speed = 200

signal collided(obj)

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    
func start():
    velocity.y = 1 # Always down
    
    var angle_rad = rand_range(-PI / 4, PI / 4)
    
    velocity = velocity.rotated(angle_rad)
    velocity = velocity.normalized() * speed

func stop():
    velocity = Vector2()

func _draw():
    draw_circle(Vector2(0,0), 10, Color(0, 0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    var collision = move_and_collide(velocity * delta)
    if collision:
        emit_signal("collided", collision.collider)
        velocity = velocity.bounce(collision.normal)
