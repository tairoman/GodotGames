extends KinematicBody2D

var knockback_velocity := Vector2.ZERO
const KNOCKBACK_POWER := 50


func _physics_process(_delta : float) -> void:
    knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 1)
    knockback_velocity = move_and_slide(knockback_velocity)
    
    
func _on_HurtBox_area_entered(hitbox : HitBox) -> void:
    $Stats.health -= hitbox.damage
    knockback_velocity = KNOCKBACK_POWER * ($HurtBox.global_position - hitbox.global_position).normalized()


func _on_Stats_health_reached_zero():
    queue_free()
