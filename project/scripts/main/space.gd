extends Node3D


const form_scene: PackedScene = preload("res://scenes/form.tscn")


func _ready():
	randomize()
	self.spawn_form()


func _process(_delta):
	pass


func spawn_form():
	var form = form_scene.instantiate()
	form.position = Vector3(0, 0, 0)
	self.add_child(form)
