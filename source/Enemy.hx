package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxAngle;
import flixel.system.FlxSound;
/**
 * ...
 * @author Santiago Arrieta
 * Enemigos staticos
 * Funcionan como torretas
 * Tambien se utiliza como base para las demas clases de enemigos
 */
class Enemy  extends FlxSprite
{
	private var player:Player;
	
	private var level:FlxTilemap;
	private var life:Int;//vida
	private var armor:Int;//defensa
	private var shots:Int;//numero de disparos por rafaga
	private var shot_coulddown:Float;//tiempo entre cada disparo de la rafaga
	private var shot_current:Float; //numero de disparo acrual en la rafaga
	
	private var contact_dmg:Int;
	private var atk_dmg:Int;
	private var rafaga_time:Float;// tiempo entre rafagas
	private var coulddown:Float;// frecuencia de ataque
	
	private var r_coulddown:Float;// Retroseso
	
	// se utilisa para alterar la velocidad de retroceso por defecto(en lugar devarible speed del enemigo)
	private var retroSpeed:Float;
	private var RetroTime:Float;// tiempo entre rafagas
	
	
	private var range:Float;// distancia rspecto al jugador
	private var id:Int; 
	
	private var speed:Float;
	public var atacks(default, null): FlxTypedGroup<Dynamic>;
	private var dir:Int;
	public var tipe:Int;//se utilisa para diferenciar enemigos sin retroceso
	
	//variables para tween
	public var onTween:Bool;
	private var volum:Float;
	
	
	public var sprite:FlxSprite;//sprite para realisar comprobaciones
	
	private var omni:Bool = false;
	var fxdead:FlxSound;
	public function new(X:Float,Y:Float) 
	{
		fxdead = new FlxSound();
		fxdead.loadEmbedded("assets/sounds/jam.mp3", true);
		fxdead.volume= 0.5;
		super(X, Y);
		id = 0;
		//makeGraphic(128, 128, FlxColor.GREEN, true );
		atacks = new FlxTypedGroup<Dynamic>();
		loadGraphic("assets/images/static_enemy.png", true, 32, 32, false);
		tipe = 0;
		shot_current = 0;
		r_coulddown = 0;
		rafaga_time = 2;
		RetroTime = 0.5;
	}
	
	public function collition_atk(dmg:Int):Bool{ 
		life-= dmg;
		if(life<0){
			return true;
		}
		if (tipe!=0){//si no es un enemigo estatico retrocede
			Retroceso();
		}
		return false;
		
	}
	public function SetRotation(Angle:Float){
		angle = Angle;
	}
	
	 public function set_level(LEVEL:FlxTilemap) {
		level = LEVEL; 
		
		}
	
	public function define_enemy(ID:Int)// define al enemigo, animacion disparos ,etc
	{
		tipe = 0;
		onTween = false;
		coulddown = 1.0;
		retroSpeed = -1;
		RetroTime = 0.5;
		id = ID;
		switch(id){
			case 0:
				//Shot
				//dispara un solo disparo
				animation.add("stand", [2], 2,false);
				life = 100;
				range = 600;
				shots = 1;
				shot_coulddown = 1.2;
				contact_dmg= 5;
				atk_dmg = 20;
				
				
			case 1:
				// trishot
				//dispara una rafaga de 3 disparos
				animation.add("stand", [1], 2,false);
				life = 80;
				range = 500.0;
				shots = 3;
				speed = 32;
				shot_coulddown = 0.2;
				contact_dmg = 10;
				rafaga_time = 1.0;
				atk_dmg = 10;
				
			case 2:
				// omni_shot
				//dispara en cuatro direciones
				omni = true;
				animation.add("stand", [0], 2,false);
				life = 60;
				range = 500.0;
				shots = 1;
				speed = 32;
				shot_coulddown = 1.0;
				contact_dmg= 10;
				atk_dmg = 10;
				rafaga_time = 10;
		}
		
		velocity.y = 0;
		coulddown = shot_coulddown;
		animation.play("stand");
		
	}
	 
	 override  public function update(): Void {
		 super.update();
		 //chequea  si esta en camera
		 if  (isOnScreen(FlxG.camera)==false){
			// inmovilisa al enemigo
			velocity.x = 0;
			velocity.y = 0;
			 
		 }
		 //chequea si no esta ejecutando un tween(especificamente muerte)
		 else if (onTween == false)
		 {
			Actions();
		 }
		 else{
			 fxdead.volume = volum;
		 }
	 }
	 
	//comportamiento del enemigo
	 private function Actions():Void{
		// color = FlxColor.BLUE;
		 if(player_in_range()){
			if (shots >  0) {
				if (coulddown <= 0) {
					 if(omni){
					 /*shot(0, x + width, y + height / 2-4); 
					 shot(90, x + width / 2 - 4, y + height);
					 shot(180, x, y + height / 2-4); 
					 shot(270, x + width/2-4, y);
					*/
					 OmniShot();
					 
					}
					else{
						shot();
					}	
				}
				else 
				{
					act_coulddown();	
					
				}	
			}
		} 
		
	}
	 
