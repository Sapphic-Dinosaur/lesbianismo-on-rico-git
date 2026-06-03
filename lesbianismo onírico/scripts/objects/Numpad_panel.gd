extends Interaction_object

@export var result: Label
var writen_nums: int

func _ready() -> void:
	writen_nums = 0
	result.text = "000"

func _on_button_0_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "0"

func _on_button_1_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "1"

func _on_button_2_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "2"

func _on_button_3_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "3"

func _on_button_4_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "4"

func _on_button_5_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "5"

func _on_button_6_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "6"

func _on_button_7_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "7"

func _on_button_8_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "8"

func _on_button_9_button_down() -> void:
	result.text = result.text[1] + result.text[2] + "9"

func _on_button_enter_button_down() -> void:
	_check_result()

func interaction_confirmed():
	_check_result()

func _check_result() -> void:
	if result.text == "451":
		result.text = "000"
		print("Done")
	else: result.text = "000"
