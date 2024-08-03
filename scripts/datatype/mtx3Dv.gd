class_name Mtx3Dv
extends RefCounted


var _dims: Vector3i
var _size: int
var _type: int
var _storage: Array[Variant]


func _init(dims: Vector3i, value: Variant = NAN):
	dims = _assert_dims(dims)
	
	self._type = typeof(value)
	self._dims = dims
	
	self._size = dims.x * dims.y * dims.z
	self._storage.resize(self._size)
	self._storage.fill(value)

func _assert_dims(dims: Vector3i) -> Vector3i: # change this function
	for component in range(WWDef.vec3_size):
		if abs(dims[component]) < WWDef.vec3_size:
			printerr("mtx3dv dimension {dim} is zero".format({"dim": dims[component]}))
			dims[component] = 3
		elif dims[component] < 0:
			printerr("mtx3dv dimension {dim} is negative".format({"dim": dims[component]}))
			dims[component] = abs(dims[component])
	return dims

func _assert_index(index: int) -> bool:
	if index >= self._size || index < 0:
		printerr("mtx3dv index {index} out of bounds".format({"index": index}))
		return false
	return true

func _assert_vector(vec: Vector3i) -> bool:
	if vec.x >= self._dims.x || vec.y >= self._dims.y || vec.z >= self._dims.z:
		printerr("mtx3dv vector {vector} out of bounds".format({"vector": vec}))
		return false
	return true

func _assert_type(value: Variant) -> bool:
	var type: int = typeof(value)
	if self._type == type || self._type == NAN || type == NAN:
		return true
	
	printerr("mtx3dv type does not match assignment type {type}".format({"type": typeof(value)}))
	return false

func toV(index: int) -> Vector3i:
	if not _assert_index(index):
		return Vector3i()
	
	var x: int = index % self._dims.x
	var y: int = ((index - x) / self._dims.x) % self._dims.y
	var z: int = (index - x - self._dims.x * y)/(self._dims.x * self._dims.y)
	
	return Vector3i(x, y, z)

func toI(vec: Vector3i) -> int:
	if not _assert_vector(vec):
		return NAN
	return vec.x + self._dims.x * (vec.y + self._dims.y * vec.z)

func getI(index: int) -> Variant:
	if _assert_index(index):
		return self._storage[index]
	return -1.0

func setI(index: int, value: Variant):
	if _assert_type(value) && _assert_index(index):
		self._storage[index] = value

func getV(vec: Vector3i) -> Variant:
	return getI(toI(vec))

func setV(vec: Vector3i, value: Variant):
	setI(toI(vec), value)

func addI(index: int, value: Variant):
	if _assert_type(value) && _assert_index(index):
		self._storage[index] += value

func addV(vec: Vector3i, value: Variant):
	addI(value, toI(vec))

func dims() -> Vector3i:
	return self._dims

func size() -> int:
	return self._storage.size()

func type() -> int:
	return self._type

func empty() -> bool:
	return self._type == NAN

func clear():
	self._storage.clear()
