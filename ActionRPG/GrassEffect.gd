extends Node2D

signal finished()

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite.play("Animate")


func _on_AnimatedSprite_animation_finished():
    emit_signal("finished")
