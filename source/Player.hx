package;


import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

import flixel.util.loaders.TextureAtlasFrame;

/**Player
 * ...
 * @author algunas se activan al contacto con el mismo
 * Jugador
 * Avatar del jugador
 * Puede:
 * Satar(Doble salto, un sato en el suelo segido de otro en el aire, a exepcion de los spring(Resorte),
 * las plataformas se consideran un suelo mas)
 * Desplasarse: Derecha izquierda;
 * Armas primarias: 
 * 		Puño: golpe a corta distacia(Contacto), gran daño
 * 		Pistola: Larga distancia, poco daño
 * Arma secundaria: 
 * 		Escudo: Rebota balas frontales
 */
class Player extends FlxSprite
{
	private var dir:Int;
	private var max_life:Int;//vida maxima del personaje
	public var life:Int;//vida actual del personaje
	
	private var coulddown:Float;
	private var r_coulddown:Float;
	
	private var in_platform:Bool;
	
	private var weapon:Int;
	private var s_weapon:Int;
	private var finish_anim:Bool;
	private var jump:Int;
	public var shield:Bool;

	public var atacks(default, null): FlxTypedGroup<Dynamic>;
	public  var buff:Array<Bool> = [false,false];
	public static var buff_time:Array<Float> = [0.0,0.0];
	
	private static inline var speed:Float  = 200.0;
	
	private var platform:Platform;
	private var act_anim:String;
	private var NoDmgTime:Float;
	
	private var fxJump:String = "assets/sounds/ProtoJump.wav";
	private var fxHit:String = "assets/sounds/Hit.wav";
	private var fxShot:String = "assets/sounds/Shot2.wav";
	private var fxHurt:String = "assets/sounds/hurt";
	private var fxsound:FlxSound = new FlxSound();
	
	
	
	public function new(X:Float,Y:Float ) 
	{
	
		
		super(X, Y);
		loadGraphic("assets/images/proto_sheets.png", true, 32, 32, false);
		
		animation.add("stand", [18], 0, false);
		animation.add("run", [0,1,2,3,4,5], 15,true);
		animation.add("hit", [6, 7, 8, 9], 20,false);
		
		animation.add("shot", [21,21], 20, false);
		animation.add("fall", [22], 0, false);
		animation.add("jump", [23], 0, false);
		animation.add("shield", [20], 0, false);
		animation.play("stand");
		
		max_life = 100;
		life = max_life;
		acceleration.y = 400;
		height = 28;
		width = 24;
		offset.x = 4;
		offset.y = 2;
		atacks = new FlxTypedGroup <Dynamic>();
		flipX = false;
		dir = 0;
		in_platform = false;
		shield = false;
		jump = 0;
		weapon = 0;
		s_weapon = 0;
		finish_anim = false;
		r_coulddown = 0;
		coulddown = 0;
		NoDmgTime = 0;
		
	}
	
	
	private function Damage(Dmg:Int){
		//controla el daño recivido
		if (NoDmgTime <= 0){
			if (buff[0]){
				life-= Std.int(Dmg*0.60);
			}
			else
			{
				life-= Dmg;
			}
			NoDmgTime = 1.0;
		}
	}

