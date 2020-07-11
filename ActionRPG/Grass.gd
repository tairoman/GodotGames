extends Node2D

onready var grass_sprite = $GrassSprite


func _on_HurtBox_effect_finished():
    queue_free()


func _on_HurtBox_effect_started():
    grass_sprite.visible = false
