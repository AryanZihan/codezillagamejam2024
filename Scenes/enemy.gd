extends CharacterBody2D

const SPEED = 40
var player_chase = false
var player = null
var health = 500
var player_inattack_range = false

func _physics_process(delta: float) -> void:
	deal_with_damage()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if player_chase:
		position += (player.position - position)/SPEED
		$AnimatedSprite2D.play("attack")
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
func enemy():
	pass 


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_range = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_range = false
		
func deal_with_damage():
	if player_inattack_range and Global.player_current_attack:
		health = health - 5
		if health <= 0:
			self.queue_free()