	override public function update(){
		super.update();
		//buff[0] = true;
		//buff[1] = true;
		act_coulddown();
		if(r_coulddown<=0){
			if(finish_anim){
				if (animation.finished) {
					if(weapon==0){
						skill_action(0);
					}
					finish_anim = false;
				}
			}
			else {
				if(FlxG.keys.pressed.RIGHT)
					{	
						if (shield == false) {		
							act_anim = "run";
							velocity.x = speed;
						}
						dir = 0;
						flipX = false;
					}
					else if(FlxG.keys.pressed.LEFT)
						{	
							if(shield==false){
								act_anim = "run";
								velocity.x = -speed;
							}
							flipX = true;
							dir = 1;
							
							
						}
						else
						{
							velocity.x = 0;
							if (shield == false) {
								act_anim = "stand";
							}
					}
				}
			}	
		
			if ((wasTouching & FlxObject.FLOOR != 0)|| in_platform==true) {
				//si se encuentra en contacto con el suelo devuelve la variable de salto a 0
				if (shield) { act_anim = "shield"; }
				jump = 0;
				velocity.y = 0;//
			}
			else {
				if(finish_anim==false){
				//define animaciones de salto y caida	
					if (velocity.y > 0) {
						//evite error en numero de saltos
						if (jump!=2){
							jump = 1;
						}
						
						if (act_anim!="shield"){
							act_anim = "fall";
						}
						
					}
					else {
						if (act_anim!="shield"){
							act_anim = "jump";
						}
						 
						//velocity.y+=100;
					}
				}
			}
		
		
			
		
		
		if(r_coulddown<=0){
			//salto
			if(FlxG.keys.justPressed.C && jump<2)
			{
				if (jump == 0) { velocity.y = 0; }
				jump++;
				y --;
				playFX(fxJump);
				if (velocity.y<0){
					velocity.y -= 90;
				}else{
					velocity.y = -180;
				}
				
		
				if (in_platform == true){
					in_platform = false;
					platform = null;
				}
				
			}
			
			
			if(FlxG.keys.justPressed.X){
				if(coulddown<=0){
					skill_action(0); 
					shield = false;
				}
			}
			else if (FlxG.keys.justPressed.Z) {
				if(finish_anim==false){	
					skill_action(1); 
				}
			}
			
			
			//cambia el arma proncipal
			if (FlxG.keys.justPressed.S) {
				//evita que se cambia el arma mientras golpea
				if(finish_anim==false){		
					if(weapon==0){
						weapon = 1;
					}
					else {	
						weapon = 0;
					}
				}
			}
			
			/*
			if (FlxG.keys.justPressed.A) {
				
				if(finish_anim==false){	
					if(s_weapon==0){
						s_weapon = 1;
						shield = false;
					}
					else
					{	
					s_weapon = 0;
					}
				}
			}*/
			
			//
		if(s_weapon==0){
			if (FlxG.keys.justReleased.Z) {
					
					shield = false;
				}
			}
		}
		
		if (in_platform == true) {
				//añade a la velocidad actual la velocidad de la plataforma
				if(finish_anim!=true){//evita un error al golpear sobre una  plataforma horizontal
					velocity.x += platform.velocity.x;
				}else{
					velocity.x = platform.velocity.x;
					
				}
				if (platform.ID != 1) {
					velocity.y = platform.velocity.y;	
					y = platform.y - height-1;
				}
				else {
				//piso falso	
					if (platform.velocity.y == 0){
							y = platform.y - height-1;
					}
				}	
				
				
				platform.ContacPlayer();
				jump = 0;
				//chequea la posicion en la plataforma
				if(x+width<platform.x || x>platform.x+platform.width || platform.check==false){
					in_platform = false;
					platform = null;
				}
			}
			
		if (velocity.y>0){
			acceleration.y = 400;
		}
	
		animation.play(act_anim);
	}

	/* ||-----------SkillAction---------------------------------------------------||
	* 
	* pistola
	* golpe
	* */
	private function skill_action(button:Int):Void{
		var dmg:Int= 40;
		
		if (buff[1]) { 
			dmg *= 2;
		}
		// gestiona las diferentes abilidades
		var atk_x;
		var atk_y;
		
		if(dir==0){
		atk_x = x + width;
		
		}else{
			atk_x = x-16;
		}
		
		atk_y = y;
		
		
		if (button == 0) {
			switch(weapon){
				case 0:
				// fist
				if (finish_anim == true) {
					atk_y += height/4;
					var newAtk:Atack = atacks.recycle(Atack);	
					newAtk.set_id(0);
					newAtk.reset_atk(atk_x, atk_y, 16, 8, 0.1, dmg);	
					newAtk.set_alpha(0);
					coulddown = 0;
					playFX(fxHit);
				}
				else{
					act_anim = "hit";
					finish_anim = true;//para que reprodusca toda la animacion antes de ejecutar otra accion
				}
				case 1:
					// pistola(daño reducido a un cuarto)
					var newbullet:Bullet = atacks.recycle(Bullet);
					
					newbullet.reset_bullet(atk_x, atk_y, 1.0, Math.round(dmg / 4), dir, 450, 0);
					newbullet.set_id(0);
					newbullet.set_alpha(1);
					act_anim = "shot";
					finish_anim = true;
					coulddown = 0.2;
					playFX(fxShot);
			}
				
			
		}
		else{
			switch(s_weapon){
				case 0:
				// escudo
				shield = true;
				velocity.x = 0;
				act_anim = "shield";
			}
		}
		
		
		
	}
	
