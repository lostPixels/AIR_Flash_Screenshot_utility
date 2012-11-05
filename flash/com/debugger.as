package com
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.MouseEvent;

	public class debugger
	{
		private var _path:MovieClip;
		private var _holder:MovieClip;
		
		public function debugger($p)
		{
			_path = $p;
			if(_path.getChildByName("debugger_mc") == null) createDebugger();
			else _holder = _path.getChildByName("debugger_mc") as MovieClip
		}
		
		public function write(txt:String)
		{
			var t =_holder.getChildAt(0) as TextField;
			t.text += "\n"+txt;
		}
		private function createDebugger()
		{
			var holder:MovieClip = new MovieClip();
			var btn:MovieClip = new MovieClip();
			var clearBtn:MovieClip = new MovieClip();
			
			holder.name = "debugger_mc";
			_holder = holder;
			btn.graphics.beginFill(0x000000,1);
			btn.graphics.drawRect(0,0,50,10);
			
			clearBtn.graphics.beginFill(0x000000,1);
			clearBtn.graphics.drawRect(0,0,50,20);
			clearBtn.mouseChildren = false;
			var clearBtnTitle:TextField = new TextField();
			clearBtnTitle.text = "CLEAR";
			clearBtnTitle.autoSize = "left";
			clearBtnTitle.textColor = 0xFFFFFF;
			clearBtn.addChild(clearBtnTitle);
			clearBtn.buttonMode = true;
			
			var txtBox:TextField = new TextField();
			txtBox.name = "txtBox";
			txtBox.width = 300;
			txtBox.height = 500;
			txtBox.y = 10;
			txtBox.background = true;
			txtBox.border = true;
			
			clearBtn.x = txtBox.width -50;
			clearBtn.y = txtBox.height-9
			
			clearBtn.visible = false;
			txtBox.visible = false;
			
			_path.addChild(holder);
			holder.addChild(txtBox);
			holder.addChild(btn);
			holder.addChild(clearBtn);
			
			function btnActions(e)
			{
				if(btn.alpha == 1)
				{
					btn.alpha = .7;
					txtBox.visible = true;
					clearBtn.visible = true;
				}
				else
				{
					btn.alpha = 1;
					clearBtn.visible = false;
					txtBox.visible = false;
				}
			}
			function clearText(e)
			{
				txtBox.text = "";
			}
			btn.addEventListener(MouseEvent.CLICK,btnActions);
			clearBtn.addEventListener(MouseEvent.CLICK,clearText);
		}
	}
}