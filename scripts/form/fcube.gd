class_name FCube
extends MeshInstance3D


var value: float
var alpha: float = 1.


func _init(value: float):
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(value, value, value, alpha)
	self.mesh = BoxMesh.new()
	self.mesh.material = mat


func _ready():
	pass


func _process(delta):
	pass
