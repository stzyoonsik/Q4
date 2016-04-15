package
{
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class ImageMode extends Sprite
	{
		//public static var _pieceImageDic:Dictionary = new Dictionary();				//조각난 각각의 이미지를 담는 딕셔너리
		private var _pieceSpr:Sprite = new Sprite();										//화면에 보여주기 용 스프라이트	
		private var _spriteSheetTextField:TextField;										//현재 선택된 스프라이트시트의 이름을 나타내는 텍스트필드
		private var _spriteSheetList:Vector.<TextField> = new Vector.<TextField>;			//스프라이트시트 텍스트필드를 담는 배열
		private var _listSpr:Sprite = new Sprite();											//스프라이트시트 텍스트필드 를 담는 Sprite
		private var _selectSpriteSheetButton:Image;											//화살표버튼
		private var _currentSpriteSheet:TextField = new TextField(240, 24, "asdfadf");				//현재 선택된 스프라이트 시트를 나타내기 위한 텍스트필드
		
		public function ImageMode()
		{
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
			
		}
		
		public function init(guiArray:Vector.<Image>):void
		{
			//trace("init");
			for(var i:int = 0; i<guiArray.length; ++i)
			{
				switch(guiArray[i].name)
				{
					case "selectButton":
						_selectSpriteSheetButton = new Image(guiArray[i].texture);
						//_selectSpriteSheetButton.pivotX = _selectSpriteSheetButton.width / 2;
						//_selectSpriteSheetButton.pivotY = _selectSpriteSheetButton.height / 2;
						_selectSpriteSheetButton.x = 850;
						_selectSpriteSheetButton.y = 500;
						_selectSpriteSheetButton.visible = true;
						addChild(_selectSpriteSheetButton);						
						break;
				}
			}
			_currentSpriteSheet.x = 600;
			_currentSpriteSheet.y = 500;
			
			_pieceSpr.pivotX = 
			_pieceSpr.x = 500;
			_pieceSpr.y = 300;
			addChild(_currentSpriteSheet);
		}
			
		private function onAddedEvents(event:starling.events.Event):void
		{				
			_selectSpriteSheetButton.addEventListener(TouchEvent.TOUCH, onSelectSpriteSheetButton);
		}
		
		private function onSelectSpriteSheetButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_selectSpriteSheetButton, TouchPhase.ENDED);
			if(touch)
			{
				_pieceSpr.visible = true;
				
				
			}
		}
		
		public function setList():void
		{
			//var key:String = SpriteSheet._currentTextField.text;
			//var dic:Dictionary = SpriteSheet._imageDic;
			
			
//			for(var i:int = 0; i < _spriteSheetList.length; ++i)
//			{					
//				_spriteSheetList[i].x = 50;
//				_spriteSheetList[i].y = 624 + (i * 24);
//				_spr.visible = false;
//				_spr.addChild(_spriteSheetList[i]);
//				if(i == _spriteSheetList.length - 1)
//				{
//					_currentSpriteSheet.text = _spriteSheetList[i].name;
//					_currentSpriteSheet.name = _spriteSheetList[i].name;
//					
//					_scaledSpriteSheetDic[_currentSpriteSheet.text].visible = true;
//				}
//			}
			
			//for(var key:String in dic)
			//{
			//	trace(key);
			//}
			
			
			//_spr.addEventListener(TouchEvent.TOUCH, onSelectSpriteSheetList);
			//addChild(_spr);
		}
		
	}
}