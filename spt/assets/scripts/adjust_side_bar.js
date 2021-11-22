$(function(){
    var menu_height = $(".page-sidebar-wrapper .page-sidebar ul").height();
    var sub_menu_height = 0;
	
	$(".page-content-wrapper .page-content").css('min-height', menu_height + sub_menu_height);

    setTimeout(function(){
		menu_height = $(".page-sidebar-wrapper .page-sidebar ul").height();
		$(".page-content-wrapper .page-content").css('min-height', menu_height);
    }, 1000);
	
	

    $(".page-sidebar .page-sidebar-menu li a").click(function(){
        console.log("clicked");

        setTimeout(function(){
            var mh = $(".page-sidebar-wrapper .page-sidebar ul").height();
            var el = $(this).siblings("ul");
        
            $(".page-content-wrapper .page-content").css('min-height', mh + el.height());
        }, 500);
    });
	
});