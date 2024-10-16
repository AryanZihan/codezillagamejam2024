extends Area2D
@onready var endscreener: Timer = $endscreener


func _on_body_entered(body: Node2D) -> void:
	endscreener.start()


func _on_endscreener_timeout() -> void:
	get_tree().change_scene_to_file('res://Scenes/endscreen.tscn')
