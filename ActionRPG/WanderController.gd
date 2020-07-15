extends Node2D

export(float) var idle_state_chance = 0.5

onready var start_position = global_position
onready var target_position = start_position

onready var timer = $Timer

signal goto_idle()
signal goto_wander()

func _ready():
    randomize()

func update_target_position():
    var step = Vector2(rand_range(-32, 32), rand_range(-32, 32))
    target_position = start_position + step

func time_left():
    return timer.time_left

func start_timer():
    timer.start(3)

func _on_Timer_timeout():
    if randf() < idle_state_chance:
        emit_signal("goto_idle")
    else:
        update_target_position()
        emit_signal("goto_wander")
        start_timer()
