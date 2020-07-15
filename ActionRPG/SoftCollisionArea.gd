extends Area2D

var push_vec := Vector2.ZERO

func _on_SoftCollisionArea_area_entered(area):
    var direction = area.global_position.direction_to(global_position)
    push_vec = (push_vec + direction).normalized()

func _on_SoftCollisionArea_area_exited(_area):
    if get_overlapping_areas().size() == 1:
        push_vec = Vector2.ZERO
