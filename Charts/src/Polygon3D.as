package
{
	import com.fiCharts.charts.chart2D.encry.CSB;
	import com.fiCharts.charts.chart2D.encry.Dec;
	import com.fiCharts.charts.chart3D.polygon.RPD;
	
	public class Polygon3D extends CSB
	{
		
		public function Polygon3D()
		{
			this.dec = new Dec;
			this.dec.Lc = LiByte;
			this.dec.Meta = MetaByte;
			
			super();
		}
		
		/**
		 */
		override protected function createChart():void
		{
			chart = new RPD();	
			
			super.createChart();
		}
		
		/**
		 *  这里的压缩文件是由  Polygon3DConfig.xml 压缩得来， 源文件可查看完整配置；
		 */		
		[Embed(source="Polygon3DConfig.z", mimeType="application/octet-stream")]
		private var MetaByte:Class;
			
		/**
		 */	
		[Embed(source="license.z", mimeType="application/octet-stream")]
		private var LiByte:Class;
	}
}