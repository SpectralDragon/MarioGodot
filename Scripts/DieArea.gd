extends Node2D

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "player":
		var player = body as Player
		player.die()
