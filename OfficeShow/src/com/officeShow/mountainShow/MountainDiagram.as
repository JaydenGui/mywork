package com.officeShow.mountainShow
{
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;

	public class MountainDiagram extends Object3D
	{
		private var mountainNum:int = 6;
		private var mountainList:Vector.<MountainPolygon>;
		private var mountainDistance:int = 80;
		private var bottom:Box;
		private var _bottomWidth:uint;
		private var _bottomHeight:uint = 10;
		private var _bottomLength:uint;
		private var inInAnimate:Boolean = false;
		private var _mountainUI:MountainUI;
		private var uiCtner:DisplayObjectContainer;
		private var centerPos:Point = new Point(240,240);
		private var _colors:Array = [0xE7775F,0xE7AC6A,0x8EA686,0xBF8B75,0x74C7CF,0xA68AD7];
		private var texts:Array = ["微博","搜索引擎","视频","微信","女性垂直","口碑平台"];
		private var labels:Vector.<MountainLabel>;
		private var height2DList:Array;
		private var pos2DList:Array;
		
		public function MountainDiagram(uiCtner:DisplayObjectContainer,mountainNum:int=6,texts:Array=null,pos2DList:Array=null,height2DList:Array=null)
		{
			this.mountainNum = mountainNum;
			if(texts)
				this.texts = texts;
			this.height2DList = height2DList;
			this.pos2DList = pos2DList;
			
			createPolygon();
			changePos();
			createBottom();
			this.rotationZ = Math.PI/4;
			this.uiCtner = uiCtner;
			
		}
		
		public function startZAnimation():void
		{
			for each(var mountain:MountainPolygon in mountainList)
			{
				mountain.scaleZ = 0;
				TweenLite.to(mountain,1.5,{"scaleZ":1,onComplete:onZAnimationComplete});
			}
			_mountainUI.alpha = 0;
		}
		
		private function onZAnimationComplete():void
		{
			TweenLite.to(_mountainUI,1.5,{"alpha":1});
		}
		
		
		private var text:MountainLabel;
		public function update(content3D:Context3D,camera:Camera3D,uiCtner:DisplayObjectContainer):void
		{
			if(!this.parent)
				return;
			
			if(!_mountainUI.parent)
			{
				uiCtner.addChild(_mountainUI);
			}
			
			if(!labels)
				labels = new Vector.<MountainLabel>(mountainNum);
			for(var i:int = mountainNum-1; i >=0 ; --i)
			{
				var pos:Vector3D = mountainList[i].getHighestVertex();
				if(pos)
				{
					pos = mountainList[i].localToGlobal(pos);
					pos = camera.projectGlobal(pos);
					
					if(!labels[i])
					{
						labels[i] = new MountainLabel();
						labels[i].drawBackgroud(_colors[i%_colors.length]);
						_mountainUI.addChild(labels[i]);
					}
					labels[i].text = texts[i];
					labels[i].x = pos.x;
					labels[i].y = pos.y-3;
				}
			}
			
			_mountainUI.drawAxis(mountainList[0],camera);
		}
		
		private function createPolygon():void
		{
			mountainList = new Vector.<MountainPolygon>();
			for(var i:uint = 0; i < mountainNum; ++i)
			{
				var params:Array = getRandomParams(i);
				mountainList.push(new MountainPolygon(params[0],params[1],params[2]));	
			}
		}
		
		private function createBottom():void
		{
			_bottomLength = mountainList.length*mountainDistance;
			
			var paddingWidth:uint = 0;
			var paddingLength:uint = 20;
			_bottomWidth += paddingWidth*2;
			_bottomLength += paddingLength*2;
			bottom = new Box(_bottomWidth,_bottomLength,_bottomHeight);
			
			bottom.setMaterialToAllSurfaces(new FillMaterial(0xcccccc,0.5));
			bottom.addSurface(new FillMaterial(0xffffff,0.5),6*2,2);
			bottom.addSurface(new FillMaterial(0xffffff,0.5),6*3,2);
			bottom.addSurface(new FillMaterial(0xffffff,0.5),6*4,2);
			bottom.addSurface(new FillMaterial(0xffffff,0.5),6*5,2);
			bottom.x = -centerPos.x + _bottomWidth/2 - paddingWidth;
			bottom.y = -centerPos.y + _bottomLength/2 - paddingLength;
			bottom.z = -_bottomHeight/2;
			this.addChild(bottom);
			
			_mountainUI = new MountainUI();
		}
		
		
		private function changePos():void
		{
			for(var i:uint; i < mountainList.length;++i)
			{
				mountainList[i].y = -centerPos.y + mountainDistance*i;
				this.addChild(mountainList[i]);
			}
		}
		
		private function getRandomParams(index:uint):Array
		{
			var posList:Array = [];
			var heightList:Array = [];
			var num:int = 0;
			if(!height2DList && !posList)
			{
				num = 16;
				for(var i:int = 0;i < num;++i)
				{
					posList.push(-centerPos.x + i*30);
					if(i == 0 || i == num-1)
					{
						heightList.push(0);
					}
					else
					{
						heightList.push(Math.random()*MountainPolygon.MAX_HEIGHT);
					}
				}
			}
			else
			{
				posList = pos2DList[index];
				heightList = height2DList[index];
				num = 16;
			}
			
			
			_bottomWidth = num*30;
			
//			var color:uint = Math.random()*0xffffff;
			
			var color:uint = _colors[index%_colors.length];
			
			return [posList,heightList,color];
		}
	}
}