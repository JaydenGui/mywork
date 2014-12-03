package com.fiCharts.charts.chart3D.polygon
{
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ui
	 * 
	 */
	public class FanShapedBtn extends Sprite
	{
		private var textNormal:TextField;
		private var textOver:TextField;
		private var hitarea:Sprite;
		private var circle:Shape;
		private var radius:Number = 24;
		private var fanPosList:Vector.<Number>;
		private var fanTxtList:Vector.<FanLabel>;
		public function FanShapedBtn(text:String,fanContent:Array)
		{
			super()
//			buttonMode = true;
//			useHandCursor = true;
			circle = new Shape();
			
			circle.graphics.lineStyle(1,0x6C6A78);
			circle.graphics.beginFill(0x6C6A78,0);
			circle.graphics.drawCircle(0,0,radius);
			circle.graphics.endFill();
			
			var _hitarea:Sprite = new Sprite();
			_hitarea.graphics.beginFill(0x6C6A78,0);
			_hitarea.graphics.drawCircle(0,0,radius);
			_hitarea.graphics.endFill();
			_hitarea.mouseEnabled = false;
			this.addChild(_hitarea);
			graphics.beginFill(0x6C6A78,0);
			graphics.drawCircle(0,0,radius);
			graphics.endFill();
			this.hitArea = _hitarea;
			
			var tf:TextFormat = new TextFormat("微软雅黑",16,0xB4B4B2,true);
			textNormal = new TextField();
			textNormal.defaultTextFormat = tf;
			textNormal.text = text;
			
			tf = new TextFormat("微软雅黑",16,0x8CBCE2,true);
			textOver = new TextField();
			textOver.defaultTextFormat = tf;
			textOver.text = text;
			
			textOver.x = textNormal.x = -18;
			textOver.y = textNormal.y = -11;
			textOver.width =textNormal.width = textNormal.textWidth+3;
			textOver.height = textNormal.height = textNormal.textHeight+3;
			textOver.selectable = textNormal.selectable = false;
			textOver.mouseEnabled = textNormal.mouseEnabled = false;
			circle.visible = false;
			textOver.visible = false;
			this.addChild(circle);
			this.addChild(textNormal);
			this.addChild(textOver);
			
			this.fanContent = fanContent;
			
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
		
		public function set fanContent(value:Array):void
		{
			initFanContent(value);
		}
		
		private function initFanContent(fanContent:Array):void
		{
			if(fanTxtList && fanTxtList.length>0)
			{
				for each(var t:FanLabel in fanTxtList)
				{
					if(t.parent)
					{
						t.parent.removeChild(t);
					}
				}
			}
			fanTxtList = new Vector.<FanLabel>();
			fanPosList = new Vector.<Number>();
			var index:int = -1;
			for each(var fanData:Object in fanContent)
			{
				var fanTxt:String = fanData.label;
				var radius:Number = fanData.value*10+80;
				var fan:FanLabel = new FanLabel(radius);
				fan.text = fanTxt;
				fanPosList.push(index++ * (fan.radian*2*180/Math.PI + 3));
				fan.rotationZ = fanPosList[0];//初始
				fan.visible = false;
				fanTxtList.push(fan);
			}
			
			//注意 添加顺序
			for(var addIndex:int = fanTxtList.length-1; addIndex >= 0; --addIndex)
			{
				this.addChild(fanTxtList[addIndex]);
			}
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			textOver.visible = true;
			textNormal.visible = false;
			circle.visible = true;
			
			showFan();
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			textOver.visible = false;
			textNormal.visible = true;
			circle.visible = false;
			
			hideFan();
		}
		
		private function showFan():void
		{
			for (var i:int = 0; i < fanTxtList.length; ++i)
			{
				fanTxtList[i].visible = true;
				TweenLite.to(fanTxtList[i],0.5,{rotationZ:fanPosList[i]});
			}
		}
		
		private function hideFan():void
		{
			for (var i:int = 0; i < fanTxtList.length; ++i)
			{
				if(i == fanTxtList.length - 1)
				{
					TweenLite.to(fanTxtList[i],0.2,{rotationZ:fanPosList[0],onComplete:hideAnimationComplete});
				}
				else
				{
					TweenLite.to(fanTxtList[i],0.2,{rotationZ:fanPosList[0]});
				}
			}
		}
		
		private function hideAnimationComplete(...args):void
		{
			for (var i:int = 0; i < fanTxtList.length; ++i)
			{
				fanTxtList[i].visible = false;
			}
		}
	}
}