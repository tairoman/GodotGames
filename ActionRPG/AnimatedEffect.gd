extends AnimatedSprite

class_name Effect

signal finished()

export(NodePath) var effect_sprite_path = "." # self by default

onready var effect_sprite = get_node(effect_sprite_path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var _connResult = connect("animation_finished", self, "_on_animation_finished")
    assert(_connResult == OK)
    effect_sprite.play(effect_sprite.animation)


func _on_animation_finished() -> void:
    emit_signal("finished")
