package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxRandom;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
/**
 * ...
 * @author Santiago Arrieta
 * Enemigos voladores
 * Se desplan por el aire algunos pueden disparar
 * 
 */
class Enemy_fly extends Enemy
{
	
	private var angle_to_player:Float;
	private var move_coulddown:Float;
	public function new(X:Float, Y:Float)
	{
		
		super(X, Y);
		loadGraphic("assets/images/proto_e_fly.png", true, 32, 32, false);
		flipX = false;
		dir = 0;
		tipe = 1;
		r_coulddown = 0;
		move_coulddown = 1;
		id = 1;
	}
	
	override public function define_enemy(ID:Int) // define al enemigo, animacion disparos ,etc
	{
		tipe = 1;
		onTween = false;
		retroSpeed = -1;
		RetroTime = 0.5;
		id = ID;
		switch(id) {
		//sun_mask	
		// sigue al jugador
			case 0:
			life = 60;
			animation.add("play", [ 0, 1], 16,true);
			shots = 1;
			speed = 150;
			range = 400;
			contact_dmg = 5;
			width = 24;
			height = 24;
			offset.x = 4;
			offset.y = 4;
			//menor tiempo y velocidad para hacer a la mascara mas dinamica
			retroSpeed = 50;
			RetroTime = 0.2;
		
		//cloud_ringer
		//sigue al jugador y dispara
		case 1:
			
			animation.add("play", [2], 16, true);
			width = 24;
			height = 24;
			offset.x = 4;
			offset.y = 4;
			life = 70;
			shots = 3;
			shot_coulddown = 0.2;
			rafaga_time = 3;
			//coulddown = rafaga_time;
			atk_dmg = 10;
			contact_dmg = 0;
			range = 200;
			speed = 32;
			//angle_to_player = FlxAngle.angleBetween(this, player, true);// evita error de direccion en la primer rafaga de disparos
			
			//case 2:
			//makeGraphic(32, 32, FlxColor.GREEN, true);
		}
		move_coulddown = 0;
		coulddown = shot_coulddown;
		animation.play("play");
	}
	
	override public function Actions():Void 
	{
		//super.update();
		
			if (r_coulddown <= 0) {//checquea retroceso
			
				
				if (player_in_range() )
				{
					seek_player();
					if (shots > 0 ){
						
						if (coulddown <= 0) {	
							angle_to_player = FlxAngle.angleBetween(this, player, true);
							shot(angle_to_player,x+width/2,y +height / 2,FlxColor.YELLOW);
						}
						else {
						
							act_coulddown();
						}
					
					}
				
				
				}
				else if (id>0){	
						velocity.y = 0;
						
						velocity.x = 0;
				}
			
			}
			else{
				r_coulddown -= FlxG.elapsed;
			}
		
	}

	
	private function seek_player() {
		angle_to_player = FlxAngle.angleBetween(this, player, true);
		if(move_coulddown<=0){	
				if(player_in_range(32)==false){
					velocity.x = Math.cos(angle_to_player * FlxAngle.TO_RAD) * speed;
					velocity.y = Math.sin(angle_to_player * FlxAngle.TO_RAD) * speed;
					move_coulddown = 0.6;
				}
		}
		else{
			move_coulddown -= FlxG.elapsed;
		}
	}
	
	//private static var t_change_dir:Float;	
	
}