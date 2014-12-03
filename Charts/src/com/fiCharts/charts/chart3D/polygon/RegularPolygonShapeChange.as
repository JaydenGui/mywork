package com.fiCharts.charts.chart3D.polygon
{
	import flash.geom.Vector3D;

	public class RegularPolygonShapeChange
	{
		//让9个顶点更加明显
		private var _data:Array = [1.1,1.1,1.1,1.2,1.1,1.1,1.1,1.1,1.1];
		private var _allSize:Array = [1,1,1,1,0.9,0.9,0.9,0.9,0.9]
		public function RegularPolygonShapeChange(polygon:RegularPolygon,data:Array = null,allSize:Array = null)
		{
			if(data != null && data.length == _data.length)
				_data = data;
			
			if(allSize != null && allSize.length == _allSize.length)
				_allSize = data;
			
			polygon.cachePosition();
			for(var i:int = 0; i < _data.length; ++i)
			{
				var index:int = i*2+1;
				var pos:Vector3D = polygon.getVertexPos(index);
				pos.x *= _data[i]*_allSize[i];
				pos.y *= _data[i]*_allSize[i];
				polygon.setVertexPos(index,pos);
				
				if(index == 1)
				{
					var prePos:Vector3D = polygon.getVertexPos(_data.length*2 - 1);
					prePos.x *= _allSize[i];
					prePos.y *= _allSize[i];
					polygon.setVertexPos(_data.length*2 - 1,prePos);
				}
				
				var nextPos:Vector3D = polygon.getVertexPos(index+1);
				if(nextPos)
				{
					nextPos.x *= _allSize[i];
					nextPos.y *= _allSize[i];
					polygon.setVertexPos(index+1,nextPos);
				}
			}
		}
	}
}