
global.pause		= false;
global.view_width	= camera_get_view_width(view_camera[0]);
global.view_height	= camera_get_view_height(view_camera[0]);

global.key_revert	= vk_escape;
global.key_conform	= vk_enter;
global.key_enter	= vk_enter;
global.key_up		= ord("W");
global.key_down		= ord("S");
global.key_right	= ord("A");
global.key_left		= ord("D");

allObjects[0,0]		= noone;

display_set_gui_size(global.view_width, global.view_height);

enum menu_page {
	main,
	settings,
	control,
	video,
	audio,
	enum_size
}

enum menu_element_type {
	 script_runner,
	 page_transfer,
	 slider,
	 shift,
	 toggle,
	 input
}

// CREATING MENU PAGES
ds_menu_main = create_menu_page(
	["RESUME",		menu_element_type.script_runner,	resume_game],
	["SETTINGS",	menu_element_type.page_transfer,	menu_page.settings],
	["EXIT",		menu_element_type.script_runner,	exit_game],
);

ds_settings = create_menu_page(
	["CONTROLS",	menu_element_type.page_transfer,	menu_page.control],
	["VIDEO",		menu_element_type.page_transfer,	menu_page.video],
	["AUDIO",		menu_element_type.page_transfer,	menu_page.audio],
	["BACK",		menu_element_type.page_transfer,	menu_page.main],
);

ds_menu_controls = create_menu_page(
	["JUMP",		menu_element_type.input,			"key_up",				vk_up],
	["DUCK",		menu_element_type.input,			"key_down",				vk_down],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_video = create_menu_page(
	["RESOLUTION",	menu_element_type.shift,			change_resolution,		0,			[1,2,3,4,5]],
	["FULLSCREEN",	menu_element_type.toggle,			change_window_mode,		1,			["FULLSCREEN", "WINDOWED"]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_audio = create_menu_page(
	["MASTER",		menu_element_type.slider,			change_volume,			1,			[0, 1]],
	["SOUND FX",	menu_element_type.slider,			change_volume,			1,			[0, 1]],
	["MUSIC",		menu_element_type.slider,			change_volume,			1,			[0, 1]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

page = 0;
menu_pages = [ds_menu_main, ds_settings, ds_menu_controls, ds_menu_video, ds_menu_audio]

var i = 0, array_len = array_length_1d(menu_pages);
repeat(array_len){
	menu_option[i] = 0;
	i++;
}


inputting = false;