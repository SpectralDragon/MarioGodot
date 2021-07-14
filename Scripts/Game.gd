extends Node2D

var points := 0.0

func add_point(point: float):
	self.points += point

func restart():
	self.points = 0.0
	get_tree().reload_current_scene()

