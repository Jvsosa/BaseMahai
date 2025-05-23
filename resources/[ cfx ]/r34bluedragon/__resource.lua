
--shared_script "" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
files {
	'vehicles.meta',
	'carvariations.meta',
	'carcols.meta',
	'handling.meta',
	'vehiclelayouts.meta',
	'audio/audioconfig/*.dat151.rel',
    'audio/audioconfig/*.dat54.rel',
    'audio/audioconfig/*.dat10.rel',
	'audio/sfx/**/*.awc',
}
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'AUDIO_SYNTHDATA' 'audio/audioconfig/bnr34ffeng_amp.dat'
data_file 'AUDIO_GAMEDATA' 'audio/audioconfig/bnr34ffeng_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audio/audioconfig/bnr34ffeng_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/dlc_bnr34ffeng'              