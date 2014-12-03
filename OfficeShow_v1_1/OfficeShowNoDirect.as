package
{
	import com.officeShow.circleShow.CircleUI;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.system.Security;
	
	[SWF(backgroundColor="#2B2937", frameRate="30", width="800", height="600")]
	public class OfficeShowNoDirect extends Sprite
	{
		public static const CIRCLE:String = "circle";
		private var _type:String;
		private var circleDiagram:CircleUI;
		private var _uiCtner:Sprite;
		
		public function OfficeShowNoDirect()
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Security.allowDomain("*");
			ExternalInterface.addCallback("setShowType",setShowTypeHandler);
			
//			this.stage.doubleClickEnabled = true;
//			this.stage.addEventListener(MouseEvent.DOUBLE_CLICK,clickHandler);
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			try
			{
				ExternalInterface.call("offficeInitCompleteCall");
			}catch(e:Error)
			{
			}
		}
		
		private function clickHandler(e:MouseEvent):void
		{
//			var txt:String = '{"brand":[{"name":"宝马","logo_url":"1","inner":[25,50,75],"position":[35,66]}, {"name":"宝马","inner":[25,50,75],"position":[35,66]}]';
			var txt2:String = '{"cate":"汽车","brand":[{"radius":60,"color":0,"inner":[25,50,75],"position":[135,166],"name":"宝马","logo-url":"../res/奥迪.png"},{"radius":80,"color":1,"inner":[25,50,75],"position":[166,135],"name":"宝马","logo-url":"../res/宝马.png"}]}';
			var t:Object = {brand:[{"name":"宝马","logo-url":"../res/奥迪.png","inner":[25,50,75],"position":[135,166]},{"name":"宝马","logo-url":"../res/宝马.png","inner":[25,50,75],"position":[166,135]}]};
			var txt:String = JSON.stringify(t);
			var data:Object = JSON.parse(txt2);
			setShowTypeHandler(CIRCLE,data);
			
		}
		
		private function setShowTypeHandler(type:String,data:Object):void
		{
			var paramData:Object = data is String ? JSON.parse(String(data)):data;
			showType(type,paramData);
		}
		
		private function showType(type:String,data:Object):void
		{
			clear();
			_uiCtner = new Sprite();
			this.addChild(_uiCtner);
			switch(type)
			{
				case CIRCLE:
					_type = type;
					circleDiagram = new CircleUI(stage.stageWidth ? stage.stageWidth : 800,stage.stageHeight ? stage.stageHeight:600);
					_uiCtner.addChild(circleDiagram);
					var radius:uint = 77;
					var rect:Rectangle = circleDiagram.getValidRect();
					rect.left += radius;
					rect.top += radius;
					rect.right -= radius;
					rect.bottom -= radius;
					if(data == null)
					{
//						for(var i:int = 0;i < 5;++i)
//						{
//							circleDiagram.addBtn((i+1).toString(),null,rect.left+rect.width*Math.random(),rect.top+rect.height*Math.random());
//						}
					}
					else
					{
						for each(var unit:Object in data.brand)
						{
							circleDiagram.addBtn(unit.name,
								unit["logo-url"],
								unit.position[0],unit.position[1],
								unit.inner[0],unit.inner[1],unit.inner[2],
								unit.color,
								Number(unit.radius)>0?Number(unit.radius):50+40*Math.random());
						}
					}
					break;
				default:
					_type = "";
			}
		}
		
		private function clear():void
		{
			if(_uiCtner && _uiCtner.parent)
			{
				_uiCtner.parent.removeChild(_uiCtner);
			}
			
			_uiCtner = null;
		}
	}
}