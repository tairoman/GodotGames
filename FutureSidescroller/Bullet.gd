extends Area2D

var speed = 400
var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.animation = "default"
    $AnimatedSprite.flip_h = direction < 0
    $AnimatedSprite.play()

func _physics_process(delta):
    position.x += direction * delta * speed
