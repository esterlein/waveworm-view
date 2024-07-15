class_name Mtx3Df
extends RefCounted


var _dim: Vector3i
var _size: int = 0
var _storage: Array[float]


func _init(dim: Vector3i, value: float = .0):
	self._dim = dim
	self._size = dim.x * dim.y * dim.z
	self._storage.resize(self._size)
	self._storage.fill(value)

func _xyz(index: int) -> Vector3i:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return Vector3i()
	
	var x: int = index % self._dim.x
	var y: int = ((index - x) / self._dim.x) % self._dim.y
	var z: int = (index - x - self._dim.x * y)/(self._dim.x * self._dim.y)
	
	return Vector3i(x, y, z)

func _index(vec: Vector3i) -> int:
	return vec.x + self._dim.x * (vec.y + self._dim.y * vec.z)
	
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
	return self._size
