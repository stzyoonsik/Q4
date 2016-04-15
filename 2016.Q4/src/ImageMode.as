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
	import starling.textures.Texture;

	public class ImageMode extends Sprite
	{
		private var _arrowUp:Image;
		private var _arrowDown:Image;
		private var _currentPage:int;
		//public static var _pieceImageDic:Dictionary = new Dictionary();				//조각난 각각의 이미지를 담는 딕셔너리
		private var _pieceSpr:Sprite = new Sprite();
		private var _pieceImage:Image = new Image(null);									//화면에 보여주기 용 스프라이트
		//private var _pieceImage:Texture;// = new Image(null);									//화면에 보여주기 용 스프라이트
		private var _spriteSheetTextField:TextField;										//현재 선택된 스프라이트시트의 이름을 나타내는 텍스트필드
		private var _spriteSheetList:Vector.<TextField> = new Vector.<TextField>;			//스프라이트시트 텍스트필드를 담는 배열
		//private var _listSpr:Vector.<Sprite> = new Vector.<Sprite>;											//스프라이트시트 텍스트필드 를 담는 Sprite
		private var _listSpr:Sprite = new Sprite();
		private var _selectSpriteSheetButton:Image;											//화살표버튼
		private var _currentSpriteSheet:TextField = new TextField(200, 24, "");				//현재 선택된 스프라이트 시트를 나타내기 위한 텍스트필드
		
		
		public function ImageMode()
		{
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
			
		}
		
//		public function get listSpr():Vector.<Sprite>
//		{
//			return _listSpr;
//		}
//
//		public function set listSpr(value:Vector.<Sprite>):void
//		{
//			_listSpr = value;
//		}

		public function get currentPage():int
		{
			return _currentPage;
		}

		public function set currentPage(value:int):void
		{
			_currentPage = value;
		}

		public function get pieceImage():Image
		{
			return _pieceImage;
		}

		public function set pieceImage(value:Image):void
		{
			_pieceImage = value;
		}

//		public function get pieceImage():Texture
//		{
//			return _pieceImage;
//		}
//
//		public function set pieceImage(value:Texture):void
//		{
//			_pieceImage = value;
//		}

		public function get listSpr():Sprite
		{
			return _listSpr;
		}

		public function set listSpr(value:Sprite):void
		{
			_listSpr = value;
		}

		public function get spriteSheetList():Vector.<TextField>
		{
			return _spriteSheetList;
		}

		public function set spriteSheetList(value:Vector.<TextField>):void
		{
			_spriteSheetList = value;
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
						_selectSpriteSheetButton.x = 800;
						_selectSpriteSheetButton.y = 500;
						_selectSpriteSheetButton.visible = true;
						addChild(_selectSpriteSheetButton);						
						break;
					
					case "arrowUp":
						_arrowUp = new Image(guiArray[i].texture);
						_arrowUp.x = 800;
						_arrowUp.y = 548;
						addChild(_arrowUp);
						break;
					
					case "arrowDown":
						_arrowDown = new Image(guiArray[i].texture);
						_arrowDown.x = 800;
						_arrowDown.y = 600;
						addChild(_arrowDown);
						break;
				}
			}
			_currentSpriteSheet.x = 600;
			_currentSpriteSheet.y = 500;
			
			//_pieceSpr.pivotX = 200;
			//_pieceSpr.pivotY = 100;
			//_pieceSpr.x = 500;
			//_pieceSpr.y = 150;
			
			//_pieceSpr.width = 300;
			//_pieceSpr.height = 300;
			//addChild(_pieceSpr);
			//_pieceImage = new Texture();
			//_pieceImage.x = 600;
			//_pieceImage.y = 200;
			 
			_pieceImage.texture = null;
			_pieceImage.width = 0;
			_pieceImage.height = 0;
			//_pieceImage.width = 300;
			//_pieceImage.height = 300;
			//_pieceSpr.addChild(_pieceImage);
			//addChild(_pieceSpr);
			addChild(_pieceImage);
			
			
			addChild(_currentSpriteSheet);
			//_listSpr.addChild(_arrowUp);
			//_listSpr.addChild(_arrowDown);
			_listSpr.x = 600;
			_listSpr.y = 524;
			_listSpr.visible = false;
			addChild(_listSpr);
		}
			
		private function onAddedEvents(event:starling.events.Event):void
		{				
			_selectSpriteSheetButton.addEventListener(TouchEvent.TOUCH, onSelectSpriteSheetButton);
			_arrowUp.addEventListener(TouchEvent.TOUCH, onArrowUp);
			_arrowDown.addEventListener(TouchEvent.TOUCH, onArrowDown);
		}
		
		private function onArrowUp(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_arrowUp, TouchPhase.ENDED);
			if(touch)
			{
				if(_currentPage > 0)
					_currentPage--;
				
				dispatchEvent(new Event("arrowUp"));
			}
		
		}
		
		private function onArrowDown(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_arrowDown, TouchPhase.ENDED);
			if(touch)
			{
				_currentPage++;
				
				dispatchEvent(new Event("arrowDown"));
			}
	
		}
		
		private function onSelectSpriteSheetButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_selectSpriteSheetButton, TouchPhase.ENDED);
			if(touch)
			{
				_listSpr.visible = true;
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