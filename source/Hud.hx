package;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.debug.ConsoleCommands;
import flixel.text.FlxText;
import flixel.util.FlxColor;
/**
 * ...
 * @author Santiago Arrieta
 * Hud
 * Menu grafico superior
 * Muestra informacion del jugador(vida, arma actual y buff)
 */
class Hud extends FlxTypedGroup<FlxSprite>
{
	private var back_rect:FlxSprite;// fondo el gui
	private var lifebar:FlxSprite;//dibuja la vida
	private var weapon:FlxSprite; //arma actual 
	private var buff:Array<FlxSprite>=[null,null]; //buff actual 
	
	var player:Player;
	var boss:Boss;
	//las siguientes varibles solo se utilisan en un combate con un jefe
	private var b_lifebar:FlxSprite;//dibuja la vida del jefe 
	public var boss_text:FlxText;
	public function new(P:Player, BOSS:Boss = null) 
	{
		super();
		player = P;
		
		weapon = new FlxSprite(0,0);
		weapon.loadGraphic("assets/images/Proto_menu_weapon.png", false, 16, 16, false);
		weapon.animation.add("fist", [0], 0, false);
		weapon.animation.add("gun", [1], 0, false);
		weapon.x = 2;
		weapon.y = 8;
		weapon.scrollFactor.x = 0;
		
		weapon.scrollFactor.y = 0;
		
		back_rect = new FlxSprite(0,0);
		back_rect.makeGraphic(FlxG.camera.width, 48, FlxColor.ROYAL_BLUE, false);
		back_rect.scrollFactor.x = 0;
		back_rect.scrollFactor.y = 0;
		add(back_rect);
		
		var back_lifebar = new FlxSprite(weapon.x +2 + weapon.width, weapon.y);
		back_lifebar.makeGraphic(Std.int(FlxG.camera.width*0.80), 16, FlxColor.RED, false);//
		back_lifebar.scrollFactor.x = 0;
		back_lifebar.scrollFactor.y = 0;
		add(back_lifebar);
		
		lifebar = new FlxSprite(weapon.x +2+ weapon.width,weapon.y);
		lifebar.scrollFactor.x = 0;
		lifebar.scrollFactor.y = 0;
		add(lifebar);
		
		
		for (i in 0...2) {
			//muestra items buff
			buff[i] = new FlxSprite(weapon.x+20*i,weapon.y+weapon.height+4);	
			buff[i].loadGraphic("assets/images/proto_basic_item.png", false, 16, 16,true);
			buff[i].animation.add("play", [1+i], 0, false);
			buff[i].animation.play("play");
			buff[i].origin.x = 16 + 16 * i;
			
			buff[i].scrollFactor.x = 0;
			buff[i].scrollFactor.y = 0;
			add(buff[i]);
		}
		
		add(weapon);
		
		//
		boss = BOSS;
		if (boss != null){
			
			
			var b_back_lifebar = new FlxSprite(Std.int(FlxG.camera.width-FlxG.camera.width*0.60)-6, lifebar.y+18);
			b_back_lifebar.makeGraphic(Std.int(FlxG.camera.width*0.60)+4, 20, 0xff003333, false);//
			
			b_back_lifebar.scrollFactor.x = 0;
			b_back_lifebar.scrollFactor.y = 0;
			add(b_back_lifebar);
			
			b_lifebar = new FlxSprite(Std.int(FlxG.camera.width - FlxG.camera.width * 0.60)-2, lifebar.y+20);
			b_lifebar.scrollFactor.x = 0;
			b_lifebar.scrollFactor.y = 0;
			add(b_lifebar);
			boss_text = new FlxText(FlxG.camera.width-8, b_back_lifebar.y, 0, "BOSS", 16);
			boss_text.color = FlxColor.YELLOW;
			boss_text.x = FlxG.camera.width - boss_text.width-8;
			boss_text.alignment = "right";
			boss_text.scrollFactor.x = 0;
			boss_text.scrollFactor.y = 0;
			add(boss_text);
			
		}
		
	}
	
	override public function update():Void 
	{
		
		super.update();
		
		// redibuja la barra de vida segun la vida del jugador
		var life = player.get_life();
		lifebar.makeGraphic(Std.int(FlxG.camera.width * 0.80 * life), 16, FlxColor.GREEN, false);//
		
		
		//dibuja el arma actual del jugador
		switch(player.get_weapon()) {
				case 0:
				weapon.animation.play("fist");
				case 1:
				weapon.animation.play("gun");
		}
		//chequea los buff y dibuja el item debuff activo en la barra
		for (i in 0...2){
			if(player.buff[i]==true){
				buff[i].visible = true;	
			}
			else{
				buff[i].visible = false;
			}
		}
		
		if (boss != null){
			var b_life = boss.GetLifePorcent();
			b_lifebar.makeGraphic(Std.int(FlxG.camera.width * 0.60 * b_life), 16, 0xff990000, false);//
			b_lifebar.x = Std.int(FlxG.camera.width-FlxG.camera.width * 0.60 * b_life)-2;
		}
	}
	
}