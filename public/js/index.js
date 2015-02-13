$(function(){	
	var _showTab = 6;
	var $defaultLi = $('#pin li').eq(_showTab).addClass('active');	
	$($defaultLi.find('a').attr('href')).siblings().hide();  
	$('#pin li').hover(function() {		
		var $this = $(this),
			_clickTab = $this.find('a').attr('href');		
		$this.addClass('active').siblings('.active').removeClass('active');
		$(_clickTab).stop(false, true).fadeIn(1000).siblings().hide(); 
		return false;
	}).find('a').focus(function(){
		this.blur();
	});
});

$(document).ready(function(){
  $('#item-box').bxSlider({
    auto: true,
    autoHover: true,
    pause: 3000,
    pagerCustom: $('#tab'),
    controls: false,
    onSlideAfter: function($slideElement, oldIndex, newIndex){ 
      $("#tab .active").parent().addClass('active_bg').siblings().removeClass('active_bg');
    }
  });
  
  $("#tab-1").addClass('active_bg')

  $('#banner ul').bxSlider({
  	auto: true,
  	pause: 5000,
  	controls: false,
  	pager: false,
    mode: 'fade'
  });
})