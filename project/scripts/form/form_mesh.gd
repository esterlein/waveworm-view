@tool
class_name FormMesh
extends MeshInstance3D


var layers := MeshAttributes.new()
var streams := MeshAttributes.new()


func add_layer(attrs: MeshAttributes) -> void:
	self.layers.append_mesh_attributes(attrs)
	

func add_stream(attrs: MeshAttributes) -> void:
	self.streams.append_mesh_attributes(attrs)


func commit_mesh() -> void:
	mesh = ArrayMesh.new()
	
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, self.layers.create_array())
	
	var mat = StandardMaterial3D.new()
	mat.set_albedo(layer_color)
	mat.set_cull_mode(StandardMaterial3D.CULL_DISABLED)

	set_surface_override_material(0, mat)

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, self.streams.create_array())
	
	mat = StandardMaterial3D.new()
	mat.set_albedo(stream_color)
	mat.set_cull_mode(StandardMaterial3D.CULL_DISABLED)

	set_surface_override_material(1, mat)
