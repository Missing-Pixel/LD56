extends CharacterBody2D

@export var speed: float = 300
signal send_postion
@onready var getAnimation: AnimatedSprite2D = $Sprite
@onready var audioTimer: Timer =$AudioStreamPlayer2D/Timer

func _physics_process(delta: float) -> void:
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Up"):
		if audioTimer.time_left <= 0:
			audioTimer.start()
		getAnimation.play("Up")
		
		if Input.is_action_pressed("Down"):
			velocity.y = 0
		elif Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
			velocity.y = -speed * 0.8
		else:
			velocity.y = -speed
		
	if Input.is_action_pressed("Down"):
		if audioTimer.time_left <= 0:
			audioTimer.start()
		getAnimation.play("Down")
		
		if Input.is_action_pressed("Up"):
			velocity.y = 0
		elif Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
			velocity.y = speed * 0.8
		else:
			velocity.y = speed
		
	if Input.is_action_pressed("Left"):
		if audioTimer.time_left <= 0:
			audioTimer.start()
		getAnimation.play("Left")
		
		if Input.is_action_pressed("Right"):
			velocity.x = 0
		elif Input.is_action_pressed("Up") or Input.is_action_pressed("Down"):
			velocity.x = -speed * 0.8
		else:
			velocity.x = -speed
		
	if Input.is_action_pressed("Right"):
		if audioTimer.time_left <= 0:
			audioTimer.start()
		getAnimation.play("Right")
		
		if Input.is_action_pressed("Left"):
			velocity.x = 0
		elif Input.is_action_pressed("Up") or Input.is_action_pressed("Down"):
			velocity.x = speed * 0.8
		else:
			velocity.x = speed
	
	if velocity.length() > 0:
		move_and_slide()
		send_postion.emit(position)
	else:
		audioTimer.stop()
		getAnimation.stop()

func _on_timer_timeout() -> void:
	$AudioStreamPlayer2D.play()
