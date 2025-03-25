extends Button

@export var scene_name: String = "Level1"


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_play_again_button_pressed() -> void:
	print("ke " + scene_name)
	get_tree().change_scene_to_file(str("res://scenes/" + scene_name + ".tscn"))
