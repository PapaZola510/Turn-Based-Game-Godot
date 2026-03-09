extends Node2D

var player_hp = 100
var enemy_hp = 100

var player_turn = true

@onready var player_hp_bar = $UI/PlayerHP
@onready var enemy_hp_bar = $UI/EnemyHP
@onready var attack_button = $UI/Attack_Button
@onready var battle_text = $UI/BattleText
@onready var heal_button = $UI/HealButton

func player_attack():
	if player_turn == false:
		return

	attack_button.disabled = true

	enemy_hp -= 10
	enemy_hp_bar.value = enemy_hp

	if enemy_hp <= 0:
		battle_text.text = "Enemy Defeated!"
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://main_menu.tscn")
		return

	player_turn = false
	await get_tree().create_timer(0.7).timeout
	enemy_turn()


func enemy_turn():
	player_hp -= 8
	player_hp_bar.value = player_hp

	if player_hp <= 0:
		battle_text.text = "You Lost!"
		return

	player_turn = true
	attack_button.disabled = false
	attack_button.disabled = false
	heal_button.disabled = false


func _on_attack_button_pressed():
	player_attack()


func _on_heal_button_pressed():
	if player_turn == false:
		return

	attack_button.disabled = true
	heal_button.disabled = true

	player_hp += 12
	if player_hp > 100:
		player_hp = 100

	player_hp_bar.value = player_hp

	await get_tree().create_timer(0.7).timeout
	player_turn = false
	enemy_turn()
