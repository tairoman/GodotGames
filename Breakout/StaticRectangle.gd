extends StaticBody2D

export var rect : Rect2
export var color : Color

# Called when the node enters the scene tree for the first time.
func _ready():
    update_collision_rect()
    
func create_rect(rect : Rect2):
    self.rect = rect
    update_collision_rect()
    
func set_color(color : Color):
    self.color = color

func update_collision_rect():
    # Set up collision shape
    $CollisionShape2D.position.x = rect.position.x + rect.size.x / 2
    $CollisionShape2D.position.y = rect.position.y + rect.size.y / 2
    
    $CollisionShape2D.shape.set_extents(Vector2(rect.size.x / 2, rect.size.y / 2))

func _draw():
    draw_rect(self.rect, self.color)
