extends CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
    var screen_rect = get_viewport_rect().size
    
    position.x = screen_rect.x / 2
    position.y = -100
    
    shape.set_extents(Vector2(screen_rect.x / 2, 100))
