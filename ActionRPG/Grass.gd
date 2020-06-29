extends Node2D

export var GrassEffect = preload("res://GrassEffect.tscn")

func _on_effect_finished() -> void:
    queue_free()

func _on_HurtBox_area_entered(_area : Area2D) -> void:
    var grassEffect = GrassEffect.instance()
    grassEffect.connect("finished", self, "_on_effect_finished")
    add_child(grassEffect)
    $GrassSprite.visible = false
