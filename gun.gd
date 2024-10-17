extends Area2D


func _physics_process(delta: float) -> void:
	var player_in_range = get_overlapping_bodies()
	if player_in_range.size() > 0:
		var target_player = player_in_range.front()
		look_at(target_player.global_position)
		
func shoot():
		const BULLET = preload("res://bullet.gd")
		var new_bullet = BULLET.NOTIFICATION_SCENE_INSTANTIATED
		new_bullet.global_position = %"shooting point".global_position	
		new_bullet.global_rotation = %"shooting point".global_rotation
		%"shooting point".add_child(new_bullet)


func _on_timer_timeout() -> void:
	shoot()
