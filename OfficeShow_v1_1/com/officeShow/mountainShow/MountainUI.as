package com.officeShow.mountainShow
{
	import flash.display.Sprite;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.VertexAttributes;
	
	public class MountainUI extends Sprite
	{
		private var axisLabelList:Vector.<TextField>;
		private var axisCtner:Sprite;
		public function MountainUI()
		{
			super();
			
			axisCtner = new Sprite();
			this.addChild(axisCtner);
			axisLabelList = new Vector.<TextField>(3);
			for(var i:uint = 0; i < 3; ++i)
			{
				axisLabelList[i] = new TextField();
				axisLabelList[i].defaultTextFormat = new TextFormat("微软雅黑",12,0xcccccc);
				axisLabelList[i].alpha = 0.8;
				axisLabelList[i].mouseEnabled = false;
				axisCtner.addChild(axisLabelList[i]);
			}
			axisLabelList[0].text="媒体粘度";
			axisLabelList[1].text="使用频度";
			axisLabelList[2].text="人群规模";
		}
		
		
		public function drawAxis(polygon:MountainPolygon,camera:Camera3D):void
		{
			var vertices:Vector.<Number> = polygon.geometry.getAttributeValues(VertexAttributes.POSITION);
			var indices:Vector.<uint> = polygon.geometry.indices;
			
			var index:uint = 0;
			var startPos:Vector3D = new Vector3D(vertices[0],vertices[1],vertices[2]);
			var endPos:Vector3D = new Vector3D(vertices[vertices.length-3],vertices[vertices.length-2],vertices[vertices.length-1]);
			
			startPos.x -= 5;
			endPos.x -= 5;
			startPos.y -= 25;
			endPos.y -= 25;
			startPos.z -= 15;
			endPos.z -= 15;
			
			var newPos:Vector3D = new Vector3D(endPos.x - startPos.x,endPos.y - startPos.y,endPos.z - startPos.z);
			var mat:Matrix3D = new Matrix3D();
			mat.appendRotation(90,new Vector3D(0,0,1));
			newPos = mat.transformVector(newPos);
			newPos = newPos.add(startPos);
			
			startPos = polygon.localToGlobal(startPos);
			endPos = polygon.localToGlobal(endPos);
			newPos = polygon.localToGlobal(newPos);
			startPos = camera.projectGlobal(startPos);
			endPos = camera.projectGlobal(endPos);
			newPos = camera.projectGlobal(newPos);
			
			
//			vector.normalize();
			
			axisCtner.graphics.clear();
			axisCtner.graphics.lineStyle(1,0xcccccc,0.8);
			axisCtner.graphics.moveTo(startPos.x,startPos.y);
			axisCtner.graphics.lineTo(endPos.x,endPos.y);
			axisCtner.graphics.moveTo(startPos.x,startPos.y);
			axisCtner.graphics.lineTo(newPos.x,newPos.y);
			
			axisCtner.graphics.moveTo(startPos.x,startPos.y);
			
			axisCtner.graphics.lineTo(startPos.x,150);
			
			
			axisLabelList[0].x = endPos.x;
			axisLabelList[0].y = endPos.y;
			
			axisLabelList[1].x = newPos.x - 50;
			axisLabelList[1].y = newPos.y;
			
			axisLabelList[2].x = startPos.x - 20;
			axisLabelList[2].y = 150 - 30;
			
			this.addChild(axisCtner);
			
		}
		
//		public function drawAxis(box:Box,camera:Camera3D):void
//		{
//			var vertices:Vector.<Number> = box.geometry.getAttributeValues(VertexAttributes.POSITION);
//			var indices:Vector.<uint> = box.geometry.indices;
//			
//			var index:uint = 0;
//			var startPos:Vector3D = new Vector3D();
//			var endPos:Vector3D = new Vector3D();
//			
//			startPos.x = vertices[indices[index*3]];
//			startPos.y = vertices[indices[index*3]+1];
//			startPos.z = vertices[indices[index*3]+2];
//			
//			index = 7;
//			endPos.x = vertices[indices[index*3]];
//			endPos.y = vertices[indices[index*3]+1];
//			endPos.z = vertices[indices[index*3]+2];
//			
//			startPos = box.localToGlobal(startPos);
//			endPos = box.localToGlobal(endPos);
//			startPos = camera.projectGlobal(startPos);
//			endPos = camera.projectGlobal(endPos);
//			
//			this.graphics.clear();
////			this.graphics.beginFill(0xff0000);
//			this.graphics.lineStyle(1,0xffff00);
//			this.graphics.moveTo(startPos.x,startPos.y);
//			this.graphics.lineTo(endPos.x,endPos.y);
//			
////			this.graphics.moveTo(0,0);
////			this.graphics.lineTo(800,600);
//		}
	}
}