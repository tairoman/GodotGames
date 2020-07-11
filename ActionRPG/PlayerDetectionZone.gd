extends Area2D

signal player_entered_zone(player)
signal player_exited_zone()


func _on_PlayerDetectionZone_body_entered(body : Player):
    emit_signal("player_entered_zone", body)


func _on_PlayerDetectionZone_body_exited(_body : Player):
    emit_signal("player_exited_zone")
