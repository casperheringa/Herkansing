package SpaceInvaders
{

	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import SpaceInvaders.*;
	
	public class Alien extends Sprite
	{
		private var t:Timer			=	new Timer(5000 * Math.random() + 4000);
		private var sh:Shape		=	new Shape;
		private var speed:Number	=	5;
		private var alienPointer:Alien;
		private var goodGuy:DisplayObject;
		private var bulletArr:Array = new Array();
		private var ab:AlienBullet;
		private var sp:Sprite;
		
		public function Alien(opponent:DisplayObject)
		{
			goodGuy = opponent;
			var alienGraphic:AlienGraphic = new AlienGraphic();
			this.addChild(alienGraphic);
			alienGraphic.x = alienGraphic.y = 0;
			
			t.addEventListener(TimerEvent.TIMER, fireGuns);
			t.start();
		}
		
		public function removeAlien(e:Event):void
		{
			alienPointer = e.target as Alien;
			this.parent.removeChild(alienPointer);
			t.removeEventListener(TimerEvent.TIMER, fireGuns);
			
			for(var i:int = 0; i < bulletArr.length; i++)
			{
				if(bulletArr[i] != null)
				{
					this.removeChild(bulletArr[i]);
					bulletArr[i] = null;
				}
			}
		}
		
		private function fireGuns(e:TimerEvent):void
		{
			if(this.parent != null)
			{
				ab = new AlienBullet();
				ab.x = this.x + this.parent.x;
				ab.y = this.y + this.parent.y;
				bulletArr.push(ab);
				this.parent.parent.addChild(ab);	// adds to stage, not alien or holder
			}
		}
		
		private function go(e:Event):void
		{
			e.target.y += 5;
		}
		
		public function hitTestAlienBullets():Boolean
		{
			for(var i:int = 0; i < bulletArr.length; i++)
			{
				if(bulletArr[i].hitTestObject(goodGuy))
				{
					return true;
				}
			}
			return false;
		}
		
	} 
	
}