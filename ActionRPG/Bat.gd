extends KinematicBody2D

var knockback_velocity := Vector2.ZERO
const KNOCKBACK_POWER := 50

func _physics_process(_delta : float) -> void:
    knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 1)
    knockback_velocity = move_and_slide(knockback_velocity)
    
func _on_HurtBox_area_entered(area : Area2D) -> void:
    print_debug(area.name)
    print_debug($HurtBox.global_position.direction_to(area.global_position))
    knockback_velocity = KNOCKBACK_POWER * ($HurtBox.global_position - area.global_position).normalized()
