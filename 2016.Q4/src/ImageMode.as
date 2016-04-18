package
{
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class ImageMode extends Sprite
	{
		private var _arrowUp:Image;
		private var _arrowDown:Image;
		private var _currentPage:int;
		//private var _pieceSpr:Sprite = new Sprite();
		private var _pieceImage:Image = new Image(null);									//화면에 보여주기 용 스프라이트
		private var _spriteListVector:Vector.<Sprite>;										//스프라이트시트 텍스트필드를 담는 배열									
		private var _listSpr:Sprite = new Sprite();											//우측 하단 상하화살표버튼을 누르면 열리는 리스트
		private var _selectSpriteSheetButton:Image;											//상하화살표버튼
		private var _currentSpriteSheet:TextField = new TextField(200, 24, "");				//현재 선택된 스프라이트 시트를 나타내기 위한 텍스트필드
		
		
		public function ImageMode()
		{
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
			
		}
		
		public function get currentSpriteSheet():TextField
		{
			return _currentSpriteSheet;
		}
		
		public function set currentSpriteSheet(value:TextField):void
		{
			_currentSpriteSheet = value;
		}
		
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
		
		public function get listSpr():Sprite
		{
			return _listSpr;
		}
		
		public function set listSpr(value:Sprite):void
		{
			_listSpr = value;
		}
		
		public function get spriteListVector():Vector.<Sprite>
		{
			return _spriteListVector;
		}
		
		public function set spriteListVector(value:Vector.<Sprite>):void
		{
			_spriteListVector = value;
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
						_selectSpriteSheetButton.x = 800;
						_selectSpriteSheetButton.y = 500;
						_selectSpriteSheetButton.visible = true;
						addChild(_selectSpriteSheetButton);						
						break;
					
					case "arrowUp":
						_arrowUp = new Image(guiArray[i].texture);
						_arrowUp.x = 800;
						_arrowUp.y = 548;
						_arrowUp.visible = false;
						addChild(_arrowUp);
						break;
					
					case "arrowDown":
						_arrowDown = new Image(guiArray[i].texture);
						_arrowDown.x = 800;
						_arrowDown.y = 600;
						_arrowDown.visible = false;
						addChild(_arrowDown);
						break;
				}
			}
			_currentSpriteSheet.x = 600;
			_currentSpriteSheet.y = 500;
			
			
			_pieceImage.texture = null;
			_pieceImage.width = 0;
			_pieceImage.height = 0;
			_pieceImage.alignPivot("center", "center");
			_pieceImage.x = 600;
			_pieceImage.y = 250;
			
			addChild(_pieceImage);
			
			
			addChild(_currentSpriteSheet);
			
			
			addChild(_listSpr);
		}
		
		/**
		 * 
		 * @param event 터치 이벤트
		 * 이벤트 리스너 등록
		 */
		private function onAddedEvents(event:starling.events.Event):void
		{				
			_selectSpriteSheetButton.addEventListener(TouchEvent.TOUCH, onClickSpriteListButton);
			_arrowUp.addEventListener(TouchEvent.TOUCH, onArrowUp);
			_arrowDown.addEventListener(TouchEvent.TOUCH, onArrowDown);
		}
		
		/**
		 * 
		 * @param event ↑ 버튼 클릭
		 * 페이지를 내리고 현재 페이지에 해당하는 스프라이트 리스트를 보여줌
		 */
		private function onArrowUp(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_arrowUp, TouchPhase.ENDED);
			if(touch)
			{
				if(_currentPage > 0)
					_currentPage--;
				
				trace("UP");
				trace(_currentPage);
				FunctionMgr.makeVisibleFalse(_spriteListVector);
				_spriteListVector[_currentPage].visible = true;
			}
			
		}
		
		/**
		 * 
		 * @param event ↓ 버튼 클릭
		 * 페이지를 올리고 현재 페이지에 해당하는 스프라이트 리스트를 보여줌
		 */
		private function onArrowDown(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_arrowDown, TouchPhase.ENDED);
			if(touch)
			{
				if(_currentPage < _spriteListVector.length -1)
					_currentPage++;
								
				trace("DOWN");
				trace(_currentPage);
				FunctionMgr.makeVisibleFalse(_spriteListVector);
				spriteListVector[currentPage].visible = true;
			}
			
		}
		
		/**
		 * 
		 * @param event 화면 우측 하단 스프라이트리스트버튼 클릭
		 * 5개 단위의 스프라이트 리스트를 띄워줌
		 */
		private function onClickSpriteListButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_selectSpriteSheetButton, TouchPhase.ENDED);
			if(touch)
			{
				_arrowUp.visible = true;
				_arrowDown.visible = true;
				dispatchEvent(new Event("openSpriteList"));
				
				_spriteListVector[_currentPage].visible = true;
			}
		}
		
		/**
		 * 
		 * 
		 * 화면에 보이는 스프라이트 리스트 화살표 버튼을 안보이게 하는 메소드
		 */
		public function makeArrowVisibleFalse():void
		{
			_arrowUp.visible = false;
			_arrowDown.visible = false;
		}
		
		
	}
}