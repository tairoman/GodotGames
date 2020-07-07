extends Node2D

export(PackedScene) var GrassEffect = preload("res://GrassEffect.tscn")

onready var grass_sprite = $GrassSprite

func _on_effect_finished() -> void:
    queue_free()

func _on_HurtBox_area_entered(_area : Area2D) -> void:
    var grass_effect = GrassEffect.instance()
    grass_effect.connect("finished", self, "_on_effect_finished")
    add_child(grass_effect)
    grass_sprite.visible = false
