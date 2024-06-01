package;


import Enemy;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import haxe.unit.TestRunner;
import openfl.geom.ColorTransform;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;

/**
 * ...
 * @author ...
 * jefe del juego
 * se desplasa de arriva hacia y abajo
 * 
 */

class Boss extends Enemy
{
	
	private var current_state:String; //stado Actual
	//stand: stado dode se ejecuta skill update, se mueve y ejecuta disparaos al azar
	//bigShot: carga y ejecuta un disparo grande sigue al jugador(solo en eje y)
	//change: no resive daño estado de transion se encuentra inmovil
	//dmg: reproduce animacion de daño , invulnerable
	// wait:spera 
	
	private var act_anim:String;
	private var state_coulddown:Float;//tiempo entre stado
	private var form:Int;
	private var HalfLife:Int;
	private static var MaxLife:Int = 80;//200;
	
	private var fxsound:FlxSound = new FlxSound();
	private var fxCarga:String = "assets/sounds/Carga.wav";
	private var fxBShot:String = "assets/sounds/BigShot.wav";
	public var drop_item:FlxGroup;
	public var drop_enemy:FlxGroup;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
			atacks = new FlxTypedGroup<Dynamic>();
			/*coulddown = 2.0;
			speed = 64;
			velocity.y = speed;
			loadGraphic("assets/images/me_sheet.png", true, 48, 48, false);
			animation.add("stand1", [0, 1], 2, true);
			animation.add("dmg1", [0, 1, 2], 30, true);
			animation.add("stand2", [3,4], 2, true);
			animation.add("dmg2", [5,4,3], 30, true);
			animation.add("change", [0, 1, 2,5,4,3],10,false);
			
			form = 1;
			act_anim = "stand1";
			current_state ="Stand";
			state_coulddown = 1.0;
			//FlxG.log.add(current_state);
			drop_item = new FlxGroup();
			drop_enemy = new FlxGroup();
			contact_dmg = 10;
			*/
			define_enemy(0);
	}
	
	override public function define_enemy(TYPE:Int) 
	{
			coulddown = 2.0;
			speed = 64;
			velocity.y = speed;
			contact_dmg = 10;
			loadGraphic("assets/images/me_sheet.png", true, 48, 48, false);
			animation.add("stand1", [0, 1], 2, true);
			animation.add("dmg1", [0, 1, 2], 30, true);
			animation.add("stand2", [3,4], 10, true);
			animation.add("dmg2", [5,4,3], 30, true);
			
			animation.add("change", [0, 1, 2,5,4,3], 5, false);
			form = 1;
			act_anim = "stand1";
			current_state ="Stand";
			//current_state = "BigShot";
			//state_coulddown = 0;
			//FlxG.log.add(current_state);
			offset.x = 4;
			
			life = MaxLife;
			HalfLife = Std.int( MaxLife / 2);
			
			state_coulddown = 1.0;
			//FlxG.log.add(current_state);
			drop_item = new FlxGroup();
			drop_enemy = new FlxGroup();
			
	}
	
	//comportamiento del jefe
	override public function Actions():Void {
		//maneja el tiempo dentro del estado
		if (coulddown <= 0) 
		{
			//ejecuta accion del estao por medio de la duncion state
			state();
			//skill_update(); 
		}
		else
		{
			
			coulddown -= FlxG.elapsed;
		}
		
		//maneja el tiempo entre estados
		if (state_coulddown  <= 0) 
		{
			//cambia el estado
			ChangeState();
		}
		else
		{
			
			state_coulddown -= FlxG.elapsed;
		}
	
		//en los siguientes dos casos se maneja la velocidad segun la forma(Duplica la velocidad vertical en la segunda forma) 
		//detecta el piso y cambia su direcion acia arriba
		if ((wasTouching & FlxObject.FLOOR != 0)  ) {
				if(current_state !="Change" && current_state !="Wait"){
					velocity.y = -speed*form;
				}
				
		}
			
		
		//detecta el techo y camvia su direcion acia abajo
		if((wasTouching & FlxObject.UP !=0)){
			if(current_state !="Change" && current_state !="Wait"){
				velocity.y = speed*form;
			}
			
		}
		
		if (life <= HalfLife && current_state !="Change" && form!=2 ) { ChangeState("Change"); }
		animation.play(act_anim);
	}
	
	private function tri_trishot(atk_x:Float, atk_y:Float) {
		//tres disparos en angulo
		var angle:Int;
		var dmg = 10;
		for(i in 0...3 ){
			angle = 135 + 45 * i;	
				var newbullet = atacks.recycle(Bullet);
				newbullet.reset_bullet(atk_x, atk_y, 1.0, dmg ,angle, 250, 1);
				newbullet.set_id(1);
		}	
		coulddown = 1.0;
	}
	
	private function big_shot(atk_x:Float, atk_y:Float,?big:Bool=false) { 
		var dmg= 15;
		var newbullet:Bullet = atacks.recycle(Bullet);
		//FlxG.log.add("big_shot_ n");
		
		//Big = true;
		if (big == true) {
			//para el sonido de carga
			dmg = 40;
			fxsound.stop();
			//reproduce el sonido de disparo
			playFX(fxBShot);
			newbullet.reset_bullet(atk_x, atk_y, 4.0, dmg , 1, 300, 0);	
			newbullet.set_id(1);
			
			
			
			//newbullet.colorTransform = new ColorTransform(5.0, 0.0, 1.0, 1.0);
			
			newbullet.scale.x = 4;
			newbullet.scale.y = 3;
			
			//actualisa el tamaño del hitbo
			newbullet.updateHitbox();
			newbullet.width = 96;
			newbullet.x = x - 2;
			//newbullet.offset.x = 8;
			
			//FlxG.log.add("Wid: "+ newbullet.width+" BX "+newbullet.x+" x "+x);
			newbullet.y -=newbullet.height/2; 
			//evita que el bigshot rebote
			newbullet.rebote = false;
		}
		else{
			newbullet.reset_bullet(atk_x, atk_y, 3.0, dmg , 1, 250, 0);	
			newbullet.set_id(1);
		}
		coulddown = 1.0;
	}
	

	private function state():Void{
		switch(current_state){
			case "Stand": 
				skill_update();
				if (velocity.y == 0)
				{
				var r:Int = Std.random(2);
					if (r==0){
							velocity.y = speed * form;
					}
					else{
						velocity.y = -speed * form;
					}
				}
			case "BigShot": 
				if (seek_player()) {
					//FlxG.log.add("is a big shot");
					big_shot(x-2,y+height/2,true);//disparo grande
					ChangeState("Stand");
				}
		
			case "Wait"://espera
				
			case "Change":
				
				if (animation.finished) {
					//FlxG.log.add("INCHANGE");
					ChangeState();
				}
			default:
				current_state="stand";	
		}	
	}
	
	//maneja los cambios de estado el enemigo
	private function ChangeState(?state:String=null):Void{
			
		if(state!=null){
				current_state = state;
		}
		else {
			var alState = Std.random(2);
			switch(alState){
				case 0:
					current_state = "Stand";
					
				case 1:
					current_state = "BigShot";
					
				default:
					current_state = "Stand";
			}
				
			
		}
			//current_state = FlxRandom.intRanged(0, 1);
			
		//define el tiempo en que se mantiene el estado, la animasion segun la forma
			
		switch(current_state){
			case "Stand": 
				state_coulddown = Std.random(3) + 1;
				act_anim = "stand" + form;
			case "BigShot": 
				playFX(fxCarga,true);
				state_coulddown = Std.random(3)+1;
			
			case "Wait"://espera
				velocity.y = 0;
				act_anim = "dmg" + form;
				state_coulddown = 0.2;
				Item_Drop();
				Enemy_Drop();
			case "Change":
					//aumenta la velocidad y cambia las animaciones
					velocity.y = 0;
					act_anim = "change";
					form = 2;
					speed = 192;
					state_coulddown = 20; 
		}	
			state_coulddown = FlxRandom.intRanged(2, 8);
			//FlxG.log.add(current_state +" anim: "+ act_anim);
		
	}
	
	//collicion con ataque
	override public function collition_atk(dmg:Int):Bool{ 
		if(current_state !="Change" && current_state !="Wait"){
			life-= dmg;
			fxsound.stop();
			ChangeState( "Wait");
			
			if(life<0){
				return true;
			}
		}
		return false;
		
	}
	
	//busca al jugador 
	private function seek_player():Bool{
		var y_check = y + height / 2;
		
		if (y_check>=player.y-16 && y_check <=player.y+height+16){//rango mas amplio que la altura del jugador
			return true;
		}
		else{
			if (y_check <= player.y + player._halfHeight)
			{
				velocity.y = speed; 
				
			}
			else 
			{
				velocity.y = -speed; 
			}
		}
		return false;
		
	}
	
	private function skill_update():Void {
		var act:Int=0;
		if (form == 1){
			FlxRandom.intRanged(1, 100);
		}
		else{
			FlxRandom.intRanged(0, 200);	
		}
		
		
		if( act<=50){
			big_shot(x,y+height/2);
		}
		else if (act <= 100){
			//tri shot
			//3 disparos en angulo
			tri_trishot(x, y + height / 2);
			
		}
		else if(act<=150){
			//muti tri shot
			//  nueve disparos en 3 angulos
			tri_trishot(x,y);
			tri_trishot(x,y+height/2);
			tri_trishot(x, y + height);
			
			
		}
		else{
			//rafaga de 6 disparos
			//2 lineas de 3
			big_shot(x+width/2,y);
			big_shot(x+width/2,y+height);
		
			big_shot(x,y);
			big_shot(x,y+height);
		
		
			big_shot(x-width/2,y);
			big_shot(x-width/2,y+height);
		
		
		}
	}
	
	private function playFX(SoundPath:String, loop:Bool = false):Void{
		
		fxsound.loadEmbedded(SoundPath, loop);
		fxsound.volume = 0.7;
		fxsound.play();
	}
	
	override  public function onTweenEnd(tween: FlxTween)
    {
		fxsound.stop();
		Reg.boss_defeat = true;
        super.onTweenEnd(tween);
		
    }
	
	private function Item_Drop():Void {
		var r:Int = Std.random(100);
		if (r > 90){//
			var item = new Item(x , y, 0, true);
			item.x -= item.width+4;
			drop_item.add(item);
		}	
		else if (r>80){
			var item = new Item(x , y, 1, true);
			item.x -= item.width+4;
			drop_item.add(item);
			
		}
		else if (r<70){
			var item = new Item(x , y, 2, true);
			item.x -= item.width+4;
			drop_item.add(item);
			
		}
		
	}
	
	private function Enemy_Drop():Void {
		var r:Int = Std.random(100);
		if (form==2){
			r = Std.random(80) + 20;
		}
		var rand = Std.random(3);
		//limita la cantidad de enemigos a 3
		if (drop_enemy.countLiving() < 3){
			//FlxG.log.add("e:count: " + drop_enemy.countLiving());
			if (r > 95){//slime
				var e:Enemy = new Enemy_jumper(x - 16, 160);
				e.set_player(player);
				e.define_enemy(0);
				e.x -= e.width;
				
					e.x -= e.width+48+96*rand ;
				drop_enemy.add(e);
				
			}
			else if(r>70)
			{//cloud
				
					var e = new Enemy_fly(x-16, 160);
					e.set_player(player);	
					e.define_enemy(1);
					atacks.add(e.atacks);
					e.x -= e.width+48+96*rand ;
					drop_enemy.add(e);
			}
			
			//FlxG.log.add("e add count: " + drop_enemy.countLiving());
		}
	}
		
	override public function destroy() 
	{
		//evita que se siguan reproduciendo sonidos con loop
		fxsound.stop();
		super.destroy();
		//FlxG.log.add("Destroy");
	}

	public function GetLifePorcent():Float
	{
		return life/MaxLife;
	}
}