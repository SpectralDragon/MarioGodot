class_name Block
extends Node2D

export var is_destroyable = true
export(PackedScene) var particles

func _on_DestoryArea_body_entered(body: Node) -> void:
	var player = (body as Player)
	if not player:
		return
		
	if player.is_player_big() and is_destroyable:
		self.destory_block()
	
func destory_block():
	var node = particles.instance() as Node2D
	var particles_node = node.get_children()[0] as Particles2D
	particles_node.global_position = $Sprite.global_position
	#particles_node.texture = $Sprite.texture
	particles_node.set_one_shot(true)
	get_tree().root.add_child(node)
	queue_free()
