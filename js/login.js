$(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("./common/servertime.jsp", function(){

});
 });
var t

function guidlines(){
    $('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
    $.ajax({
        type: "POST",
        url: "./AjaxPages/guidelines.jsp",
        success: function(msg){
            $('#status').html("<center>Loaded Successful</center>");
            $("#content_wrapper").html(msg)
             t=setTimeout("clearmsg()",3000);
        }
    });
}

function Credit(){
   // alert("hi")
    $('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
$.getScript("./js/jquery.quickflip.js", function(){
$.ajax({
        type: "POST",
        url: "./AjaxPages/Credits.jsp",
        success: function(msg){
            $('#status').html("<center>Loaded Successful</center>");
            //alert(msg)
            $("#content_wrapper").html(msg)
            $('#flip-container').quickFlip();

		$('#flip-navigation li a').each(function(){
			$(this).click(function(){
				$('#flip-navigation li').each(function(){
					$(this).removeClass('selected');
				});
				$(this).parent().addClass('selected');
				var flipid=$(this).attr('id').substr(4);
				$('#flip-container').quickFlipper({ }, flipid, 1);

				return false;
			});
		});
             t=setTimeout("clearmsg()",3000);
        }
    });
});

}

function ResourceSearch(){
var subject=$('#subject').val();
var year=$("#year").val();
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");

$.ajax({
        type: "POST",
        url: "./AjaxPages/ResourceSearch.jsp",
        data: "action=none&year="+year+"&subject="+subject,
        success: function(msg){
            $("#content_wrapper").html(msg)
            $('#status').html("<center>Loaded Successful</center>");
             t=setTimeout("clearmsg()",3000);
        }
    });
}

function StudentProfile(){
var section=$('#section').val();
var semester=$("#semester").val();
//alert("action=none&section="+section+"&semester="+semester)
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
$.ajax({
        type: "POST",
        url: "./AjaxPages/StudentProfile.jsp",
        data:"action=none&section="+section+"&semester="+semester,
        success: function(msg){
            $("#content_wrapper").html(msg)
            $('#status').html("<center>Loaded Successful</center>");
             t=setTimeout("clearmsg()",3000);
        }
    });
}

function OnchangeStudentProfile(){
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
var section=$('#section').val();
var semester=$("#semester").val();
if(section=="please Select")
    section="undefined";
//alert("action=showstudent&semester="+semester+"&section="+section)
$.ajax({
        type: "POST",
        url: "./AjaxPages/StudentProfile.jsp",
        data: "action=showstudent&semester="+semester+"&section="+section,
        success: function(msg){
            //alert(msg)
            $("#studentDisplay").html(msg);
            $('#status').html("<center>Loaded Successful</center>");
             t=setTimeout("clearmsg()",3000);
        }
    });
}


function OnchangeResource(){
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");

var subject=$('#subject').val();
var year=$("#year").val();
if(subject=="please Select")
    subject="undefined";
//alert("action=showresource&year="+year+"&subject="+subject)
$.ajax({
        type: "POST",
        url: "./AjaxPages/ResourceSearch.jsp",
        data: "action=showresource&year="+year+"&subject="+subject,
        success: function(msg){
            $("#resource").html(msg);
            $('#status').html("<center>Loaded Successful</center>");
             t=setTimeout("clearmsg()",3000);
        }
    });
}


function ArticleSearch(){
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
$.ajax({
        type: "POST",
        url: "./AjaxPages/ArticleSearch.jsp",
        data: "action=showresource",
        success: function(msg){
            $("#content_wrapper").html(msg);
            $('#status').html("<center>Loaded Successful</center>");
             t=setTimeout("clearmsg()",3000);
        }
    });
}
function CommentArticle(){

}
function ArticleDisplay(){

}
 function loginvalidation(){
 var username=document.getElementById("username").value;
 var pass=document.getElementById("password").value;
 alert(username+" "+pass);
$('#err').html("Please Wait ...")
  $.ajax({
                type: "POST",
                url: "http://localhost:8080/onlineatt/common/loginvalidation.jsp",
                data: "username="+username+"&password="+pass,
                async:false,
                success: function(msg){
                    if(jQuery.trim(msg)=='error'){
                         $('#err').html("User Name / Password is incorrect");
                         t=setTimeout("clearmsg()",3000);
                    }
                   else{
                       $('#err').html("Logging In ...")
                         window.location=msg;
                   }
                },
                error:function(xhr){
				      alert("An error occured: " + xhr.status + " " + xhr.statusText);
				  }

             });
 }

function onEnter(){
    if (event.keyCode == 13) loginvalidation();
}

 function encodeMyHtml(url) {
                encodedHtml = escape(url);
                encodedHtml = encodedHtml.replace(/\//g,"%2F");
                encodedHtml = encodedHtml.replace(/\?/g,"%3F");
                encodedHtml = encodedHtml.replace(/=/g,"%3D");
                encodedHtml = encodedHtml.replace(/&/g,"%26");
                encodedHtml = encodedHtml.replace(/@/g,"%40");
                encodedHtml = encodedHtml.replace(/\+/g,"%2B");
                return encodedHtml;
}


function FacultyProfile(){
url="AjaxPages/FacultyProfile.jsp"
$('#status').show();
$('#status').html("<center><img src='./images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        //alert("hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#top_div').html(msg)
                        $('#bottom_div').html("");
                        t=setTimeout("clearmsg()",3000);

                   }
 });
}





