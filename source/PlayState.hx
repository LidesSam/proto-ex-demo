package;


import flixel.FlxG;
import flixel.system.debug.FlxDebugger;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import flixel.util.loaders.TextureAtlasFrame;

import flixel.tile.FlxTilemap;
import flixel.FlxCamera;

import flixel.FlxObject;
import flixel.group.FlxGroup;

import flixel.util.FlxSave;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;

import flixel.util.FlxColor;
import flixel.tweens.FlxEase;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	private var hud:Hud;
	private var player:Player;
	private var boss:Boss;
	private var level: FlxTilemap;
	private var enemys:FlxGroup;
	private var atacks:FlxGroup;
	private var items:FlxGroup;
	private var traps:FlxGroup;//plataformas resortes(Spring) y piso falso(FallPanel)
	private var plataformas:FlxGroup;//plataformas resortes(Spring) y piso falso(FallPanel)
	private var doors:FlxGroup;//puertas y posicion del jugador
	
	
	private var save_t:Save_terminal;
	
	private var in_boss_starge:Bool;
	
	//private var onTransition:Bool;
	public var text:FlxText;

	override public function create():Void
	{
		
		super.create();
		text = new FlxText(200, 200,FlxG.width, "-----");
		text.color = FlxColor.BLACK;
		//add(text);
		
		
		FlxG.debugger.visible = true;
		player = new Player(0, 0);
		
		if (Reg.IsLoad) {
				
			//carga desde el punto guardado
			LoadFromSave();
		}else {
			LoadLevel();
		}
		
		Reg.level = level;
		if (in_boss_starge){
			bgColor = 0xff002222;//FlxColor.BLACK;
			
			hud = new Hud(player,boss);
			
		}
		else{
			bgColor = 0xff005555;//FlxColor.BLACK;
			
			hud = new Hud(player);
		}
		
		
		add(hud);
		
		//title level
		// muestra el nombre del nivel actual
		
		var LevelTitle = new FlxText(0, FlxG.height/6, FlxG.width,Reg.level_title.length);
		LevelTitle.setFormat(null, 48, FlxColor.BLACK,"center");
		LevelTitle.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.SILVER, 4, 3);
		add(LevelTitle);
		LevelTitle.scrollFactor.x = 0;
		LevelTitle.scrollFactor.y = 0;
		LevelTitle.text = Reg.level_title;
		//var opt = { remove(LevelTitle) };
		//Path: se mueve a la izquierda y sale por derecha
		//var points:Array<FlxPoint> = [new FlxPoint(LevelTitle.x, LevelTitle.y),new FlxPoint(LevelTitle.x - LevelTitle.width / 2, LevelTitle.y), new FlxPoint(LevelTitle.x, LevelTitle.y), new FlxPoint(0, LevelTitle.y)];
		//Path se mueve acia abajo y sale por ariba
		var points:Array<FlxPoint> = [new FlxPoint(LevelTitle.x, LevelTitle.y),new FlxPoint(LevelTitle.x-64, LevelTitle.y), new FlxPoint(FlxG.width, LevelTitle.y)];
		var tween1 = FlxTween.linearPath(LevelTitle, points, 2, true, { ease:FlxEase.expoIn, } );//,opt);
		var tween2 = FlxTween.tween(LevelTitle, { alpha: 0, },2,TweenOptions );//,opt);
		
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void{
		
		super.update();
		//if(Reg.IsLoad==false){
		
		FlxG.collide(level, player);
		FlxG.collide(level, enemys);
		FlxG.collide(level, items,overlap_level_item);
		FlxG.collide(level, save_t);
		//FlxG.collide(level, plataformas);
		FlxG.collide(level, atacks,overlap_level_atk);
		
		FlxG.overlap(player, save_t, overlap_save);
		FlxG.overlap(player, items, overlap_items);
		FlxG.overlap(player, plataformas, overlap_plataform);
		//FlxG.collide(player, plataformas, overlap_plataform);
		
		FlxG.overlap(player, enemys, overlap_p_enemys);
		FlxG.overlap(player, traps, overlap_p_traps);
		FlxG.overlap(enemys, atacks, overlap_e_atk);
		FlxG.collide(player, atacks, overlap_p_atk);
		FlxG.overlap(player, doors, overlap_doors);
		
		if(save_t!=null){
			if(FlxG.keys.justPressed.X && save_t.GetContact()){
				//save_t.Save(enemys, atacks, level, plataformas, items, traps, doors);
				save_t.Save(player);
			}			
		}
		
		if (player.get_life() <= 0  || player.y > level.height) {
			//comprueva la vida o si se sale del nivel
			Reg.win = false;
			FlxG.switchState(new GameOverState());
			
		}
		
		if (FlxG.keys.justPressed.O) {//descomentar para probar rapido la pantalla de gameover
			//Reg.win = false;//derrota
			//Reg.win = true;//victoria
			//FlxG.switchState(new GameOverState());
		}
		
		if (in_boss_starge && Reg.boss_defeat){//chequea si se derroto al jefe si se encuentra en una sala con este
			Reg.win = true;
			FlxG.switchState(new GameOverState());
		}
	}	
	
	//Carga el nivel
	public function LoadLevel():Void {
		var fordoor:Bool = false;
		
		player = new Player(0, 0);
		items = new FlxGroup();
		enemys = new FlxGroup();
		atacks = new FlxGroup();
		plataformas = new FlxGroup();
		traps = new FlxGroup();
		doors = new FlxGroup();
		
		
		level = new FlxTilemap();
		var tiledMap:TiledMap ;
		//Reg.last_level = Reg.act_level;	
		
		//comprueva si el nivel actual es nulo carga el primer	 nivel
		if (Reg.act_level == null) {
				//Reg.act_level = "assets/data/Levels/l1.tmx";
				//Reg.act_level = "assets/data/Levels/classicland.tmx";
				//Reg.act_level = "assets/data/Levels/Yway.tmx";
				//Reg.act_level = "assets/data/Levels/fallen.tmx";
				//Reg.act_level = "assets/data/Levels/tower.tmx";
				//Reg.act_level = "assets/data/Levels/corridor.tmx";
				Reg.act_level = "assets/data/Levels/Boss_Starge.tmx";
				
				Reg.level_title = "classicland";
				tiledMap = new TiledMap(Reg.act_level); 
				
			}
		else {
			
			//coloca la vida, armas y buff del jugador que tenia en el nivel anterior
				
			player.set_life();
			player.set_weapon();
			player.set_buff();
				
			
			tiledMap = new TiledMap(Reg.act_level);
		}
		
		
		var layer = tiledMap.getLayer("Solid");
		var mapData = layer.tileArray;
		level.widthInTiles = tiledMap.width;
		level.heightInTiles = tiledMap.height;
		
		var tileset = "assets/images/tileset.png";
		level.loadMap(mapData, tileset, tiledMap.tileWidth, tiledMap.tileHeight, 0, 1);
		
		add(level);//añade el nivel a la escena;
		
		
		// variables auxiliares para la carga de los objetos
		
		//carga las capas de objetos de tiled
		var group:TiledObjectGroup;
		var o:TiledObject; 
		
		
		group = tiledMap.getObjectGroup("Player");
		
		for (o in group.objects) //recorre el grupo actual
			{
			
				// ubicacion del objeto en tiled
				var x:Int = o.x;
				var y:Int = o.y;
				
				
				if (o.gid != -1)
					y -= group.map.getGidOwner(o.gid).tileHeight;
				switch(o.type.toLowerCase())
				{
					
					case "player_start":
						if (fordoor==false && Reg.IsLoad==false){
							player.x = x;
							player.y = y;
						}
					case "save_t":
						save_t = new Save_terminal(x, y);
						add(save_t);
					
					default:
						var new_door = new Door(x, y , o.type);
						if (o.angle ==180) {//correcion de ubicacion de la puerta
									new_door.x -= new_door.width;
									new_door.y += 32;
						}
						doors.add(new_door);
						
						//FlxG.log.add(new_door.level_string(false)+" °Last:° "+Reg.last_level );
						// compara si el ultimo nivel es igual al de la puerta y situal al jugador a un lado de esta
						if (Reg.last_level == new_door.level_string(false) && fordoor==false && Reg.IsLoad==false ){
							//FlxG.log.add("LASTLEVELLOAD");
							
							//posicion del jugador segun esi el tileobject esta volteado horizontalmente
							
							if (o.angle ==180) {
								//utilizo rotacion en lugar flip porque los objetos con flip verdaderno me producen un error
								
								player.flipX = true;
								player.x = new_door.x-32;//debido a rotacion
								player.y = new_door.y;//debido a rtacion
							}
							else{
							 
								player.x = new_door.x+32;
								player.y = new_door.y;
							}
							//player.x = x + 32;
							//player.y = y;
							fordoor = true;
						}
				}
			}
			
			
		for (group in tiledMap.objectGroups)//recorre los grupos del tilemap
		{
			
		
			for (o in group.objects) //recorre el grupo actual
			{
			
				
				// ubicacion del objeto en tiled
				var x:Int = o.x;
				var y:Int = o.y;
				// corrige la posiion y de los objetos
				if (o.gid != -1){
					y -= group.map.getGidOwner(o.gid).tileHeight;
					}
					
				switch(o.type.toLowerCase())
				{
					//Carga de jefes
					case "boss":
							boss = new Boss(x, y);
							boss.set_player(player);
							boss.define_enemy(0);
							enemys.add(boss);
							atacks.add(boss.atacks);
							//indica si se esta combatiendo un jefe
							in_boss_starge = true;
							Reg.boss_defeat = false;
							items.add(boss.drop_item);
							enemys.add(boss.drop_enemy);
							
						//carga de enemigos
						
						//estaticos
						case "single":
								var e = new Enemy(x, y);
								e.define_enemy(0);
								e.set_player(player);
								e.SetRotation(o.angle);
								enemys.add(e);
								atacks.add(e.atacks);
								
								//direcion de disparo derecha o izquierda
								if (o.custom.dir!="0"){
									e.flipX = true;//derecha
								}
								
						case "trishot":
								var e = new Enemy(x, y);
								
								e.define_enemy(1);
								e.set_player(player);
								
								//direcion de disparo derecha o izquierda
								if (o.custom.dir!="0"){
									e.flipX = true;//derecha
								}
								
								//e.SetRotation(o.angle);
								enemys.add(e);
								atacks.add(e.atacks);
								
						case "omnishot":
								var e = new Enemy(x, y);
								e.define_enemy(2);
								e.set_player(player);
								
								/*
								if (o.custom.dir!=""){
									e.flipX = true;
								}*/
								
								enemys.add(e);
								atacks.add(e.atacks);
						//caminantes
						
						case "seeker":
							var e = new Enemy_walker(x, y);
							e.define_enemy(0);
							e.set_player(player);
							e.set_level(level);
							enemys.add(e);
								//add(e.sprite);//sprite para pruevas de ai
							
							atacks.add(e.atacks);
							
						case "roller":
							var e = new Enemy_walker(x, y);
							e.define_enemy(1);
							e.set_player(player);
							e.set_level(level);
							enemys.add(e);
							//add(e.sprite);//sprite para pruevas de ai
							
							
						//voladores
						
						case "sunmask":
							
							var e = new Enemy_fly(x, y);
							e.define_enemy(0);
							e.set_player(player);
							enemys.add(e);
							
						case "cloud":
							
							var e = new Enemy_fly(x, y);
							e.set_player(player);	
							e.define_enemy(1);
							atacks.add(e.atacks);
							enemys.add(e);
						
							
						
						//saltadores
						//slime
						case "jump":
							{
								var e:Enemy = new Enemy_jumper(x, y);
								e.set_player(player);
								e.define_enemy(0);
								enemys.add(e);
							}
						//robot avasa satando y dispara
						case "jumprobo":
							var e = new Enemy_jumper(x, y);
							e.set_player(player);
							e.define_enemy(1);
							enemys.add(e);
							atacks.add(e.atacks);
						//robo no avansa dispara
						case "jrobo":
							var e = new Enemy_jumper(x, y);
							e.set_player(player);
							e.define_enemy(2);
							enemys.add(e);
							atacks.add(e.atacks);
							
						//carga De items
						//recupera salud
						case "health":
							var obj_load = new Item(x, y, 0, false);
							items.add(obj_load);
						//buff Defensa
						case "shield":
							var obj_load = new Item(x, y, 1, false);
							items.add(obj_load);
						//buff Ataque	
						case "power":
							var obj_load = new Item(x, y, 2, false);
							items.add(obj_load);
							
						//carga  de plataformas
						//platafroma movible
						case "plataforma":
							var dirRange:Int;
							var dir:Int = Std.parseInt(o.custom.dir);
							var TIPE:Int= Std.parseInt(o.custom.TIPE);
							var LMTTIPE:Int= Std.parseInt(o.custom.LMTTIPE);
							
							if (dir==0){
								//horizontal
								dirRange = o.width;
							}else{
								//vertical
								dirRange = o.height;
							}
							//FlxG.log.add("d: " + dir + " Tipe: " + TIPE+" LMTIPE: " + LMTTIPE);
							var p = new Platform(x, y,dirRange,dir,TIPE,LMTTIPE);
							plataformas.add(p);
						/**
						case "horizontal":
							var p = new Platform(x, y,o.width, 0);
							plataformas.add(p);
							
						case "vertical":
							var p = new Platform(x, y,o.height, 1);
							plataformas.add(p);
							// plataformas de contacto
						case "contact_h":
							var p = new Platform(x, y,o.width, 0,1);
							plataformas.add(p);	
							
						case "contact_v":
							var p = new Platform(x, y,o.height, 1,1);
							plataformas.add(p);
						
						case "contact_hl":
							var p = new Platform(x, y,o.width, 0,1,1);
							plataformas.add(p);	
							
						case "contact_vl":
							var p = new Platform(x, y,o.height, 1,1,1);
							plataformas.add(p);
						**/	
						//piso falso
						case "fall":
							//FlxG.log.add(o.custom.tile);
							var p = new FallPanel(x, y, Std.parseInt(o.custom.tile));
							plataformas.add(p);
						//resorte , muelle, etc
						case "spring":
							var p = new Spring(x, y);
							plataformas.add(p);
							
						//carga de trampas
						//espinas
						case "needle":
							var n:Trap;
							//rellena el area del objeto con trampas de espinas
							for (i in 0...Math.round(o.width/32)){
								n = new Trap(x + i * 32,y, 0);
								traps.add(n);
							}
						//trampa de fuego	
						case "fire_trap":
								var n:Trap;
								n = new Trap(x,y, 1);
								traps.add(n);
							
							
						
				}
			}
		}
			
		add(plataformas);//añade platadormas
		
		add(player);//añade el nivel a la escena;
		atacks.add(player.atacks);
		//setea el ultimo nivel para futuras com
		Reg.last_level = Reg.act_level;
		add(items);
		add(doors);
		add(enemys);// añade el nivel a la escena;
		add(atacks);
		add(traps);
		//color de fondo
		//bgColor= 0x000000;
		
		
		//FlxG.camera.follow(player,FlxCamera.STYLE_PLATFORMER);
		//FlxG.camera.setBounds(0, 0, level.width, level.height, true);	
		FlxG.camera.set_camera(player.camera);
	}
	
	/*
	 * Carga desde un save si se activo un checkpoint
	 * Aclaracion: la informacion cargada no persiste al cerrar el juego
	 * */
	public function LoadFromSave() {
		
		//bgColor = FlxColor.BLUE;
		Reg.save.close();
			player = new Player(0, 0);
			items = new FlxGroup();
			enemys = new FlxGroup();
			atacks = new FlxGroup();
			plataformas = new FlxGroup();
			traps = new FlxGroup();
			doors = new FlxGroup();
			level = new FlxTilemap();
		
			//Reg.save= new FlxSave();
			
			Reg.save.bind(Reg.save_name);
			Reg.act_level = Reg.save.data.level_name;
			Reg.level_title = Reg.save.data.level_title;
			Reg.life = Reg.save.data.playerlife;
			//carga el nivel
			
			LoadLevel();
			//bgColor = FlxColor.BLUE;
			//FlxG.log.add("loadFromSave");
			//pisiona al jugador en la save terminal(checkpoint)
			//solo se salvan vida y posicion del jugador
			//var pos:FlxPoint = Reg.save.data.playerPos;
			
			player.x = Reg.save.data.playerPos.x;
			player.y = Reg.save.data.playerPos.y;
			player.set_life();
			
			//FlxG.log.add("px " + Reg.save.data.playerPos.x + "  py " + Reg.save.data.playerPos.y);
		
			Reg.IsLoad = false;//evita que se vuelva a cargar desde el punto de guardado al colicionar con una puerta
	//		Reg.save.close();
	}
	
	public function overlap_p_atk(ThePlayer:Player, TheAtk:Atack) {
		if(TheAtk.id==1 && TheAtk.getDie()==false){//cheque si el ataque pertenence al enemigo
			if(player.collition_atk(TheAtk)==false){//chequea si el personaje se esta cubriendo con el escudo
				TheAtk.kill();
			}
		}
	}
	
	public function overlap_p_enemys(ThePlayer:Player,TheEnemy:Enemy){
		if(TheEnemy.onTween==false){
			ThePlayer.collition_Enemy(TheEnemy);
		}
	}
		
	public function overlap_p_traps(ThePlayer:Player, TheTrap:Trap) {
		ThePlayer.collition_Trap(TheTrap);
		
	}
	//colicion enemigo ataque 
	public function overlap_e_atk(TheEnemy:Enemy, TheAtk:Atack) {
		if (TheEnemy.onTween==false){//chequea tween
			if(TheAtk.id==0 && TheAtk.getDie()==false){//chequea si el ataque es del jugaode
				if (TheEnemy.collition_atk(TheAtk.collition())){//recibe el draño
					//suelta un item(segun la probabiliadad)
					var rand = FlxRandom.intRanged(0, 100);
					if (rand > 60) {//60% de probabilidad de que no suelte un item
						if (rand >=80 ){
							if (rand >= 90) {
								//10% de probabilidad de soltar item curativo def+
							
							var new_item = new Item(TheEnemy.x, TheEnemy.y, 1, true);
								items.add(new_item);
							}
							else{
								//10% de probabilidad de soltar item curativo atk+								
								
								var new_item = new Item(TheEnemy.x, TheEnemy.y, 2, true);
								items.add(new_item);
							}
						}
						
						else {
							//20% de probabilidad de soltar item curativo
							
							var new_item = new Item(TheEnemy.x, TheEnemy.y, 0, true);
							items.add(new_item);
						
						}
						
					}
					TheEnemy.kill();
				}
				TheAtk.kill();
			}
		}
	}
	
	//colicion jugador con item
	public function overlap_items(ThePlayer:Player,TheItem:Item){
		
		ThePlayer.collition_item(TheItem.get_id());
		TheItem.kill();
	}
	
	//colicion jugador con puertas
	public function overlap_doors(ThePlayer:Player, TheDoor:Door) {
		
		Reg.act_level = TheDoor.level_string();
		Reg.life = player.life;
		Reg.weapon = player.get_weapon();
		Reg.buff = player.get_buff();
		Reg.buff_time = player.get_buff_time();
		//cambia a un 
		FlxG.switchState(new PlayState());
		
		
	}
	
	//colicion jugador con plataformas piso falso resorte
	public function overlap_plataform(ThePlayer:Player, ThePlatform:Platform) {
		
		ThePlayer.collition_platfrom(ThePlatform);
	}
	
	//colicion jugador con save_terminal
	public function overlap_save(ThePlayer:Player, TheSave:Save_terminal) {
		TheSave.collition_player();
	}
	//colicion ataqes con el nivel
	public function overlap_level_atk(TheLevel:FlxTilemap, TheAtk:Atack) {
		//para que no se reprodusca el sonido de destrucion de la balas
		TheAtk.NoPlayDeadSound();
		TheAtk.kill();
		
	}
	//colicion 
	
	public function overlap_level_item(TheLevel:FlxTilemap, TheItem:Item) {
		TheItem.LevelCollition();//inicia el contador para que desaparesca el item
	}
	
	
	
}	