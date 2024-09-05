class_name Simulator
extends RefCounted


static func get_gradient_sphere(dims: Vector3i, strength: int, noise: float) -> Mtx3Dv:
	var mtx_field := Mtx3Dv.new(dims)
	
	var center_x: float = dims.x / 2.0
	var center_y: float = dims.y / 2.0
	var center_z: float = dims.z / 2.0
	
	for x in range(dims.x):
		for y in range(dims.y):
			for z in range(dims.z):
				var value := float(strength - sqrt(abs(center_x - x) ** 2 +
				abs(center_y - y) ** 2 + abs(center_z - z) ** 2)) + randfn(.0, noise)
				mtx_field.setV(Vector3i(x, y, z), value)
	
	return mtx_field


static func scalar_offset_normalize(mtx: Mtx3Dv) -> Mtx3Dv:
	var dims := mtx.dims()
	var min_val: float = WWDef.FLOAT_MAX
	
	for x in range(dims.x):
		for y in range(dims.y):
			for z in range(dims.z):
				min_val = min(min_val, mtx.getV(Vector3i(x, y, z)))
	
	for x in range(dims.x):
		for y in range(dims.y):
			for z in range(dims.z):
				mtx.addV(Vector3i(x, y, z), -min_val)
	
	return mtx


static func minmax_scale_normalize(mtx: Mtx3Dv) -> Mtx3Dv:
	var size := mtx.size()
	var min_val: float = WWDef.FLOAT_MAX
	var max_val: float = WWDef.FLOAT_MIN
	
	for index in range(size):
		var val: float = mtx.getI(index)
		min_val = min(min_val, val)
		max_val = max(max_val, val)
	
	for index in range(size):
		var val_scaled: float = (mtx.getI(index) - min_val) / (max_val - min_val)
		mtx.setI(index, val_scaled)
	
	return mtx


static func get_minmax_scaled(mtx: Mtx3Dv) -> Mtx3Dv:
	var size := mtx.size()
	var min_val: float = WWDef.FLOAT_MAX
	var max_val: float = WWDef.FLOAT_MIN
	
	var mtx_scaled := Mtx3Dv.new(mtx.dims())
	
	for index in range(size):
		var val: float = mtx.getI(index)
		min_val = min(min_val, val)
		max_val = max(max_val, val)
	
	for index in range(size):
		var val_scaled: float = (mtx.getI(index) - min_val) / (max_val - min_val)
		mtx_scaled.setI(index, val_scaled)
	
	return mtx_scaled


static func get_probe(perc_probe: int, free_range: int, mtx_field: Mtx3Dv) -> Mtx3Dv:
	var mtx_probe := Mtx3Dv.new(mtx_field.dims())
	
	if not (perc_probe > 0 && free_range >= 0):
		printerr("wrong field parameters {dens, spar}".format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var mtx_size: int = mtx_field.size()
	var chunk_size: int = (free_range * 2 + 1) ** WWDef.VEC3_SIZE
	if mtx_size / chunk_size <= perc_probe:
		printerr("required percent of field or volume required for probing distance is too large {dens, spar}" \
		.format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var num_probes: int = mtx_size * perc_probe / 100
	
	var cnt_probe: int = 0
	var coords_map: Dictionary = {}
	
	coords_map[mtx_probe.toV(randi_range(0, mtx_size - 1))] = true # utilize bool value
	
	while cnt_probe < num_probes:
		var index: int = randi_range(0, mtx_size - 1)
		var coords = mtx_probe.toV(index)
		
		if coords_map.has(coords):
			continue
		
		for entry in coords_map:
			var vec_diff: Vector3i = abs(entry - coords)
			for axis_diff in vec_diff:
				if axis_diff > free_range * 2:
					mtx_probe.setI(index, mtx_field.getI(index))
					coords_map[coords] = true # utilize bool value
					cnt_probe += 1
					break
	
	return mtx_probe
