package com.officeShow.polygonShow
{
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class ZObjectController
	{
		private var eventSource:InteractiveObject;
		private var object:Object3D;
		private var mousePoint:Point = new Point();
		private var mouseLook:Boolean;
		private var time:int;
		private var objRotationZ:Number;
		private var objRotationX:Number;
		private var min:Number;
		private var max:Number;
		
		private var minX:Number = 0;
		private var maxX:Number = 400;
		private var camera:Camera3D;
		private var objectTransform:Vector.<Vector3D>;
		
		public function ZObjectController(eventSource:InteractiveObject, camera:Camera3D, object:Object3D,min:Number=-1,max:Number=-1)
		{
			this.eventSource = eventSource;
			this.object = object;
			this.min = min;
			this.max = max;
			this.camera = camera;
			
			objectTransform = object.matrix.decompose();
			enable();
		}
		
		public function enable():void
		{
			eventSource.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			eventSource.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			eventSource.addEventListener(MouseEvent.ROLL_OUT,onMouseUp);
		}
		
		public function disable():void
		{
			eventSource.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			eventSource.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stopMouseLook();
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			startMouseLook();
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stopMouseLook();
		}
		
		public function startMouseLook():void 
		{
			mousePoint.x = eventSource.mouseX;
			mousePoint.y = eventSource.mouseY;
			if(object)
			{
				objRotationZ = object.rotationZ;
				if(camera)
					objRotationX = camera.z;
			}
			mouseLook = true;
		}
		
		public function stopMouseLook():void
		{
			mouseLook = false;
		}
		
		public function update():void
		{
			if(!object)
				return;
			
			if(mouseLook)
			{
				var dx:Number = eventSource.mouseX - mousePoint.x;
				var dy:Number = eventSource.mouseY - mousePoint.y;
				var newZ:Number = objRotationZ + dx*Math.PI/360*0.5;
				var newX:Number = objRotationX + dy;
				
				var v:Vector3D = objectTransform[1];
				
				if(min!=-1&&max!=-1)
				{
					if(newZ<min)
						newZ = min;
					if(newZ>max)
						newZ = max;
				}
				
				if(newX<minX)
				{
					newX = minX;
				}
				if(newX>maxX)
				{
					newX = maxX;
				}
				
//				v.x = newX;
				v.z = newZ;
				
				
//				object.rotationZ = newZ;
//				object.rotationX = newX;
				
				var m:Matrix3D = new Matrix3D();
				m.recompose(objectTransform);
				object.matrix = m;
//				trace(object.rotationZ);
				
				if(camera)
				{
					camera.z = newX;
					camera.lookAt(0,0,0);
				}
			}
		}
		
		
	}
}