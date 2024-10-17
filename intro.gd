extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(4).timeout
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file('res://Scenes/main_menu.tscn')
