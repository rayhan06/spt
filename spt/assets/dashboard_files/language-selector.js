$( "#languageSelector" ).on( "change", function(){
	
	//language change variable comes from common-js-var.js file
	var url = context + languageChangeUrl + $(this).val(); 
	callAjax( url, {}, "GET", languageChangeSuccess, languageChangeError );
});

function languageChangeSuccess( data ){
	
	location.reload();
}

function languageChangeError( data ){
	
	console.log( "error in lang change" );
}