extends CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
    var screen_rect = get_viewport_rect().size
    
    position.x = -100
    position.y = screen_rect.y / 2
    
    shape.set_extents(Vector2(100, screen_rect.y / 2))
