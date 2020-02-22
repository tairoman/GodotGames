extends Node

var static_rectangle = preload("res://StaticRectangle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    $StartPosition.position.x = get_viewport().get_visible_rect().size.x * 0.5
    $StartPosition.position.y = get_viewport().get_visible_rect().size.y * 0.9
    $Paddel.start($StartPosition.position)
    $StartTimer.start()
    
    # Add left, top, and right screen border collision rectangles
    
    var screen_rect = get_viewport().get_visible_rect().size
    
    var left = static_rectangle.instance()
    add_child(left)
    left.create_rect(Rect2(Vector2(-100, 0), Vector2(100, screen_rect.y)))

    var top = static_rectangle.instance()
    add_child(top)
    top.create_rect(Rect2(Vector2(0, -100), Vector2(screen_rect.x, 100)))
    
    var right = static_rectangle.instance()
    add_child(right)
    right.create_rect(Rect2(Vector2(screen_rect.x, 0), Vector2(screen_rect.x + 100, screen_rect.y)))
    
    # Set up rect area
    $RectArea.rect_area = Rect2(Vector2(50, 50), Vector2(screen_rect.x - 100, 200))
    $RectArea.build()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_StartTimer_timeout():
    $Ball.start()

func _on_Ball_collided(obj):
    $Bounce1.play()
    if (obj.is_in_group("rect_area")):
        obj.queue_free()
