extends KinematicBody2D

enum State {
    IDLE,
    WANDER,
    CHASE
}

export(PackedScene) var DeathEffect = preload("res://BatDeathEffect.tscn")

export(int) var FRICTION = 10
export(int) var ACCELERATION = 5
export(int) var MAX_SPEED = 40

var velocity := Vector2.ZERO

var knockback_velocity := Vector2.ZERO
var knockback_power := 80

onready var stats = $Stats
onready var soft_collision_area = $SoftCollisionArea
onready var hitbox = $HitBox
onready var hurtbox = $HurtBox
onready var collision_shape = $HurtBox/CollisionShape2D #TODO: Replace with prop in HurtBox
onready var sprite = $AnimatedSprite
onready var shadow_sprite = $ShadowSprite
onready var wander_controller = $WanderController

var state = State.IDLE

var player = null

func _physics_process(_delta : float) -> void:
    knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 1)
    knockback_velocity = move_and_slide(knockback_velocity)
    
    match state:
        State.IDLE:
            velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
            if wander_controller.time_left() == 0:
                wander_controller.start_timer()
        State.WANDER:
            var target_vec = global_position.direction_to(wander_controller.target_position)
            velocity = velocity.move_toward(MAX_SPEED * target_vec, ACCELERATION)
            
            if global_position.distance_to(wander_controller.target_position) < 4:
                state = State.IDLE
            
        State.CHASE:
            var target_vec = global_position.direction_to(player.global_position)
            velocity = velocity.move_toward(MAX_SPEED * target_vec, ACCELERATION)
            
    sprite.flip_h = velocity.x < 0
    
    velocity += soft_collision_area.push_vec * 4
    velocity = move_and_slide(velocity)
    
func _on_HurtBox_area_entered(area : HitBox) -> void:
    # Health needs to be set first so that KNOCKBACK_POWER = 0 if health becomes zero
    stats.health -= area.damage()
    knockback_velocity = knockback_power * area.global_position.direction_to(hurtbox.global_position)


func _on_Stats_health_reached_zero():
    knockback_power = 0
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


func _on_PlayerDetectionZone_player_entered_zone(player_node):
    player = player_node
    state = State.CHASE


func _on_PlayerDetectionZone_player_exited_zone():
    state = State.IDLE
    player = null


func _on_HitBox_area_entered(area : HurtBox):
    knockback_velocity = knockback_power * area.global_position.direction_to(hitbox.global_position)


func _on_WanderController_goto_idle():
    state = State.IDLE


func _on_WanderController_goto_wander():
    state = State.WANDER
