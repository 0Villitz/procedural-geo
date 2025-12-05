extends Node

func _unhandled_input(event):
	if event.is_action("ui_text_backspace"):
		get_tree().quit()
#func _input(inputevent):
#	if inputevent = "ui_cancel":
#		print("a")
