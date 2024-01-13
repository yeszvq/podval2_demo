extends Node


#сигнал для обновленя параметров у игрока
signal update_hero_parametrs

#сигнал для обновления нод при изменении персонажа
signal update_hero

#сигнал для открытия/закрытия блокнота
signal open_notebook
signal notebook_hide

#сигнал о начале диалога
signal start_dialogue
signal end_dialog

#Сигнал о соскрытии и показе части тайлов
signal hide_tiles
signal show_tiles

signal hide_torch
signal show_torch

signal end_stol_change
signal cameninwall

signal show_ocluder
signal hide_ocluder

signal show_light_node
signal hide_light_node

signal custom_one_change
signal zaval
#Сигнал о запуске анимации в animation player
signal start_cutsene
signal usecutscene
signal changetemp
#Сигнал связанные с тестовой панелью
signal call_test_panel
signal hide_light
signal show_light

#Сигналы для подбора предмета
signal custom_dialog
signal start_dialog_for_hero
signal drop_item
#signal pick_up_dialog_true
#signal pick_up_dialog_false
#signal pick_up_dialog_null

#системный сигнал
signal handle_click_storage
signal start_game
signal end_game
signal back_menu
signal back_menu_0
signal end_game_1

signal die
signal back_menu_1
signal again
signal init_level_after_anim
#Сигнал взаимодействия скрипта диалога с скриптом интеракции
signal changeemptytrue
signal changedoeseffect
#сигнал для открыти ядверей
signal open_grid_door
signal close_grid_door

#сигнал для работы с animationplayer
signal use_stop_cutscene
signal use_start_cutscene
signal use_cutscene
signal dark_off
signal dark_on

#Сигнал для героя
signal hide_light_hero
signal show_light_hero

signal legs_heart
signal legs_heal

signal hero_anim_lig_of
signal hero_anim_lig_on
#signal giltoneworked
#signal altarworked

signal no_mind
signal safe_point_on

signal inventorytrue

#сигналы для худа
signal map_new_list

#signal show_i
#signal hide_i

#сигналы для музыкы
signal stop_music
signal start_music

signal stop_sound
signal start_sound

signal changed_music_value
signal changed_sound_value

signal drag_sound_start
signal drag_sound_stop

signal walk_start
signal walk_stop
signal walk_type

signal open_menu
signal hide_menu

signal save_volume
#Сигналы для низкого рассудка и боли
signal low_mind
signal more_mind

signal low_pain
signal more_pain
