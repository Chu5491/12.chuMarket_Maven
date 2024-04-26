function fncGetList(currentPage) 
{
	$("#currentPage").val(currentPage);
	$("form[name=detailForm]").submit();
}

function previewImg(input) 
{
	if (input.files && input.files[0]) 
	{
		var reader = new FileReader();
		reader.onload = function(e) 
		{
			$("#preview").css('display','');
			document.getElementById('preview').src = e.target.result;
	 	};
	 	
		reader.readAsDataURL(input.files[0]);
	}else 
	{
	  $("#preview").css('display',none);
	  document.getElementById('preview').src = "";
	}
}