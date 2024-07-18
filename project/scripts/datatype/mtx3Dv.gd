class_name Mtx3Dv
extends RefCounted


var _dims: Vector3i
var _type: int
var _storage: Array[Variant]


func _init(dims: Vector3i, value: Variant = NAN):
	self._type = typeof(value)
	self._dims = dims
	
	var size := dims.x * dims.y * dims.z
	self._storage.resize(size)
	self._storage.fill(value)

func _toV(index: int) -> Vector3i:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return Vector3i()
	
	var x: int = index % self._dims.x
	var y: int = ((index - x) / self._dims.x) % self._dims.y
	var z: int = (index - x - self._dims.x * y)/(self._dims.x * self._dims.y)
	
	return Vector3i(x, y, z)

func _toI(vec: Vector3i) -> int:
	return vec.x + self._dims.x * (vec.y + self._dims.y * vec.z)
	
func _index_assert(index: int) -> bool:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return false
	return true

func getI(index: int) -> Variant:
	if _index_assert(index):
		return _storage[index]
	return -1.0

func setI(index: int, value: Variant):
	if _index_assert(index):
		_storage[index] = value

func getV(vec: Vector3i) -> Variant:
	return getI(_toI(vec))

func setV(vec: Vector3i, value: Variant):
	setI(value, _toI(vec))

func addI(index: int, value: Variant):
	if _index_assert(index):
		_storage[index] += value

func addV(vec: Vector3i, value: Variant):
	addI(value, _toI(vec))

func size() -> int:
	return self._storage.size()

func dims() -> Vector3i:
	return self._dims
