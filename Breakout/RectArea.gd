extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var static_rectangle = preload("res://StaticRectangle.tscn")

export var rect_area : Rect2

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()

func build():
    var curr_x = rect_area.position.x
    var max_x = rect_area.position.x + rect_area.size.x
    var curr_y = rect_area.position.y
    var max_y = rect_area.position.y + rect_area.size.y
    var min_size_x = 50
    var max_size_x = 100
    var y_step_size = floor(rect_area.size.y / 5)
    
    while (curr_y < max_y):
    
        while (curr_x < max_x - max_size_x):
            var rect_size_x = rand_range(min_size_x, max_size_x)
            create_rect(Rect2(curr_x, curr_y, rect_size_x, y_step_size))
            curr_x += rect_size_x
        
        # Add last in row
        create_rect(Rect2(curr_x, curr_y, max_x - curr_x, y_step_size))
            
        curr_y += y_step_size
        curr_x = rect_area.position.x

func create_rect(rect : Rect2):
    var instance = static_rectangle.instance()
    add_child(instance)
    instance.add_to_group("rect_area")
    instance.create_rect(rect)
    instance.set_color(Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass