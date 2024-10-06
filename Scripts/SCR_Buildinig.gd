extends Node2D

@export var scoreGain: int = 100
@export var buildingParticle: PackedScene
@export var smokeParticle: PackedScene

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Particles
		for i in 2:
			if i == 0:
				var instanceParticle: CPUParticles2D = buildingParticle.instantiate()
				instanceParticle.position.x = position.x
				instanceParticle.position.y = position.y+10
				get_parent().add_child(instanceParticle)
			else:
				var instanceParticle: CPUParticles2D = smokeParticle.instantiate()
				instanceParticle.position.x = position.x
				instanceParticle.position.y = position.y+10
				get_parent().add_child(instanceParticle)
		
		$"../../BuildingAudio".play()
		ScrDatamanager.sendScore.emit(scoreGain)
		queue_free()
