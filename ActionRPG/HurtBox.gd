extends Area2D

export(bool) var enable_effect = true
export(PackedScene) var Effect = preload("res://HitEffect.tscn")
export(NodePath) var effect_origin_node_path = "."
export(Vector2) var effect_offset = Vector2.ZERO

signal effect_started()
signal effect_finished()

onready var effect_origin_node = get_node(effect_origin_node_path)

func _on_HurtBox_area_entered(_area):
    if enable_effect:
        var effect : Effect = Effect.instance()
        var conn_result = effect.connect("finished", self, "_on_effect_finished", [effect])
        assert(conn_result == OK)
        add_child(effect)
        effect.global_position = effect_origin_node.global_position + effect_offset
        emit_signal("effect_started")

func _on_effect_finished(effect : Effect):
    emit_signal("effect_finished")
    effect.queue_free()
