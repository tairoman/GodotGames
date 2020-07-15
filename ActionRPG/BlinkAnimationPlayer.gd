extends AnimationPlayer

export(int) var blink_times = 2
export(NodePath) var blink_animation_player_path = "."

signal blinking_finished()

var blink_count = 0

onready var blink_animation_player = get_node(blink_animation_player_path)

# If not already blinking, start new blink
func ensure_blinking():
    if blink_animation_player.is_playing():
        return
    blink_count = 0
    blink_animation_player.play("Start")


func _on_blink_finished():
    if blink_count == blink_times:
        emit_signal("blinking_finished")
        blink_count = 0
        blink_animation_player.play("Stop")
        return
    
    blink_count += 1
        
