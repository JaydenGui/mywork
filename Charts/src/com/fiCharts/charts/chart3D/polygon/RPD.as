package com.fiCharts.charts.chart3D.polygon
{
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	
	import com.fiCharts.charts.chart3D.ZObjectController;
	import com.fiCharts.charts.common.IChart;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	
	public class RPD extends Sprite implements IChart
	{
		private var camera:Camera3D;
		private var stage3D:Stage3D;
		public static const BG:uint = 0x2B2937;
		public static const ANTIALIAS:int = 4;
		private var rootContainer:Object3D = new Object3D();
		
		private var _uiCtner:Sprite;
		
		private var polygonDiagram:RegularPolygonDiagram;
		
		private var zController:ZObjectController;
		
//		private var _fanContent:Array = 
//			[{name:"服务",fan:[{label:"本科",value:2},{label:"保障维修",value:3},{label:"片区规划",value:4},{label:"物业管理",value:5}]},
//				{name:"体验",fan:[{label:"本科",value:2},{label:"21-31岁",value:3}]},
//				{name:"价格",fan:[{label:"本科",value:5}]},
//				{name:"情感",fan:[{label:"本科",value:3}]}];
		
		public function RPD()
		{
			super();
			
			
			_uiCtner = new Sprite();
			this.addChild(_uiCtner);
		}
		
		public function render():void
		{
			if(camera == null){
				
				camera = new Camera3D(0.1, 10000);
				camera.view = new View(chartWidth, chartHeight, false, BG, 1, ANTIALIAS);
				camera.view.mouseEnabled = false;
				addChild(camera.view);
				
				camera.view.hideLogo();
				
				rootContainer.addChild(camera);
				
				stage3D = stage.stage3Ds[0];
				stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
				stage3D.requestContext3D(Context3DRenderMode.AUTO);
				
				camera.rotationX = -110*Math.PI/180;
				camera.y = -400;
				camera.z = 200;
				
				polygonDiagram = new RegularPolygonDiagram(18,200);
				polygonDiagram.data = [820,431,291,210,200,200,100,100,300];
				
				polygonDiagram.setFanContent(xmlToArray(this.dataXML));
				rootContainer.addChild(polygonDiagram);
				updateContext();
				
				zController = new ZObjectController(this,null,polygonDiagram);
			}
		}
		
		private function xmlToArray(data:XML):Array
		{
			var arr:Array = new Array();
			for each(var xml:XML in XMLList(data.elements())){
				var p:Object = new Object();
				p.name = xml.@label[0];
				p.fan = new Array();
				for each(var t:XML in xml.children()){
					p.fan.push({label:t.@label[0], value:t.@value[0]});
				}
				
				arr.push(p);
			}
			return arr;
		}
		
		private function onContextCreate(e:Event):void 
		{
			updateContext();
			
			if(!stage.hasEventListener(Event.ENTER_FRAME))
			{
				stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
			}
		}
		
		private function onEnterFrame(e:Event):void {
			
			camera.view.width = chartWidth;
			camera.view.height = chartHeight;
			
			if(!stage3D.context3D)
				return;
			
			if(polygonDiagram)
			{
				if(zController)
					zController.update();
				
				polygonDiagram.render(stage3D, camera, _uiCtner);
			}
			
			camera.render(stage3D);
		}
		
		private function updateContext():void
		{
			if(stage3D && stage3D.context3D)
			{
				for each (var resource:Resource in rootContainer.getResources(true)) {
					resource.upload(stage3D.context3D);
				}
				
					if(polygonDiagram){
						polygonDiagram.changePolygonOnce(stage3D.context3D);						
					}
			}
		}
		
		public function setStyle(value:String):void
		{
		}
		
		public function setCustomStyle(value:XML):void
		{
		}
		
		public function scaleData(startValue:Object, endValue:Object):void
		{
		}
		
		public function setDataScalable(value:Boolean):void
		{
		}
		
		public function ifDataScalable():Boolean
		{
			return false;
		}
		
		private var _configXML:XML;
		public function set configXML(value:XML):void
		{
			_configXML = value;
			
			if (configXML.hasOwnProperty('data') && configXML.data.children().length())
				this.dataXML = XML(configXML.data.toXMLString());
		}
		
		public function get configXML():XML
		{
			return _configXML;
		}
		
		
		private var _dataXML:XML;
		public function set dataXML(value:XML):void
		{
			_dataXML = value;
		}
		
		public function get dataXML():XML
		{
			return _dataXML;
		}
		
		public function get dataVOes():Vector.<Object>
		{
			return null;
		}
		
		public function set dataVOes(value:Vector.<Object>):void
		{
		}
		
		private var _chartWidth:Number = 0;
		public function set chartWidth(value:Number):void
		{
			_chartWidth = value;
		}
		
		public function get chartWidth():Number
		{
			return _chartWidth;
		}
		
		private var _chartHeight:Number = 0;
		public function get chartHeight():Number
		{
			return _chartHeight;
		}
		
		public function set chartHeight(value:Number):void
		{
			_chartHeight = value;
		}
	}
}