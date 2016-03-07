package SpaceInvaders
{
	import SpaceInvaders.*;
	import flash.display.*;
	import flash.events.*;

	public class AlienGroup extends Sprite
	{
		private var speed:Number			=		0;
		public var alienArray:Array			=		new Array();
		private var numCols:int				=		0;
		private var numRows:int				=		0;
		private var space:Number			=		0;
		private var numAliens				=		0;
		private var holder:Sprite			=		new Sprite();
		private var w:Number				=		25;
		private var leftLimit:Number		=		0;
		private var rightLimit:Number		=		0;
		private var max:int					=		0;
		private var min:int					=		0;
		private var goodGuy:DisplayObject	=		null;
		private var numLivingAliens:int		=		0;
		
		
		public function AlienGroup(rows:int, cols:int, spacing:Number, tank:DisplayObject)
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(holder);
			holder.y = 25;
			
			numCols = cols;
			numRows = rows;
			numAliens = cols * rows;
			numLivingAliens = numAliens;	
			space = spacing;
			
			rightLimit = numCols * (w + space) - space;
			leftLimit = 0;
			
			goodGuy = tank;
		}
		
		private function init(e:Event):void
		{
			this.addEventListener(Event.ENTER_FRAME, moveSideToSide);
			
			for(var i:int = 0; i < numRows; i++)
			{
				for(var j:int = 0; j < numCols; j++)
				{
					var a:Alien = new Alien(goodGuy);
					a.x = j * (a.width + space);
					a.y = i * (a.height + space);
					alienArray.push(a);
					holder.addChild(a);
				}
			}
		}
		
		private function moveSideToSide(e:Event):void
		{
			holder.x += speed;

			if(holder.x + rightLimit >= stage.stageWidth || holder.x + leftLimit <= 0)
			{
				speed *= -1;
				holder.y += 25;
			}
			getLeftmostAndRightMost();
		}
		
		

		private function getLeftmostAndRightMost():void
		{
			for(var i:int = 0; i < numAliens; i++)
			{
				if(alienArray[i] != null)
				{
					if(i % numCols > max)
						max = i % numCols;
					if(i % numCols < min)
						min = i % numCols;
				}
			
			}
			
			rightLimit = (w + space) * max + 2 * w;
			leftLimit =  (w + space) * min;
						
			max = 0;
			min = numCols;
		}
		
		public function removeAlien(which:int):void
		{
			if(alienArray[which] != null)
			{
				holder.removeChild(alienArray[which]);
				alienArray[which] = null;
			}
		}
		
		public function testHit(whichBullet:Bullet):Boolean
		{
			for(var i:int = 0; i < numAliens; i++)
			{
				if(alienArray[i] != null && whichBullet.hitTestObject(alienArray[i]))
				{
					holder.removeChild(alienArray[i]);
					alienArray[i] = null;
					whichBullet.removeBullet();
					numLivingAliens--;
					return true;
				}
			}
			
			return false;
		}
		
		public function checkTankHitTest():Boolean
		{
			for(var i:int = 0; i < numAliens; i++)
			{
				if(alienArray[i] != null && goodGuy.hitTestObject(alienArray[i]))
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function stopAlienGroup():void
		{
			this.removeEventListener(Event.ENTER_FRAME, moveSideToSide);
			holder.x = 0;
			holder.y = 25;
		}
		
		public function getAlienGroupSize():int
		{
			return numLivingAliens;
		}
		
		public function setSpeed(newSpeed:Number):void
		{
			speed = newSpeed;
		}
		
	} 
	
} 