	/* ||-----------Coulddown---------------------------------------------------||
	* actualiza tiempo tiempo de espera
	* y el timpo de los buff
	* */
	
	
	private function act_coulddown():Void {
		coulddown -= FlxG.elapsed;
		// actualiza los buff
		for ( i in 0...2) { 
			if(buff_time[i]<=0){
				buff[i] = false;
			}else{
				buff_time[i] -= FlxG.elapsed;
			}
		}
		//actualiza tiempo de retroceso
		if(r_coulddown>=0){
			r_coulddown -= FlxG.elapsed;
		}
		//actualisa tiempo de invencivilidad post daño
		if(NoDmgTime>0){
			NoDmgTime-= FlxG.elapsed;
		}
	}
	
	
	/* ||-----------Colliciones---------------------------------------------------||
	 * acciones de las diferentes coliciones con el entorno
	 * se llaman desde los diferentes overlap/collide del evento update(clase playstate)
	 * */
	
	public function collition_item(id_item:Int){
		switch(id_item){
			// restaura vida
			case 0: if(life < max_life){
				life +=Std.int(max_life/4);
				if (life > max_life) { life = max_life; }
			}
			//activa buff
			case 1: buff[0] = true; buff_time[0] = 45.0;//shield
			case 2:	buff[1] = true; buff_time[1] = 45.0;//power
			 
		}
		
	}
	
	public function collition_platfrom(platform_c:Platform):Void{
		
		
		//FlxG.log.add("y+height: " + (y + height) + "platform_c: " + platform_c.y);
		var ny:Float = y + height ;// +velocity.y * FlxG.elapsed;
		
	//	if ( ny >= platform_c.y && ny < platform_c.y+platform_c.height) {
		//if ( ny >= platform_c.y){ //&& y+height > platform_c.y) {
		if (platform_c.check){
		if(y+height>=platform_c.y && y+height<=platform_c.y+height/4) {
			if (platform_c.ID == 2) {//resorte|spring
				y = platform_c.y - height-1;
				velocity.y =-320;
				jump = 1;
				platform_c.ContacPlayer();//activa la animacion del resorte
			}else{
				platform = platform_c;
				y = platform.y - height;
				in_platform = true;
				
			}
			
			
		}
		else
		{
			/*
			if (y >= platform_c.y + platform_c.height) {	
				y = platform_c.y+platform_c.height + 1;
				//velocity.y = 0;
			}
			else
			{
				if (x < platform_c.x + platform_c.width)
				{
					
					FlxG.log.add("");
					x = platform_c.x+platform_c.width+1;	
				}
				
				else if (x+width>platform_c.x)
				{
					FlxG.log.add("p |->");
					x = platform_c.x-width-1;	
				}
			}
			*/
			//Retroceso(0.1); 
		}
		}
	}
	
	public function collition_atk(atk:Dynamic):Bool {
	//direcciones relativas a la posicion del jugador
	//chequea el escudo activo	
		if(r_coulddown<=0){
			var dmg:Int = atk.collition();
			if (shield) {
					
				if(flipX){//collicion por derecha
					if(atk.x+atk.width>x+4){//+4 para balas que colicionen por arriva y debajo
						shield = false;
						flipX = false;
						animation.play("stand");
						Damage(dmg);
						Retroceso(0.05);
					}
						//chequea si la bala puede rebotar
					else {
						
						Retroceso(0.02,true);//menor timpo debido al escudo
						if (atk.rebote) {
							atk.rebote_dir();	
							atk.set_id(0);
							//atacks.add(atk);
						}
						else{
							return false;
						}
					}
						
				}
				else {//collicion por izquierda
					if(atk.x<x+width-4) {//+4 para balas que colicionen por arriva y debajoa
						shield = false;
						flipX = true;
						animation.play("stand");
						Damage(dmg);
						Retroceso(0.05);
					}
					else {
						Retroceso(0.02,true);//menor tiempo debido al escudo	
						if (atk.rebote) {
							//chequea si la bala puede rebotar
							atk.rebote_dir();
							atk.set_id(0);
							//atacks.add(atk);
							
						}
						else{
							return false;
						}
					}
					
				}
				return true;
			}
			else {
				
				if(r_coulddown<=0){	
					Damage(dmg);
					Retroceso(0.05);
				}
			}
		}
		else {
			return true; 
		}
		return false;
	}
	
