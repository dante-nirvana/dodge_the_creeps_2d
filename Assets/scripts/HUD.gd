extends CanvasLayer

signal start_game # it'll sign to Main that the button has been pressed


# Well... as the name says...
func show_message(text) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


# The same here
func show_game_over() -> void:
	show_message("Game Over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


# yep... exactly
func update_score(score) -> void:
	$ScoreLabel.text = str(score)



func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
