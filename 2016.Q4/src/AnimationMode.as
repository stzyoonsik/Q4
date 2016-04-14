package
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class AnimationMode extends Sprite
	{
		private var _playButton:Image;
		private var _pauseButton:Image;
		private var _deleteButton:Image;	
		
		
		private var _content:Image;
		
		public function AnimationMode()
		{
			addEventListener(TouchEvent.TOUCH, onAddedEvents);	
		}
		
		public function init(guiArray:Array):void
		{
			trace("init");
			for(var i:int = 0; i<guiArray.length; ++i)
			{
				switch(guiArray[i].name)
				{
					case "playButton":
						_playButton = new Image(guiArray[i].texture);
						_playButton.pivotX = _playButton.width / 2;
						_playButton.pivotY = _playButton.height / 2;
						_playButton.x = 632;
						_playButton.y = 532;						
						addChild(_playButton);						
						break;
					case "pauseButton":
						_pauseButton = new Image(guiArray[i].texture);
						_pauseButton.pivotX = _pauseButton.width / 2;
						_pauseButton.pivotY = _pauseButton.height / 2;
						_pauseButton.x = 732;
						_pauseButton.y = 532;
						addChild(_pauseButton);
						break;
					case "deleteButton":
						_deleteButton = new Image(guiArray[i].texture);
						_deleteButton.pivotX = _deleteButton.width / 2;
						_deleteButton.pivotY = _deleteButton.height / 2;
						_deleteButton.x = 832;
						_deleteButton.y = 532;
						addChild(_deleteButton);
						break;
					case "content":
						_content = new Image(guiArray[i].texture);
						_content.pivotX = _content.width / 2;
						_content.pivotY = _content.height / 2;
						_content.x = 450;
						_content.y = 250;
						addChild(_content);
						break;
				}
			}
		}
		
		private function onAddedEvents(event:starling.events.Event):void
		{
			//trace(event.target);		
			
			_playButton.addEventListener(TouchEvent.TOUCH, onPlayButton);
			_pauseButton.addEventListener(TouchEvent.TOUCH, onPauseButton);
			_deleteButton.addEventListener(TouchEvent.TOUCH, onDeleteButton);
			
		}
		
		/**
		 * 
		 * @param event 마우스 클릭 
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 이미지를 재생하는 메소드
		 */
		private function onPlayButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_playButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_playButton.scale = 0.8;
			}
			else
			{
				_playButton.scale = 1;
			}
			
			touch = event.getTouch(_playButton, TouchPhase.ENDED);
			if(touch)
			{
				trace("플레이버튼");
			}
		}
		
		/**
		 * 
		 * @param event 마우스 클릭
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 이미지의 재생을 멈추는 메소드
		 */
		private function onPauseButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_pauseButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_pauseButton.scale = 0.8;
			}
			else
			{
				_pauseButton.scale = 1;
			}
			
			touch = event.getTouch(_pauseButton, TouchPhase.ENDED);
			if(touch)
			{
				trace("퍼즈버튼");
			}
		}
		
		/**
		 * 
		 * @param event 마우스 클릭
		 * 클릭이 발생했을 때 버튼 이미지의 크기를 신축하고, 현재 이미지를 배열에서 제거하는 메소드
		 */
		private function onDeleteButton(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(_deleteButton, TouchPhase.BEGAN);
			if(touch)
			{
				
				_deleteButton.scale = 0.8;
			}
			else
			{
				_deleteButton.scale = 1;
			}
			
			touch = event.getTouch(_deleteButton, TouchPhase.ENDED);
			if(touch)
			{
				trace("삭제버튼");
			}
		}
	}
}