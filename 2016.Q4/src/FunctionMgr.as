package
{
	import flash.utils.Dictionary;

	public class FunctionMgr
	{
		
		public static function replaceExtensionPngToXml(text:String):String
		{
			var result:String = text;
			var dot:int = result.lastIndexOf(".");
			result = result.substring(0, dot);		
			result += ".xml";
			
			return result;
		}
		
		public static function removeExtension(text:String):String
		{
			var result:String = text;
			var dot:int = result.lastIndexOf(".");
			result = result.substring(0, dot);			
			
			return result;
		}
		
		
		
		public static function getDictionaryLength(dic:Dictionary):int
		{
			var length:int;
			
			for(var key:Object in dic)
			{
				length++;
			}
			
			return length;
		}
	}
}