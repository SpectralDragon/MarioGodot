extends Block

export(PackedScene) var coin
export var coins_count := 4

func _ready() -> void:
	self.is_destroyable = false

func block_activate():
	if coins_count == 0:
		self.destory_block()
		
	coins_count -= 1
