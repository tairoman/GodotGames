extends KinematicBody2D

const DeathEffect = preload("res://BatDeathEffect.tscn")

var knockback_velocity := Vector2.ZERO
var KNOCKBACK_POWER := 50

onready var stats = $Stats
onready var hurtbox = $HurtBox
onready var collision_shape = $HurtBox/CollisionShape2D #TODO: Replace with prop in HurtBox
onready var sprite = $AnimatedSprite
onready var shadow_sprite = $ShadowSprite


func _physics_process(_delta : float) -> void:
    knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 1)
    knockback_velocity = move_and_slide(knockback_velocity)
    
    
func _on_HurtBox_area_entered(hitbox : HitBox) -> void:
    # Health needs to be set first so that KNOCKBACK_POWER = 0 if health becomes zero
    stats.health -= hitbox.damage()
    knockback_velocity = KNOCKBACK_POWER * (hurtbox.global_position - hitbox.global_position).normalized()


func _on_Stats_health_reached_zero():
    KNOCKBACK_POWER = 0
    collision_shape.set_deferred("disabled", true)
    hide_bat()
    var death_effect = DeathEffect.instance()
    death_effect.connect("finished", self, "_on_death_effect_finished")
    add_child(death_effect)


func _on_death_effect_finished():
    queue_free()


func hide_bat():
    sprite.visible = false
    shadow_sprite.visible = false
