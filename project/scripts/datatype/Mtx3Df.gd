class_name Mtx3Df
extends RefCounted


var _dims: Vector3i
var _storage: Array[float]


func _init(dims: Vector3i, value: float = .0):
	self._dims = dims
	
	var size := dims.x * dims.y * dims.z
	self._storage.resize(size)
	self._storage.fill(value)

func _xyz(index: int) -> Vector3i:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return Vector3i()
	
	var x: int = index % self._dims.x
	var y: int = ((index - x) / self._dims.x) % self._dims.y
	var z: int = (index - x - self._dims.x * y)/(self._dims.x * self._dims.y)
	
	return Vector3i(x, y, z)

func _index(vec: Vector3i) -> int:
	return vec.x + self._dims.x * (vec.y + self._dims.y * vec.z)
	
func _index_assert(index: int) -> bool:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return false
	return true

func getid(index: int) -> float:
	if _index_assert(index):
		return _storage[index]
	return -1.0

func setid(index: int, value: float):
	if _index_assert(index):
		_storage[index] = value

func getvec(vec: Vector3i) -> float:
	return getid(_index(vec))

func setvec(vec: Vector3i, value: float):
	setid(value, _index(vec))

func addid(index: int, value: float):
	if _index_assert(index):
		_storage[index] += value

func addvec(vec: Vector3i, value: float):
	addid(value, _index(vec))

func size() -> int:
	return self._storage.size()

func dims() -> Vector3i:
	return self._dims