	public function Retroceso():Void{//mueve hacia atras en contacto
		 //color = FlxColor.BLUE;
		
		
		 var x_with = player.x + player.width / 2;
		 /*chequea la posicion del jugador para la direccion
		  * verifica si hay velocidad de retroceso(retroSpeed)
		  * si hay la asigana segun direccion
		  * sino utilisa la velocidad normal(variavle speed) del enemigo
		  * */
		if(r_coulddown<=0){//evita que el enemigo se quedecontinuamente en retroceso
			if (x >= x_with) { 
				 
				if(retroSpeed!=-1){
					 
					velocity.x = retroSpeed;
				}
				else{
					velocity.x = speed; 
				}
			}
			else
			{ 
				if(retroSpeed!=-1){
					 
					velocity.x = -retroSpeed;
				}
				else{
					velocity.x = -speed; 
				}
			}
			r_coulddown = RetroTime;
			//velocity.y *=-1;
		}
	}
	 
	public function set_player(PLAYER:Player):Void{
		player = PLAYER;
		
	}
	
    //devuenlve verdadero si el jugador esta a cierta distacia
	private function player_in_range(RANGE:Float=null):Bool {
		var dist:Float = range;
		if (RANGE != null){
			//util para ciertas ai
			dist = RANGE;
		}
		if(FlxMath.distanceBetween(this,player)<dist){

			return true;
		}
		//return true;
		return false;	
	}
	
	public function GetLife():Int { return life; }
	
	public function SetLife(LIFE:Int):Void { life=LIFE; }
	
	public function GetTipe():Int { return tipe; }
	/*
	private function hit():Void {
		var atk_x:Float;
		var atk_y = y;
		//crea la bala
			if(flipX==true){
				atk_x = x;
				dir = 0;
			}
			else{
				atk_x = x+width;
				dir = 1;
			}
		
		
	}*/
	
	public function getDmg():Int { return contact_dmg; }
	
	private function shot(?Angle:Float = null, ?X:Float = 0, ?Y:Float = 0, ?COLOR:Int = null):Void {
		var atk_x:Float;
		var atk_y = y+_halfHeight-8;
		var bdir:Int;
		var bulletipe:Int =0;
		//crea la bala 
		//color = FlxColor.RED;
		if(Angle!=null){
			atk_x = X;
			atk_y = Y;
			bdir = Math.round( Angle);
			bulletipe = 1 ;
		}
		else {
			
			if(flipX==true){
				atk_x = x+width;
				bdir = 0;
			}
				
			else{
				atk_x = x;
				bdir = 1;
			}
			
		}	
		var newbullet:Bullet = atacks.recycle(Bullet);
		newbullet.reset(atk_x, atk_y);
		newbullet.reset_bullet(atk_x, atk_y, 2.0, atk_dmg, bdir, 250, bulletipe);
		
		newbullet.set_img(1);//evita error al reciclar balas del jugador
		if(COLOR!=null){
			newbullet.color = COLOR;
		}
		newbullet.set_id(1);
		//newbullet.setLevel(level);
		act_shot_coulddown();
		
		
		
	}

	
	private function player_in_y():Bool{//si el jugador esta en la misma linea vertical
		
		if (player.y - 32 <= this.y+48 && player.y >= this.y-16) {	
				return true;
			}	
			
		return false;
		
	}
	
	private function player_in_x():Bool {//si el jugador esta en la misma linea  horizontal
		if (player.x - 32 <= this.x && player.x >= this.x) {	
				return true;
			}	
		return false;
		
	}
	
	private function act_coulddown(){
		coulddown -= FlxG.elapsed;
	}
	
	private function act_shot_coulddown() {
			
		shot_current++;//disparo actual de la rafaga
		if(shot_current==shots){
			if (shots > 1) {
				coulddown = rafaga_time;
			}
			else
			{
				coulddown = shot_coulddown;	
			}
			shot_current = 0;
		}
		else
		{
			
			coulddown = shot_coulddown;
		}
	}
	
	public override function kill()
    {
		//reproduce soniddo de muerte
		fxdead.play();
		volum = 0.5;
        var options = {complete: onTweenEnd, ease: FlxEase.expoOut};
        var tween = FlxTween.tween(this, { y:y - 1, alpha: 0, volum:0 , color: FlxColor.RED }, 1, options);
		
		velocity.y = 0;
		velocity.x = 0;
		acceleration.y = 0;
		acceleration.x = 0;
		onTween = true;
		
		
		
	}

    public function onTweenEnd(tween: FlxTween) {
		fxdead.stop();
        super.kill();
		
    }

	override public function destroy(){
		fxdead.stop();
		//FlxG.log.add("ASsad");
		super.destroy();
	}
	
	private function OmniShot(I_ANGLE:Float=0,SHOTS:Int=4){
		//disapra un determinado numero de disparos desd
		var current_ang:Float = I_ANGLE;
		var ang_per_shot:Int = Std.int(360/SHOTS);
		var centerx:Float = x + width / 2;
		var centery:Float = y + height / 2;
		
		for (i in 0...SHOTS) {
			var atkx = Math.cos(current_ang*FlxAngle.TO_RAD)*width/2;
			var atky = Math.sin(current_ang *FlxAngle.TO_RAD)*height/2;
			
			shot(current_ang, centerx + atkx-8, centery + atky-8);
			current_ang += ang_per_shot;
			if (current_ang>=360){
				current_ang -= 360;
			}
		
			//FlxG.log.add("I:" + i);
		}
		
		
	}
}