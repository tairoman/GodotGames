extends Node

export var max_health := 1
onready var health := max_health setget set_health, get_health;

signal health_changed()
signal health_reached_zero()
signal health_reached_max()

func _ready() -> void:
    assert(max_health > 0)
    emit_signal("health_reached_max")

func get_health() -> int:
    return health

func set_health(value : int) -> void:
    if value <= 0:
        emit_signal("health_reached_zero")
    elif value >= max_health:
        emit_signal("health_reached_max")
    health = value
# warning-ignore:narrowing_conversion
    health = clamp(health, 0, max_health)
    assert(health <= max_health)
    emit_signal("health_changed")
