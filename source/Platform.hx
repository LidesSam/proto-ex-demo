package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author Santiago Arrieta
 * Plataforma
 * el jugador puede moverse sobre ellas, algunas se activan al contacto con el mismo otras
 * base para los fallpanels, y sping(Resorte o muelle)
 */
class Platform extends FlxSprite
{

	private var dir:Int;
	
	private static inline var speed = 128.0;
	
	private var limit:Array<Float> = [0, 0];
	private var inMove:Bool;//determina si la plataforma se mueve
	private var tipe:Int;//
	private var inBack:Bool;
	private var ltipe:Int;
	public var check:Bool;
	public var selfeffect:Bool = false;//indica si se
	/*
	 frena en
	ltipe=0  el utimo limite
	ltipe=1  limite derecho
	ltipe=2  limite izquierdo
	actualmete
	ltipe= 0 limite izquierdo|up
	ltipe= 1 limite derecho|down
	*/
	public function new(X:Float,Y:Float,Limit:Float=64,Direction:Int=0,Tipe:Int=0,LmtTipe:Int=0) 
	{
		ltipe = LmtTipe;// lado
		ID = 0;
		check = true;
		super(X, Y);
		//makeGraphic(64, 16, FlxColor.MAGENTA, true);
		loadGraphic("assets/images/proto_plataforma.png", true, 64, 16,false);
		animation.add("inactive", [0], 0, false);
		animation.add("active", [1], 0, false);
		animation.add("normal", [2], 0, false);
		dir = Direction;
		animation.play("normal");
		tipe = Tipe;
		inBack = false;
		
		switch(tipe){
			case 0: 
				// plataforma de movimiento automatico	
				//
				inMove = true;
				animation.play("normal");
				
			case 1:
				//tipo 1: solo se mueve cuando el jugador esta sobre esta
				inMove = false;
				animation.play("inactive");
			
			default:
				inMove = true;
				animation.play("normal");
				
		}
		
		if (dir == 0) {
			//horizontales
			limit[0] = X;
			limit[1] = X+Limit-width;
			if(inMove){
				velocity.x = speed; 
			}
			
		}
		else {
			//limites verticales
			limit[0] = Y+Limit-height;
			limit[1] = Y;
			if(inMove){
				velocity.y = -speed;
			}
		}
		
		// modifica la posision inicial
		if (ltipe==1){
			if (dir == 0) { x = limit[1]; }
			else{
					y = limit[0];//coloca plataformas contact dowm en
			}
			
		}
	
		
		//this.immovable = true;
	}
	
	override public function update():Void{
		super.update();
		
		if(dir==0){
			//horizontal
			if(velocity.x>0){
				if (x > limit[1]) {
					x = limit[1];
					if (inMove) {
						inBack = true;	
						velocity.x = -speed; 
						if(tipe==1 && ltipe==1){
							//solo plataforma de contacto
							inMove = false;
						}
					}
				}
			}
			else
			{
				if (x < limit[0]) { 
					x = limit[0];
					if (inMove) {
						inBack = false;
						
						if(tipe==1 && ltipe==0){
							inMove = false;
						}
						velocity.x = speed;
					}	
				}
			}
		}
		else {
			//vertical
			if(velocity.y>0){
				if (y > limit[0]) {
					y = limit[0];
					if (inMove) {
						inBack = true;
						velocity.y = -speed;
						if(tipe==1 && ltipe==1){
							//solo plataforma de contacto
							inMove = false;
						}
					}			
				}
			}
			else
			{
				if (y < limit[1]) { 
					y = limit[1];
					if (inMove) {
						
						inBack = false;
						
						if(tipe==1 && ltipe==0){
							//solo plataforma de contacto
							inMove = false;
						}
						velocity.y = speed;
					}
					
				}
			}
			
		}
		
		if (inMove==false && tipe==1){
			animation.play("inactive");
			velocity.x = 0;
			velocity.y = 0;
		} 
		/*
		if(inMove && tipe==1){
			inMove == false;
			velocity.x = 0;
			velocity.y = 0;
			animation.play("inactive");
		}*/
	
	}
	public function ContacPlayer():Void{
		if(tipe==1){// si es de tipo contacto activa el movimiento
			inMove = true;
			if (dir == 0) {
				if(inBack){
					velocity.x = -speed;
				}else{
					velocity.x = speed;
					
				}
			}
			else {
				if (inBack){
					velocity.y = -speed;
				}else{
					velocity.y = speed;
				}
			}
			animation.play("active");
		}
		
	}
	
	
	
}