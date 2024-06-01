package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if (js && html5)
import lime.net.URLLoader;
import lime.net.URLRequest;
#elseif flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_arial_ttf);
		
		#end
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/Levels/Boss_Starge.tmx", __ASSET__assets_data_levels_boss_starge_tmx);
		type.set ("assets/data/Levels/Boss_Starge.tmx", AssetType.TEXT);
		className.set ("assets/data/Levels/classicland.tmx", __ASSET__assets_data_levels_classicland_tmx);
		type.set ("assets/data/Levels/classicland.tmx", AssetType.TEXT);
		className.set ("assets/data/Levels/corridor.tmx", __ASSET__assets_data_levels_corridor_tmx);
		type.set ("assets/data/Levels/corridor.tmx", AssetType.TEXT);
		className.set ("assets/data/Levels/fallen.tmx", __ASSET__assets_data_levels_fallen_tmx);
		type.set ("assets/data/Levels/fallen.tmx", AssetType.TEXT);
		className.set ("assets/data/Levels/l1.tmx", __ASSET__assets_data_levels_l1_tmx);
		type.set ("assets/data/Levels/l1.tmx", AssetType.TEXT);
		className.set ("assets/data/Levels/tileset.tsx", __ASSET__assets_data_levels_tileset_tsx);
		type.set ("assets/data/Levels/tileset.tsx", AssetType.TEXT);
		className.set ("assets/data/Levels/tower.tmx", __ASSET__assets_data_levels_tower_tmx);
		type.set ("assets/data/Levels/tower.tmx", AssetType.TEXT);
		className.set ("assets/data/Levels/Yway.tmx", __ASSET__assets_data_levels_yway_tmx);
		type.set ("assets/data/Levels/Yway.tmx", AssetType.TEXT);
		className.set ("assets/images/Basic_tileset.png", __ASSET__assets_images_basic_tileset_png);
		type.set ("assets/images/Basic_tileset.png", AssetType.IMAGE);
		className.set ("assets/images/Basic_tileset_black.png", __ASSET__assets_images_basic_tileset_black_png);
		type.set ("assets/images/Basic_tileset_black.png", AssetType.IMAGE);
		className.set ("assets/images/block32.png", __ASSET__assets_images_block32_png);
		type.set ("assets/images/block32.png", AssetType.IMAGE);
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		className.set ("assets/images/mecanic_eye.png", __ASSET__assets_images_mecanic_eye_png);
		type.set ("assets/images/mecanic_eye.png", AssetType.IMAGE);
		className.set ("assets/images/me_sheet.png", __ASSET__assets_images_me_sheet_png);
		type.set ("assets/images/me_sheet.png", AssetType.IMAGE);
		className.set ("assets/images/needle_Trap.png", __ASSET__assets_images_needle_trap_png);
		type.set ("assets/images/needle_Trap.png", AssetType.IMAGE);
		className.set ("assets/images/pasillo_2.png", __ASSET__assets_images_pasillo_2_png);
		type.set ("assets/images/pasillo_2.png", AssetType.IMAGE);
		className.set ("assets/images/plataforma.png", __ASSET__assets_images_plataforma_png);
		type.set ("assets/images/plataforma.png", AssetType.IMAGE);
		className.set ("assets/images/proto_basic_item.png", __ASSET__assets_images_proto_basic_item_png);
		type.set ("assets/images/proto_basic_item.png", AssetType.IMAGE);
		className.set ("assets/images/proto_bullets.png", __ASSET__assets_images_proto_bullets_png);
		type.set ("assets/images/proto_bullets.png", AssetType.IMAGE);
		className.set ("assets/images/proto_e_fly.png", __ASSET__assets_images_proto_e_fly_png);
		type.set ("assets/images/proto_e_fly.png", AssetType.IMAGE);
		className.set ("assets/images/proto_e_jumper.png", __ASSET__assets_images_proto_e_jumper_png);
		type.set ("assets/images/proto_e_jumper.png", AssetType.IMAGE);
		className.set ("assets/images/proto_e_walk.png", __ASSET__assets_images_proto_e_walk_png);
		type.set ("assets/images/proto_e_walk.png", AssetType.IMAGE);
		className.set ("assets/images/Proto_menu_weapon.png", __ASSET__assets_images_proto_menu_weapon_png);
		type.set ("assets/images/Proto_menu_weapon.png", AssetType.IMAGE);
		className.set ("assets/images/proto_plataforma.png", __ASSET__assets_images_proto_plataforma_png);
		type.set ("assets/images/proto_plataforma.png", AssetType.IMAGE);
		className.set ("assets/images/proto_sheets.png", __ASSET__assets_images_proto_sheets_png);
		type.set ("assets/images/proto_sheets.png", AssetType.IMAGE);
		className.set ("assets/images/spring.png", __ASSET__assets_images_spring_png);
		type.set ("assets/images/spring.png", AssetType.IMAGE);
		className.set ("assets/images/static_enemy.png", __ASSET__assets_images_static_enemy_png);
		type.set ("assets/images/static_enemy.png", AssetType.IMAGE);
		className.set ("assets/images/terminal.png", __ASSET__assets_images_terminal_png);
		type.set ("assets/images/terminal.png", AssetType.IMAGE);
		className.set ("assets/images/tileset.png", __ASSET__assets_images_tileset_png);
		type.set ("assets/images/tileset.png", AssetType.IMAGE);
		className.set ("assets/images/traps.png", __ASSET__assets_images_traps_png);
		type.set ("assets/images/traps.png", AssetType.IMAGE);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/BigShot.wav", __ASSET__assets_sounds_bigshot_wav);
		type.set ("assets/sounds/BigShot.wav", AssetType.SOUND);
		className.set ("assets/sounds/Carga.wav", __ASSET__assets_sounds_carga_wav);
		type.set ("assets/sounds/Carga.wav", AssetType.SOUND);
		className.set ("assets/sounds/Dash.wav", __ASSET__assets_sounds_dash_wav);
		type.set ("assets/sounds/Dash.wav", AssetType.SOUND);
		className.set ("assets/sounds/DestroyBullet.wav", __ASSET__assets_sounds_destroybullet_wav);
		type.set ("assets/sounds/DestroyBullet.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit.wav", __ASSET__assets_sounds_hit_wav);
		type.set ("assets/sounds/Hit.wav", AssetType.SOUND);
		className.set ("assets/sounds/jam.mp3", __ASSET__assets_sounds_jam_mp3);
		type.set ("assets/sounds/jam.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/ProtoJump.wav", __ASSET__assets_sounds_protojump_wav);
		type.set ("assets/sounds/ProtoJump.wav", AssetType.SOUND);
		className.set ("assets/sounds/Shot2.wav", __ASSET__assets_sounds_shot2_wav);
		type.set ("assets/sounds/Shot2.wav", AssetType.SOUND);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/SpringJoint.wav", __ASSET__assets_sounds_springjoint_wav);
		type.set ("assets/sounds/SpringJoint.wav", AssetType.SOUND);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("assets/fonts/nokiafc22.ttf", __ASSET__assets_fonts_nokiafc22_ttf);
		type.set ("assets/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("assets/fonts/arial.ttf", __ASSET__assets_fonts_arial_ttf);
		type.set ("assets/fonts/arial.ttf", AssetType.FONT);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/Boss_Starge.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/classicland.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/corridor.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/fallen.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/l1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/tileset.tsx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/tower.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/Levels/Yway.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/Basic_tileset.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Basic_tileset_black.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/block32.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/images-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/mecanic_eye.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/me_sheet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/needle_Trap.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/pasillo_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/plataforma.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_basic_item.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_bullets.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_e_fly.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_e_jumper.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_e_walk.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Proto_menu_weapon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_plataforma.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/proto_sheets.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/spring.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/static_enemy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/terminal.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tileset.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/traps.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/BigShot.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Carga.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Dash.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/DestroyBullet.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/jam.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/ProtoJump.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Shot2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/SpringJoint.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__assets_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/arial.ttf";
		className.set (id, __ASSET__assets_fonts_arial_ttf);
		
		type.set (id, AssetType.FONT);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/Levels/Boss_Starge.tmx", __ASSET__assets_data_levels_boss_starge_tmx);
		type.set ("assets/data/Levels/Boss_Starge.tmx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/classicland.tmx", __ASSET__assets_data_levels_classicland_tmx);
		type.set ("assets/data/Levels/classicland.tmx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/corridor.tmx", __ASSET__assets_data_levels_corridor_tmx);
		type.set ("assets/data/Levels/corridor.tmx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/fallen.tmx", __ASSET__assets_data_levels_fallen_tmx);
		type.set ("assets/data/Levels/fallen.tmx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/l1.tmx", __ASSET__assets_data_levels_l1_tmx);
		type.set ("assets/data/Levels/l1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/tileset.tsx", __ASSET__assets_data_levels_tileset_tsx);
		type.set ("assets/data/Levels/tileset.tsx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/tower.tmx", __ASSET__assets_data_levels_tower_tmx);
		type.set ("assets/data/Levels/tower.tmx", AssetType.TEXT);
		
		className.set ("assets/data/Levels/Yway.tmx", __ASSET__assets_data_levels_yway_tmx);
		type.set ("assets/data/Levels/Yway.tmx", AssetType.TEXT);
		
		className.set ("assets/images/Basic_tileset.png", __ASSET__assets_images_basic_tileset_png);
		type.set ("assets/images/Basic_tileset.png", AssetType.IMAGE);
		
		className.set ("assets/images/Basic_tileset_black.png", __ASSET__assets_images_basic_tileset_black_png);
		type.set ("assets/images/Basic_tileset_black.png", AssetType.IMAGE);
		
		className.set ("assets/images/block32.png", __ASSET__assets_images_block32_png);
		type.set ("assets/images/block32.png", AssetType.IMAGE);
		
		className.set ("assets/images/images-go-here.txt", __ASSET__assets_images_images_go_here_txt);
		type.set ("assets/images/images-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/images/mecanic_eye.png", __ASSET__assets_images_mecanic_eye_png);
		type.set ("assets/images/mecanic_eye.png", AssetType.IMAGE);
		
		className.set ("assets/images/me_sheet.png", __ASSET__assets_images_me_sheet_png);
		type.set ("assets/images/me_sheet.png", AssetType.IMAGE);
		
		className.set ("assets/images/needle_Trap.png", __ASSET__assets_images_needle_trap_png);
		type.set ("assets/images/needle_Trap.png", AssetType.IMAGE);
		
		className.set ("assets/images/pasillo_2.png", __ASSET__assets_images_pasillo_2_png);
		type.set ("assets/images/pasillo_2.png", AssetType.IMAGE);
		
		className.set ("assets/images/plataforma.png", __ASSET__assets_images_plataforma_png);
		type.set ("assets/images/plataforma.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_basic_item.png", __ASSET__assets_images_proto_basic_item_png);
		type.set ("assets/images/proto_basic_item.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_bullets.png", __ASSET__assets_images_proto_bullets_png);
		type.set ("assets/images/proto_bullets.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_e_fly.png", __ASSET__assets_images_proto_e_fly_png);
		type.set ("assets/images/proto_e_fly.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_e_jumper.png", __ASSET__assets_images_proto_e_jumper_png);
		type.set ("assets/images/proto_e_jumper.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_e_walk.png", __ASSET__assets_images_proto_e_walk_png);
		type.set ("assets/images/proto_e_walk.png", AssetType.IMAGE);
		
		className.set ("assets/images/Proto_menu_weapon.png", __ASSET__assets_images_proto_menu_weapon_png);
		type.set ("assets/images/Proto_menu_weapon.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_plataforma.png", __ASSET__assets_images_proto_plataforma_png);
		type.set ("assets/images/proto_plataforma.png", AssetType.IMAGE);
		
		className.set ("assets/images/proto_sheets.png", __ASSET__assets_images_proto_sheets_png);
		type.set ("assets/images/proto_sheets.png", AssetType.IMAGE);
		
		className.set ("assets/images/spring.png", __ASSET__assets_images_spring_png);
		type.set ("assets/images/spring.png", AssetType.IMAGE);
		
		className.set ("assets/images/static_enemy.png", __ASSET__assets_images_static_enemy_png);
		type.set ("assets/images/static_enemy.png", AssetType.IMAGE);
		
		className.set ("assets/images/terminal.png", __ASSET__assets_images_terminal_png);
		type.set ("assets/images/terminal.png", AssetType.IMAGE);
		
		className.set ("assets/images/tileset.png", __ASSET__assets_images_tileset_png);
		type.set ("assets/images/tileset.png", AssetType.IMAGE);
		
		className.set ("assets/images/traps.png", __ASSET__assets_images_traps_png);
		type.set ("assets/images/traps.png", AssetType.IMAGE);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/BigShot.wav", __ASSET__assets_sounds_bigshot_wav);
		type.set ("assets/sounds/BigShot.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Carga.wav", __ASSET__assets_sounds_carga_wav);
		type.set ("assets/sounds/Carga.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Dash.wav", __ASSET__assets_sounds_dash_wav);
		type.set ("assets/sounds/Dash.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/DestroyBullet.wav", __ASSET__assets_sounds_destroybullet_wav);
		type.set ("assets/sounds/DestroyBullet.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit.wav", __ASSET__assets_sounds_hit_wav);
		type.set ("assets/sounds/Hit.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/jam.mp3", __ASSET__assets_sounds_jam_mp3);
		type.set ("assets/sounds/jam.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/ProtoJump.wav", __ASSET__assets_sounds_protojump_wav);
		type.set ("assets/sounds/ProtoJump.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Shot2.wav", __ASSET__assets_sounds_shot2_wav);
		type.set ("assets/sounds/Shot2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/SpringJoint.wav", __ASSET__assets_sounds_springjoint_wav);
		type.set ("assets/sounds/SpringJoint.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("assets/fonts/nokiafc22.ttf", __ASSET__assets_fonts_nokiafc22_ttf);
		type.set ("assets/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/arial.ttf", __ASSET__assets_fonts_arial_ttf);
		type.set ("assets/fonts/arial.ttf", AssetType.FONT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var data = loader.data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var data = loader.data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<ByteArray> {
		
		var promise = new Promise<ByteArray> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = BINARY;
			loader.onComplete.add (function (_):Void {
				
				promise.complete (loader.data);
				
			});
			loader.onProgress.add (function (_, loaded, total) {
				
				if (total == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (loaded / total);
					
				}
				
			});
			loader.onIOError.add (function (_, e) {
				
				promise.error (e);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<ByteArray> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id);
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.onComplete.add (function (_):Void {
				
				promise.complete (loader.data);
				
			});
			loader.onProgress.add (function (_, loaded, total) {
				
				if (total == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (loaded / total);
					
				}
				
			});
			loader.onIOError.add (function (_, msg) promise.error (msg));
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.readUTFBytes (bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_boss_starge_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_classicland_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_corridor_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_fallen_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_l1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_tileset_tsx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_tower_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levels_yway_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_basic_tileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_basic_tileset_black_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_block32_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_mecanic_eye_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_me_sheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_needle_trap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_pasillo_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_plataforma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_basic_item_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_bullets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_e_fly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_e_jumper_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_e_walk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_menu_weapon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_plataforma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_proto_sheets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_spring_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_static_enemy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_terminal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tileset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_traps_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_bigshot_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_carga_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_dash_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_destroybullet_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_jam_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_protojump_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shot2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_springjoint_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_arial_ttf extends flash.text.Font { }


#elseif html5













































@:keep #if display private #end class __ASSET__assets_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__assets_fonts_arial_ttf extends lime.text.Font { public function new () { super (); name = "Arial"; } } 


#else



#if (windows || mac || linux || cpp)


@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/data/Levels/Boss_Starge.tmx") #if display private #end class __ASSET__assets_data_levels_boss_starge_tmx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/classicland.tmx") #if display private #end class __ASSET__assets_data_levels_classicland_tmx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/corridor.tmx") #if display private #end class __ASSET__assets_data_levels_corridor_tmx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/fallen.tmx") #if display private #end class __ASSET__assets_data_levels_fallen_tmx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/l1.tmx") #if display private #end class __ASSET__assets_data_levels_l1_tmx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/tileset.tsx") #if display private #end class __ASSET__assets_data_levels_tileset_tsx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/tower.tmx") #if display private #end class __ASSET__assets_data_levels_tower_tmx extends lime.utils.ByteArray {}
@:file("assets/data/Levels/Yway.tmx") #if display private #end class __ASSET__assets_data_levels_yway_tmx extends lime.utils.ByteArray {}
@:image("assets/images/Basic_tileset.png") #if display private #end class __ASSET__assets_images_basic_tileset_png extends lime.graphics.Image {}
@:image("assets/images/Basic_tileset_black.png") #if display private #end class __ASSET__assets_images_basic_tileset_black_png extends lime.graphics.Image {}
@:image("assets/images/block32.png") #if display private #end class __ASSET__assets_images_block32_png extends lime.graphics.Image {}
@:file("assets/images/images-go-here.txt") #if display private #end class __ASSET__assets_images_images_go_here_txt extends lime.utils.ByteArray {}
@:image("assets/images/mecanic_eye.png") #if display private #end class __ASSET__assets_images_mecanic_eye_png extends lime.graphics.Image {}
@:image("assets/images/me_sheet.png") #if display private #end class __ASSET__assets_images_me_sheet_png extends lime.graphics.Image {}
@:image("assets/images/needle_Trap.png") #if display private #end class __ASSET__assets_images_needle_trap_png extends lime.graphics.Image {}
@:image("assets/images/pasillo_2.png") #if display private #end class __ASSET__assets_images_pasillo_2_png extends lime.graphics.Image {}
@:image("assets/images/plataforma.png") #if display private #end class __ASSET__assets_images_plataforma_png extends lime.graphics.Image {}
@:image("assets/images/proto_basic_item.png") #if display private #end class __ASSET__assets_images_proto_basic_item_png extends lime.graphics.Image {}
@:image("assets/images/proto_bullets.png") #if display private #end class __ASSET__assets_images_proto_bullets_png extends lime.graphics.Image {}
@:image("assets/images/proto_e_fly.png") #if display private #end class __ASSET__assets_images_proto_e_fly_png extends lime.graphics.Image {}
@:image("assets/images/proto_e_jumper.png") #if display private #end class __ASSET__assets_images_proto_e_jumper_png extends lime.graphics.Image {}
@:image("assets/images/proto_e_walk.png") #if display private #end class __ASSET__assets_images_proto_e_walk_png extends lime.graphics.Image {}
@:image("assets/images/Proto_menu_weapon.png") #if display private #end class __ASSET__assets_images_proto_menu_weapon_png extends lime.graphics.Image {}
@:image("assets/images/proto_plataforma.png") #if display private #end class __ASSET__assets_images_proto_plataforma_png extends lime.graphics.Image {}
@:image("assets/images/proto_sheets.png") #if display private #end class __ASSET__assets_images_proto_sheets_png extends lime.graphics.Image {}
@:image("assets/images/spring.png") #if display private #end class __ASSET__assets_images_spring_png extends lime.graphics.Image {}
@:image("assets/images/static_enemy.png") #if display private #end class __ASSET__assets_images_static_enemy_png extends lime.graphics.Image {}
@:image("assets/images/terminal.png") #if display private #end class __ASSET__assets_images_terminal_png extends lime.graphics.Image {}
@:image("assets/images/tileset.png") #if display private #end class __ASSET__assets_images_tileset_png extends lime.graphics.Image {}
@:image("assets/images/traps.png") #if display private #end class __ASSET__assets_images_traps_png extends lime.graphics.Image {}
@:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/sounds/BigShot.wav") #if display private #end class __ASSET__assets_sounds_bigshot_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/Carga.wav") #if display private #end class __ASSET__assets_sounds_carga_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/Dash.wav") #if display private #end class __ASSET__assets_sounds_dash_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/DestroyBullet.wav") #if display private #end class __ASSET__assets_sounds_destroybullet_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/Hit.wav") #if display private #end class __ASSET__assets_sounds_hit_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/jam.mp3") #if display private #end class __ASSET__assets_sounds_jam_mp3 extends lime.utils.ByteArray {}
@:file("assets/sounds/ProtoJump.wav") #if display private #end class __ASSET__assets_sounds_protojump_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/Shot2.wav") #if display private #end class __ASSET__assets_sounds_shot2_wav extends lime.utils.ByteArray {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.ByteArray {}
@:file("assets/sounds/SpringJoint.wav") #if display private #end class __ASSET__assets_sounds_springjoint_wav extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/3,3,11/assets/sounds/beep.mp3") #if display private #end class __ASSET__assets_sounds_beep_mp3 extends lime.utils.ByteArray {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/3,3,11/assets/sounds/flixel.mp3") #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends lime.utils.ByteArray {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/3,3,11/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__assets_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/3,3,11/assets/fonts/arial.ttf") #if display private #end class __ASSET__assets_fonts_arial_ttf extends lime.text.Font {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__assets_fonts_arial_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_fonts_arial_ttf (); src = font.src; name = font.name; super (); }}

#end

#end