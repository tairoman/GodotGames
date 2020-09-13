extends Node2D

class_name Wall

enum Direction { RIGHT = 1, LEFT = -1 }

export(Direction) var direction = Direction.RIGHT
# in chunks:
export (int) var units_back_width = 2
export (int) var units_front_width = 2

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    if (direction == Direction.LEFT):
        $FrontPosition.position = -$FrontPosition.position
        $BackPosition.position = -$BackPosition.position

func _front_unit_position() -> float:
    var pos_in_range = direction * rand_range(0, units_front_width * GlobalData.CHUNK_SIZE)
    return pos_in_range + $FrontPosition.position.x
        
    
func _back_unit_position():
    pass

func assign_unit_front(unit : Node2D):
    # TODO: Make unit move there instead of teleporting it
    unit.global_position.x = global_position.x + _front_unit_position()
