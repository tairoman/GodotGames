extends Area2D

class_name HitBox

# Callback for getting the damage for this hitbox
var damage_getter : FuncRef = funcref(self, "_default_getter")

# Fallback if damage_getter is not set
export var damage_fallback := 1

func _default_getter():
    return damage_fallback

func damage():
    return damage_getter.call_func()
