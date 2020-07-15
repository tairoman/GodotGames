extends AudioStreamPlayer


func _on_PlayerHurtSound_finished():
    queue_free()
