

function activateMenu(){
	console.log("activateMenu called, fullMenu.length = " + fullMenu.length);
	for (var i = 0; i < fullMenu.length; i++) {
		if (typeof fullMenu[i] !== 'undefined' && fullMenu[i].trim()) {
			console.log("activating " + fullMenu[i]);
			if(i < fullMenu.length - 1)
			{
				$("#" + fullMenu[i].trim()).addClass("start active open");
			}
			else
			{
				$("#" + fullMenu[i].trim()).addClass("start hyperactive open");
			}
			
	    }
		else
		{
			console.log("not activating " + fullMenu[i]);
		}

	  }
}


