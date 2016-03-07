package SpaceInvaders
{

	import flash.display.*;
	import flash.events.*;

	public class AlienBullet extends Sprite
	{
		private var sh:Shape;
		private var speed:Number = 5;
		private var STAGE_HEIGHT:Number = 0;
		
		public function AlienBullet()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		private function added(e:Event):void
		{
			sh = new Shape();
			sh.graphics.lineStyle(0, 0xFF0000, 1);
			sh.graphics.beginFill(0xFF0000, 1);
			sh.graphics.drawRect(0, 0, 2, 2);
			sh.graphics.endFill();
			
			this.addEventListener(Event.ENTER_FRAME, goDown);
			addChild(sh);
			
			STAGE_HEIGHT = this.stage.stageHeight;
		}
		private function goDown(e:Event):void
		{
			this.y += speed;
			
			if(this.y >= STAGE_HEIGHT)
			{
				removeAlienBullet();
			}
		}
		
		public function removeAlienBullet():void
		{
			this.removeEventListener(Event.ENTER_FRAME, goDown);
			this.removeChild(sh);
			this.parent.removeChild(this);
			
			//trace("removing bullet");
		}
		
	} //ends class
	
} //ends package