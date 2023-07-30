extends Node

@export var mob_scene: PackedScene
var score: int



func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BackgroundMusic.stop()
	$GameOverSound.play()
	

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$BackgroundMusic.play()


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate() # new instance of Mob scene
	
	# random location on Path2D (MobPath)
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2 # mob's direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	mob.position = mob_spawn_location.position # mob's position (random)

	# mob's velocity
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob) # and finally spawning the mob
