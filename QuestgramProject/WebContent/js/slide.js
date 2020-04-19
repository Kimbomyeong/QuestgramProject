

//current position
//var pos = 0;
//number of slides
//var totalSlides = $('#slider-wrap ul li').length;
//get the slide width
//var sliderWidth = $('#slider-wrap').width();



$(document).ready(function(){
	

	//totalSlides = $("#imgPos_"+board_id).attr("totalSlides");
	//sliderWidth = $('#imgPos_'+board_id).attr("sliderWidth");
    
    /*****************
     BUILD THE SLIDER
    *****************/
    //set width to be 'x' times the number of slides
    //$('.slider-wrap ul.slider').width(sliderWidth*totalSlides);
    
    //next slide  
    /*
    $('.next').click(function(){
        slideRight();
    });
    
    //previous slide
    $('.previous').click(function(){
        slideLeft();
    });
    */
    
    
    /*************************
     //*> OPTIONAL SETTINGS
    ************************/
    //automatic slider
    //var autoSlider = setInterval(slideRight, 3000);
    
    //for each slide 
    
    //counter
    //countSlides();
    
    //pagination
    //pagination();
    
    //hide/show controls/btns when hover
    //pause automatic slide when hover
    
    
    /*
    $('.slider-wrap').hover(function() {
	  		mouseOn();
	  	}, function() {
	  		mouseOut();
	  	})
    
     */
    hoverEvent();
    
   
    
    /*
    $(".slider-wrap").hover(function() {
    	$(".counter").addClass("active");
    }, function() {	
    	$(".counter").removeClass("active");
    })
    */

});//DOCUMENT READY
function hoverEvent() {
	$('.slider-wrap').hover(function(){ 
    	boardId = $(this).attr("board_id");
    	var count = $('#imgPos_' + boardId).attr("totalSlides");
    	if(count < 2) {
    		return;
    	}
    	$(this).addClass('active');
    	var pos = $('#imgPos_' + boardId).attr("pos");
    	//clearInterval();
    	$("#counter_"+boardId).addClass("active");
    	if(pos == 0){
    	  $("#previous_" + boardId).hide();
    	} 
    	countSlides(boardId, Number(pos));
    	pagination(boardId, Number(pos));
    	
    }, function(){ 
    	  $(this).removeClass('active');
    	  $("#counter_"+boardId).removeClass("active");
    	  //clearInterval(); 
    });
}


/*

function mouseOn(board_id){
	var pos = $("#imgPos_"+board_id).attr("pos");
	$(this).addClass('active'); clearInterval(); 
	$("#counter_"+board_id).addClass("active");
	if(pos===0){
	  $(".previous").hide();
	} 
	countSlides(board_id);
	pagination(board_id);	
}

function mouseOut(board_id){
	$(this).removeClass('active'); 
	$("#counter_"+board_id).removeClass("active");
	  	clearInterval(); 		
}
    
*/

/***********
 SLIDE LEFT
************/

function slideLeft(boardId){
	$("#next_"+boardId).show();
	totalSlides = $("#imgPos_"+boardId).attr("totalSlides");
    sliderWidth = $('#imgPos_'+boardId).attr("sliderWidth");
    var pos = $('#imgPos_'+boardId).attr("pos");
    pos--;
    if(pos==0){ 
    	$("#previous_"+boardId).hide();
    } else {
    	
    }

	$('#imgPos_'+boardId).attr("pos", pos);
    $('#slider_'+boardId).css('left', -(sliderWidth*pos));    
	
    //*> optional
    countSlides(boardId, pos);
    pagination(boardId, pos);
}


/************
 SLIDE RIGHT
*************/
function slideRight(boardId){
	$("#previous_"+boardId).show();
	totalSlides = $("#imgPos_"+boardId).attr("totalSlides");
	sliderWidth = $('#imgPos_'+boardId).attr("sliderWidth");
	var pos = $('#imgPos_'+boardId).attr("pos");
    pos++;	
    if((pos+1) == totalSlides){ 
    	$("#next_"+boardId).hide();
    	pos = totalSlides-1;
    }

	$('#imgPos_'+boardId).attr("pos", pos);
    $('#slider_'+boardId).css('left', -(sliderWidth*pos)); 
    
    //*> optional 
    countSlides(boardId, pos);
    pagination(boardId, pos);
}



    
/************************
 //*> OPTIONAL SETTINGS
************************/
function countSlides(boardId, pos){
	totalSlides = $("#imgPos_"+boardId).attr("totalSlides");	
    $('#counter_'+boardId).html(pos+1 + '/' + totalSlides);
    
}

function pagination(boardId, pos){
	$("#pagination-wrap_"+boardId+" ul li").removeClass('active');
	$("#pagination-wrap_"+boardId+" ul li:eq("+pos+")").addClass('active');
    //$('.pagination-wrap ul li').removeClass('active');
    //$('.pagination-wrap ul li:eq('+pos+')').addClass('active');
}





