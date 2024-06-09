@tool
class_name FormMesh
extends MeshInstance3D


var layers := MeshAttributes.new()
var streams := MeshAttributes.new()


func add_layer(attrs: MeshAttributes) -> void:
	self.branches.append_mesh_attributes(attrs)
	

func add_stream(attrs: MeshAttributes) -> void:
	self.leaves.append_mesh_attributes(attrs)


func commit_mesh() -> void:
	pass
