extends Area2D


# Called when the node enters the scene tree for the first time.


func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file('res://Scenes/outro.tscn')
