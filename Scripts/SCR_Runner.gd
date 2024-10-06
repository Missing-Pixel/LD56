extends Node2D

var getPlayerPosition: Vector2
@export var runningSpeed: float = 50
@export var runStartDistance: float = 100
@export var scoreGain: int = 50
var isRunning: bool = false
var runTimer: Timer
var saveDir: Vector2
@export var smokeParticle: PackedScene
var animator: AnimatedSprite2D
@onready var player: CharacterBody2D = $"../../Player"

func _ready() -> void:
	if player != null:
		player.connect("send_postion", _get_position)
	runTimer = $RunTimer
	animator = $AnimatedSprite2D

func _process(delta: float) -> void:
	# Get distance from player, than run away from them
	var distance: float
	distance = position.distance_to(getPlayerPosition)
	
	# Check if the player is already running, then start timer if not
	if isRunning == false:
		if distance <= runStartDistance:
			runTimer.stop()
			runTimer.start()
			isRunning = true
			
		else:
			animator.frame = 1
			animator.stop()
	
	# Runner will continue running in the same direction as when they last saw the player
	elif isRunning == true:
		if distance <= runStartDistance:
			var moveDir = position.direction_to(getPlayerPosition) * -1
			saveDir = moveDir
			position += moveDir * runningSpeed * delta
			
			#Animations
			if moveDir.x > 0.5:
				animator.play("Right")
			elif moveDir.x < -0.5:
				animator.play("Left")
			if moveDir.y > 0.5:
				animator.play("Down")
			elif moveDir.y < -0.5:
				animator.play("Up")
			
		else:
			position += saveDir * runningSpeed * delta 

func _get_position(playerPosition):
	getPlayerPosition = playerPosition

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == ("Player"):
		ScrDatamanager.sendScore.emit(scoreGain)
		var instanceParticle: CPUParticles2D = smokeParticle.instantiate()
		instanceParticle.position.x = position.x
		instanceParticle.position.y = position.y+10
		get_parent().add_child(instanceParticle)
		$"../../RunnerAudio".play()
		queue_free()

func _on_run_timer_timeout() -> void:
	isRunning = false
