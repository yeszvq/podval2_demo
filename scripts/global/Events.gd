extends Node


#сигнал для обновленя параметров у игрока
signal update_hero_parametrs

#сигнал для обновления нод при изменении персонажа
signal update_hero

#сигнал для открытия/закрытия блокнота
signal open_notebook

#сигнал о начале диалога
signal start_dialogue
signal end_dialog

#Сигнал о соскрытии и показе части тайлов
signal hide_tiles
signal show_tiles

signal hide_torch
signal show_torch

#Сигнал о запуске анимации в animation player
signal start_cutsene

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

#сигнал для открыти ядверей
signal open_grid_door
signal close_grid_door

#сигнал для работы с animationplayer
signal use_stop_cutscene
signal use_start_cutscene
signal use_cutscene
