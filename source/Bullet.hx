package;

import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import openfl.geom.ColorTransform;

/**
 * ...
 * @author ...Santiago Arrieta
 * Bala
 * Ataque visible on variantes
 * Puede desplasarse
 * Causa daño a los enemigos o al jugador segun quien las dispare o si rebotaron
 */
class Bullet extends  Atack
{
	
	private var speed:Float;
	
	private var speedx:Float;
	
	private var speedy:Float;
	public var b_type:Int;
	
	
	override public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		loadGraphic("assets/images/proto_bullets.png", true, 32, 32, false);
		
	}
	
	public function reset_bullet(X:Float, Y:Float,time:Float=2.0,Damage:Int=10,Dir:Int=0,Speed:Float=100,type:Int=0,REBOTE:Bool=true) 
	{
		super.reset(x, y);
		TIME = time;
		b_type = type;
		reset_atk(X, Y, 0,0, time, Damage);
		
		PlayDeadSound = true;
		speed = Speed;
		visible = true;
		rebote = REBOTE;
		colorTransform = new ColorTransform(1.0, 1.0, 1.0, 1.0);
		updateHitbox();
		switch(b_type){
			case 0: //solo derecha o izquierda
				if (Dir == 0) { 
					velocity.x = speed;
					speedx = speed;
					
				} 
				else 
				{
					velocity.x = -speed;
					speedx = -speed;
					
				} 
				speedy = 0;
					
		
			case 1: //direcion segun el angulo
				speedx = Math.cos(Dir * FlxAngle.TO_RAD) * speed;
				speedy = Math.sin(Dir*FlxAngle.TO_RAD)*speed;
				velocity.x = speedx;
				velocity.y = speedy;
				
				
		}
		set_img(b_type);
		
		
	}
	
	
	
	override public function set_img(img:Int){
		
		loadGraphic("assets/images/proto_bullets.png", true, 32, 32, false);
		switch(img){
			case 0:
				animation.add("play", [0], 0, false);
				width = 24;
				height = 16;
				offset.x =4;
				offset.y = 8;
			case 1:
				animation.add("play", [2], 0, false);
				width = 16;
				height = 16;
				offset.x =8;
				offset.y = 8;
				
		}
		animation.play("play");
	}
	override public function rebote_dir(): Void {
		velocity.x = -speedx*1.5;
		velocity.y = -speedy*1.5;
		
		TIME = 1.4;
	}
}