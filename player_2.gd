extends CharacterBody2D
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false

const SPEED = 250.0
const JUMP_VELOCITY = -550.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack = $attack
@onready var jump = $Jump

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if health >= 0:
		player_alive = false
		$respawn.start()
	update_health()
	enemy_attack()
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		$deal_attack.start()
		attack.play()
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	if is_on_floor():
		if direction == 0:
			if attack_ip == false:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("punch")
		else:
			if attack_ip == false:
				animated_sprite_2d.play("run")
			else:
				animated_sprite_2d.play("punch")
	else:
		if attack_ip == false:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("punch")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file('res://Scenes/main_menu.tscn')


	move_and_slide()


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy") :
		enemy_inattack_range = true

func player():
	pass


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy") :
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true


func _on_respawn_timeout() -> void:
	get_tree().change_scene_to_file('res://Scenes/game.tscn')


func _on_deal_attack_timeout() -> void:
	Global.player_current_attack = false
	attack_ip = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	
func _on_regen_health_timeout() -> void:
	if health < 100:
		health = health +15
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
