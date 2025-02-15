#if !macro


@:access(lime.app.Application)
@:access(lime.Assets)
@:access(openfl.display.Stage)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new openfl.display.Application ();
		app.create (config);
		
		var display = new flixel.system.FlxPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		app.setPreloader (preloader);
		preloader.onComplete.add (init);
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/Boss_Starge.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/classicland.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/corridor.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/fallen.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/l1.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/tileset.tsx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/tower.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/Levels/Yway.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/Basic_tileset.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Basic_tileset_black.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/block32.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/images-go-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/mecanic_eye.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/me_sheet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/needle_Trap.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/pasillo_2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/plataforma.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_basic_item.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_bullets.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_e_fly.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_e_jumper.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_e_walk.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Proto_menu_weapon.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_plataforma.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/proto_sheets.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/spring.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/static_enemy.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/terminal.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/tileset.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/traps.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/music/music-goes-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/sounds/BigShot.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Carga.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Dash.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/DestroyBullet.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/jam.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/ProtoJump.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Shot2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/sounds-go-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/sounds/SpringJoint.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/beep.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/flixel.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("Nokia Cellphone FC Small");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("Arial");
		types.push (lime.Assets.AssetType.FONT);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (total == 0) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			build: "2104",
			company: "HaxeFlixel",
			file: "Proto Ex",
			fps: 60,
			name: "Proto Ex",
			orientation: "portrait",
			packageName: "com.example.myapp",
			version: "0.0.1",
			windows: [
				
				{
					antialiasing: 0,
					background: 0,
					borderless: false,
					depthBuffer: false,
					display: 0,
					fullscreen: false,
					hardware: true,
					height: 480,
					parameters: "{}",
					resizable: true,
					stencilBuffer: true,
					title: "Proto Ex",
					vsync: true,
					width: 640,
					x: null,
					y: null
				},
			]
			
		};
		
		#if hxtelemetry
		var telemetry = new hxtelemetry.HxTelemetry.Config ();
		telemetry.allocations = true;
		telemetry.host = "localhost";
		telemetry.app_name = config.name;
		Reflect.setField (config, "telemetry", telemetry);
		#end
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 640, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion @:dox(hide) public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
