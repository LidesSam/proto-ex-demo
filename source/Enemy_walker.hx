package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;

/**
 * ...
 * @author Santiago Arrieta
 * Enemgos cominantes
 * no saltan poseen un desplasamiento similar al del jugador
 * Les afecta la gravedad
 * Seeke suige al jugador y dispara
 * Roller detecta limites y paredes si el jugador esta en rango acelera
 * 
 */
class Enemy_walker extends Enemy
{
	
	override public function new(X:Float, Y:Float)
	{
		super(X,Y);
		tipe = 1;
		velocity.y = 200;
		r_coulddown = 0;
		loadGraphic("assets/images/proto_e_walk.png", true, 32, 32, false);
		flipX = false;
	}
	
	override public function define_enemy(ID:Int) // define al enemigo, animacion disparos ,etc
	{
		
		onTween = false;
		tipe = 1;
		retroSpeed = -1;
		RetroTime = 0.5;
		id = ID;
		switch(id) {
			
			//seeker
			//se mueve acia el jugaodr y dispara
			case 0:
				animation.add("play", [2], 16,false);
				range = 200.0;
				shots = 3;
				speed = 96;
				contact_dmg = 10;
				shot_coulddown = 1.0;
				rafaga_time = 0.5;
				contact_dmg= 2;
				atk_dmg = 18;
				height = 24;
				offset.y = 4;
				life = 50;
			//roller
			//cuando el jugador esta en  la posision y duplica su velocidad
			//en lugar de retroceder cambia de direccion
			case 1:
				animation.add("play", [0 , 1], 5,true);
				range = 250.0;
				shots = 0;
				//speed = 96;
				speed = 200;
				contact_dmg= 15;
				//atk_dmg = 20;
				height = 28;
				offset.y = 2;
				life = 40;
		}
		
		width = 28;
		offset.x = 2;
		x += 6;
		
		coulddown = shot_coulddown;
		velocity.y = 300;
		velocity.x = speed;
		animation.play("play");
		flipX = true;
		dir = 1;
		sprite = new FlxSprite(0, 0);
		sprite.makeGraphic(32, 32, FlxColor.RED);
		//sprite para ver la posiion del tile que chequea (agreagar o queitar desde loadlevel(Playstate);
		//speed = 10;
		tipe = 1;
	}	
	
	
	override public function Actions():Void 
	{
		//super.update();
		
			velocity.y = 300;
		
			var tilex:Int;	
			if(dir==0){
				tilex = Std.int(x / 32);
				flipX = false;
				velocity.x = -speed;
			}
			else{
				tilex = Std.int((x + width) / 32);
				flipX = true;
				
				velocity.x = speed;
			}
			var tiley = Std.int(y / 32);
			
			//invierte la direccion si el camino esta bloqueado o no hay piso
			if (level.getTile(tilex, tiley + 1) == 0 && id==1)
			{
				Redir();
			}
			else if(level.getTile(tilex, tiley) != 0 ){
				Redir();
			}
			
			
			
			sprite.x = tilex*32;
			sprite.y = tiley * 32;
			if (r_coulddown <= 0) {
			//color = FlxColor.RED;
				if (player_in_y()) {
					
					//si el jugador esta en el rango y en la misma posision y duplica la velocidad de movimiento
						
					if(id==1){
						if (dir == 0) { 
							//izquierda
							velocity.x = -speed * 2;
							flipX = false;
							
						}
						else {
							//derecha
							velocity.x = speed * 2;
							flipX = true;
						}
					}
						
					
					if (id == 0) {
						//este chequeo evita que el enemigo seeker(seguidor), se acerque demaciado al jugador  
						
							//color = FlxColor.BLUE;
							//mira acia la direccion del jugador
							if (player.x + player.width / 2 >x + width / 2) {
								//direccion izquierda, a la derecha del jugador 	
								if (player_in_range(range/4)==false)
								{
									velocity.x = speed;
								}
								else{
									velocity.x = 0;
									
								}
								flipX = true;
								dir = 1;
							}
							else {
								//direccion dercha, a la izquierda del jugador
								if (player_in_range(player.width+4)==false)//evita que se acerque demaciado al jugador
								{
									velocity.x = -speed;
								}
								else{
									velocity.x = 0;
									
								}
								flipX = false;
								dir = 0;
							}
						
						
					}
						
					
				}

				if (player_in_range()){
					if (shots > 0){
							if (coulddown <= 0) {	
								shot();
							}
							else {
							
								act_coulddown();
							}
						
						}
				}
			}
			else{
				r_coulddown -= FlxG.elapsed;
			}
		
	}
	
	private function Redir():Void{
		if (velocity.x < 0) {
				//derecha
				velocity.x = speed;
				flipX = true;
				x += 8;//evita erro de superposicion on el nivel
				dir = 1;
			}
			else {
				//izquierda
				x -= 8;//evita erro de superposicion on el nivel
				velocity.x = -speed;
				flipX = false;
				dir = 0;
			}	
	}
	
	private function player_in_line():Bool {
		if(player_in_range()){
			
		
			if (player.y - 32 <= this.y && player.y >= this.y) {	
				return true;
			}	
			
		}
		return false;
	}
	
	override public function Retroceso():Void
	{
		if (id == 1){
			//enemy roller cambia de direccion
			Redir();
		}else
		{
			super.Retroceso();
		}
	}
		
		
}