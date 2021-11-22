$(document).on("change",'input[type="file"]',function(e){

	var currentId= $(this).attr('id');

	var iSize = ($(this)[0].files[0].size / 1024); 
	var fileSize = (Math.round(iSize * 100) / 100);
	var resultSize = fileSize+" "+"kb";
	var allimg = URL.createObjectURL(e.target.files[0]);
	
	$(this).prev("."+currentId+"_preview").remove();

	console.log($(this));

	var newdiv;
	var fileName =$(this).val();
	var fileNameExt = fileName.substr(fileName.lastIndexOf('.') + 1);
	if(fileNameExt=="jpg" || fileNameExt=="png" || fileNameExt=="gif" || fileNameExt=="jpeg"){
		newdiv="<div id='"+currentId+"_preview' class='row "+currentId+"_preview'><div class='col-md-6'><div style='width: 100px;border: 1px solid black;margin-bottom:5px'><img src='"+allimg+"' style='width:100px'></div></div><div class='col-md-6'>File Size :"+resultSize+"</div></div>";
	}else if(fileNameExt=="pdf"){
		newdiv="<div id='"+currentId+"_preview' class='row "+currentId+"_preview'><div class='col-md-6'><div style='width: 100px;border: 1px solid black;margin-bottom:5px'><i class='fa fa-file-pdf-o' style='font-size:48px;padding: 38px 28px;'></i></div></div><div class='col-md-6'>File Size :"+resultSize+"</div></div>";
	}else if(fileNameExt=="doc" || fileNameExt=="docx"){
		newdiv="<div id='"+currentId+"_preview' class='row "+currentId+"_preview'><div class='col-md-6'><div style='width: 100px;border: 1px solid black;margin-bottom:5px'><i class='fa fa-file-word-o' style='font-size:48px;padding: 38px 28px;'></i></div></div><div class='col-md-6'>File Size :"+resultSize+"</div></div>";
	}else if(fileNameExt=="zip"){
		newdiv="<div id='"+currentId+"_preview' class='row "+currentId+"_preview'><div class='col-md-6'><div style='width: 100px;border: 1px solid black;margin-bottom:5px'><i class='fa fa-file-zip-o' style='font-size:48px;padding: 38px 28px;'></i></div></div><div class='col-md-6'>File Size :"+resultSize+"</div></div>";
	}else if(fileNameExt=="text"){
		newdiv="<div id='"+currentId+"_preview' class='row "+currentId+"_preview'><div class='col-md-6'><div  style='width: 100px;border: 1px solid black;margin-bottom:5px'><i class='fa fa-file-text' style='font-size:48px;padding: 38px 28px;'></i></div></div><div class='col-md-6'>File Size :"+resultSize+"</div></div>";
	}else{
		newdiv="<div id='"+currentId+"_preview' class='row "+currentId+"_preview'><div class='col-md-6'><div  style='width: 100px;border: 1px solid black;margin-bottom:5px'><i class='fa fa-file' style='font-size:48px;padding: 38px 28px;'></i></div></div><div class='col-md-6'>File Size :"+resultSize+"</div></div>";
	}
	
	$(this).before(newdiv) 
})
