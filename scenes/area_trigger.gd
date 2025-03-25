extends Area3D

@export var scene_name := "Level1"


func _on_body_entered(body: Node3D) -> void:
	if body.get_name() == "Player":
		call_deferred("change_scene")


func change_scene() -> void:
	get_tree().change_scene_to_file(str("res://scenes/" + scene_name + ".tscn"))