	public function collition_Enemy(e:Enemy):Void {
		//chequea el escudo activo	
		var dmg:Int = e.getDmg();
		if(r_coulddown<=0){
			if(shield){
				if(flipX==false){//collicion por izquierda
					if(e.x+e.width<x+4){
						Damage(dmg);
						//desactiva escudo e invierte orientacion del player
						shield = false;
						flipX = false;
						animation.play("stand");
						Retroceso(0.05);
						
					}else {
						Retroceso(0.03, true);//menor timpo debido al escudo
						
					}
					
				}
				else {//collicion por derecha
					if(e.x>x+width-8){
						Damage(dmg);
						//desactiva escudo e invierte orientacion del player
						shield = false;
						flipX = true;
						animation.play("stand");
						Retroceso(0.05);
						
					}else{
						Retroceso(0.03, true);//menor tiempo debido al escudo
				
					}
				}
				
			}
			else{
				Damage(dmg);
				Retroceso(0.05);
			}
		}
		
		if (e.tipe!=0) {
			
				e.Retroceso();
			
		}
		
		else {
		
				if(r_coulddown<=0){		
					Damage(dmg);
					
				}
		}
		
	}
	
	public function collition_Trap(trap:Trap):Void{
		var idTrap:Int = trap.GetID();
		switch(idTrap) {
		//collciion con needles	
			case 0:
				if (y < trap.y) {
					y = trap.y - height;
					life-= trap.GetDmg();//no se utilisa funcion damage para ignorar el tiempo de invulneravilidad
				}
				else{
					if (x + width / 2 < trap.x) {
						x = trap.x - 1; 
					}
					else{
						 x = trap.x+trap.width + 1;
					}
				}
				//collicion con fire trap
			case 1:
				if(trap.InAction()){
						Damage(trap.GetDmg());
						//colicion po izqueierda
						if (x + width / 2 <= trap.x + trap.width / 2){
							shield = false;
							flipX = false;
							x = trap.x - width;
						}
						//colicion por derecha
						else{
							shield = false;
							flipX = true;
							x = trap.x + trap.width;
						}
						Retroceso(0.10);
				}
		}
	}

	private function Retroceso(time:Float = null,OnShield:Bool=false):Void {
		
		//retroseso
		if(r_coulddown<=0){
			if(flipX){
				if (OnShield){
					velocity.x = speed * 0.25;				
				}
				else
				{
					velocity.x = speed * 0.5;
				}
			}
			else{
				if (OnShield)
				{
					velocity.x = -speed * 0.25;	
				}
				else
				{
					velocity.x = -speed * 0.5;
				}
			}
			
			if(time==null){	
				r_coulddown = 0.20;
			}else{
				r_coulddown = time;
			}
			//act_anim = "dmg";
		}
	}
	
	
	private function playFX(SoundPath:String){
		
		fxsound.loadEmbedded(SoundPath);
		
		fxsound.play();
	}
		
	//nesesarios para el hud y el paso de nivel a nivel
	public function GetMaxLife():Int { 
		return max_life; 
		
	}
	
	//coloca la vida del personaje segun la variable vida en el registro
	public function set_life(){
		life = Reg.life;
	}
	
	//devuelve decimal del porcentaje de vida respecto a la vida maxima
	public function get_life():Float{	
		return (life / max_life);	
	}
	
	
	public function set_weapon ():Void {
		weapon = Reg.weapon;
	}

	//devuelve el int del arma actual(nesesario para que la clase hud dibuje el arma actual)
	public function get_weapon ():Int {
		return weapon;
	}

	
	
	public function set_buff():Void{
		buff = Reg.buff;
		buff_time = Reg.buff_time;
		
	}
	
	public function  get_buff():Array<Bool>{
		return buff;
	} 
	public function get_buff_time():Array<Float> {
		return buff_time;
	}
}