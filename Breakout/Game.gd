extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    $StartPosition.position.x = get_viewport().get_visible_rect().size.x * 0.5
    $StartPosition.position.y = get_viewport().get_visible_rect().size.y * 0.9
    $Paddel.start($StartPosition.position)
    $StartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_StartTimer_timeout():
    $Ball.start()
