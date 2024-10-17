extends CharacterBody2D

var player

func _ready() -> void:
	player = get_node("/root/Game/player")
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	motion_mode
