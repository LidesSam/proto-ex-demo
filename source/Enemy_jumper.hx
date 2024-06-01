package;


import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

/**
 * ...
 * @author Santiago Arrieta
 * Enemigos que saltan
 * slime: salta, no dispara
 * robo: salta y dispara
 * jrobo salta y dispara, pero no avansa
 * 
 */
class Enemy_jumper extends Enemy
{

	private var jump_height:Float;//define la altura del salto /velocidad vertical
	private var anim_jump:Bool;
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		tipe = 1;
		acceleration.y = 200;
		jump_height = 128;
		life = 40;
		flipX = false;
		atacks = new FlxTypedGroup<Atack>();
		r_coulddown = 0;
		loadGraphic("assets/images/proto_e_jumper.png", true, 32, 32, false);
	}
	override public function define_enemy(ID:Int) 
	{
		onTween = false;
		tipe = 1;
		retroSpeed = -1;
		RetroTime = 0.5;
		id = ID;
		switch(id) {
			
			//slime: solo salta
			case 0:
				animation.add("stand", [0, 1, 0, 2], 20, true);
				animation.add("jump", [3], 0, false);
				jump_height = 96;
				range = 150.0;
				//shots = 3;
				speed = 100;
				contact_dmg = 5;
				shots = 0;
				width = 24;
				height = 28;
				offset.x = 4;
				offset.y = 2;
				anim_jump = false;
				life = 40;
			//robo salta y disopara rafagas no avansa
			case 1:
				animation.add("stand", [4, 5, 6], 20,false);
				animation.add("jump", [4], 0, false);
				jump_height = 128;
				range = 150.0;
				shots = 1;
				speed = 50;
				shot_coulddown = 2;
				rafaga_time = 0.5;
				contact_dmg = 5;
				atk_dmg = 15;
				width = 24;
				height = 28;
				offset.x += 4;
				life =80;
			//jrobo salta y disopara rafagas no avansa
			case 2:
				life = 50;
				animation.add("stand", [8, 9, 10], 10,false);
				animation.add("jump", [8], 0, false);
				
				jump_height = 256;
				range = 200.0;
				shots = 2;
				speed = 0;
				shot_coulddown = 0.5;
				rafaga_time = 0.8;
				contact_dmg= 5;
				atk_dmg = 5;
				width = 24;
				height = 28;
				offset.x += 4;
		}
		
			coulddown = shot_coulddown;
		animation.play("stand");
	}
	
	override public  function Actions(){
		//super.update();
		
		
		
			if ((wasTouching & FlxObject.FLOOR != 0)) {
				if (anim_jump==false){
					animation.play("stand");
					anim_jump = true;
				}
				
				if (id>0)
				{
					r_coulddown = 1;
					if(animation.finished){
						r_coulddown = 0; 
						anim_jump = false;
						
					}
				}
				else{
					animation.play("stand");
				}	
			}
			else 
			{	
				animation.play("jump");
			}
			
			if (r_coulddown <= 0) {
				//color = FlxColor.RED;
			
				if (player_in_range()) {
				
					if(player.x>x){
						flipX = true;	
						if ((wasTouching & FlxObject.FLOOR != 0)) {
							jump();
							velocity.x = speed;
						}
					}
					else
					{
						flipX = false;
						if ((wasTouching & FlxObject.FLOOR != 0)) {
							jump();
							velocity.x = -speed;
						}
					}	
					
					if (shots >  0) {
					
						if(coulddown <=0){
							shot();
						}
						else 
						{
							act_coulddown();		
						}
					}
				
				}
				else {
					//detiene al personaje
					velocity.x = 0; 
					
				}
			}
			else{
				r_coulddown -= FlxG.elapsed;
			}
		
	}
	
	
	private function jump() {
		y--;	
		velocity.y = -jump_height;
		
	}
}