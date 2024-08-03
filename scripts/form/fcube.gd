class_name FCube
extends Node3D


var _mesh: MeshInstance3D


func _init():
	self._mesh = MeshInstance3D.new()
	self._mesh.mesh = BoxMesh.new()

func _ready():
	pass


func _process(delta):
	pass
