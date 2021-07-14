extends Block

enum Item {
	MUSHROOM,
	STAR,
	COIN,
	NONE
}

export(Item) var item = Item.MUSHROOM
var item_prefab: PackedScene

func _on_DestoryArea_body_entered(body: Node) -> void:
	var player = body as Player
	
	if not player:
		return
		
	block_active()

func _ready() -> void:
	
	$AnimationPlayer.play("Idle")
	
	if item == Item.MUSHROOM:
		item_prefab = load("res://Scenes/Items/Mushroom.tscn")
	elif item == Item.COIN:
		item_prefab = load("res://Scenes/Items/Coin.tscn")

func block_active():
	if item == Item.NONE:
		return
	
	var node = item_prefab.instance()
	node.global_position = self.global_position
	get_tree().root.add_child(node)
