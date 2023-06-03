extends CharacterBody2D
class_name BaseUnit

# ===== Unit Variables ====
@export var unit_name: String
@export var health: int = 10 # base health, modified by gear, constitution
@export var attack: int = 0 # base attack chance, modified by gear
@export var damage: int = 2 # base damage, modified by gear, boosts, strength
@export var defense: int = 10 # base defense, modified by gear
@export var strength: int = 5
@export var constitution: int = 5 
@export var intelligence: int = 5 # modifies spell potency
# =========================

# ===== Scene Imports =====
@onready var tile_map = $"../TileMap"
# =========================

func _ready() -> void:
	# Center the unit on the closest tile
	var unit_pos = tile_map.local_to_map(self.position)
	self.position = tile_map.map_to_local(unit_pos)
