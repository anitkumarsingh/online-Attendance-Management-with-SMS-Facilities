/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 var curpage;
    
function showmymenu(obj){
    $('#floatmnu').slideToggle();
    var pos = $(obj).position();
    $('#floatmnu').css("left", pos.left)
    var top= pos.top+25;
    $('#floatmnu').css("top", top)
    //alert(pos.left + " " + pos.top);
}
/*timetableIncharge*/
function getTimetableSetup(){
    $.getScript("../TimeTable/js/Timetable.js", function(){
       loadSemester();
    });
}

/*---timetable*/
function gettimetable(){
     $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading Timetable</center>");
     curpage=gettimetable;
      $.ajax({
                type: "POST",
                url: "../TimeTable/viewTimetable.jsp",
                success: function(msg){
                   $('#right').html(msg);
                   $('#status').html("Loaded");
                    t=setTimeout("clearmsg()",3000);
               }
      });
}
/*---my document*/
function getMyDocument(){
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading MyDocument</center>");
$.getScript("../js/FileBrowser.js", function(){
   curpage=getMyDocument;
      $.ajax({
                type: "POST",
                url: "./AjaxPages/MyDocument.jsp",
                success: function(msg){
                   $('#right').html(msg)
                   $('.afolder').css("display", "block");
                   $('.file').css("display", "block");
                    $('#overlay').hide();
                   browse('none');
                 $('#inline').hide();
                   document.getElementById('form1').onsubmit=function() {
                    document.getElementById('form1').target = 'inline'; //'upload_target' is the name of the iframe
                    }
                   $('#status').html("Loaded");
                    t=setTimeout("clearmsg()",3000);
               }
      });
});
    
}


function createDir(){
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Creating Directory</center>");
    $.ajax({
                type: "POST",
                url: "./AjaxPages/MyDocument.jsp",
                data:"create="+$('#new_dir').val(),
                success: function(msg){
                    $('#status').html("<center>Created Successfully</center>");
                    browse('none');                    
                    
                }
            });
}
function deleteFile(name,type){
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Deleting File</center>");
    var data="";
    if(type=="dir")
        data="rmfile="+name
    else
        data="rmdir="+name
 $.ajax({
                type: "POST",
                url: "./AjaxPages/MyDocument.jsp",
                data:data,
                success: function(msg){
                       //alert(msg)
                       $('#status').html("<center>Deleted Successfully</center>");
                       if(type=="dir")
                           browse('none');
                       else
                           browse($('#directory').val());
                }
            });
}

/*--- end of mydocument*/
function clearmsg(){
  $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
    clearTimeout(t);
}

function check(){
    var j=0;
   
     $(".chk").each(
    function(i,n) {
         
        if(n.id!="none" || n.id!=undefined){
            
            if($('#'+n.id).val()==''){
                j++;
				
              
        }
        }
      }
    );
    /*alert(j)
        if(j<3)
            $('#submit').attr("disabled", "true");
        else
            $('#submit').removeAttr("disabled")*/
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

var number = "0123456789";
var attandance="0123456789,";
var marks="0123456789Aa.";
function res(t,v){
var w = "";
for (i=0; i < t.value.length; i++) {
x = t.value.charAt(i);
if (v.indexOf(x,0) != -1)
    w += x;
}
t.value = w;
}

function welcome(){
    url="AjaxPages/welcome.jsp";
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading Welcome Page</center>");
    curpage=welcome;
    $.ajax({
                    type: "POST",
                    url: url,
                    success: function(msg){
                         $('#right').html(msg);
                         smartColumns(200,250);
                         $('#status').html("<center>Loaded Successfully</center>");
                         loadSoftware();
                         t=setTimeout("clearmsg()",3000);
                    }
                   
    });
    
}
function CreateSubjectSession(subject_id,section,elective,semester,name){
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Switching to "+subject_id+"</center>");
    url="./AjaxPages/CreateSession.jsp"
    //alert("subject_id="+subject_id+"&subject_name="+name+"&section="+section+"&elective="+elective+"&semester="+semester)
    $.ajax({
                type: "POST",
                url: url,
                data:"subject_id="+subject_id+"&subject_name="+name+"&section="+section+"&elective="+elective+"&semester="+semester,
                success: function(msg){
                   // alert(msg)
                        $('#status').html($.trim(msg));
                        curpage();
               }
      });
}

(function($){
   $.validate = function(elem){
       $("#"+elem+" .error").remove();
     var flag=true;
     $("#"+elem+" .required").each(
    function(i,n) {
         $("#"+n.id).css("color","black");
        if(n.id!="none" || n.id!=undefined){
            if($.trim($("#"+n.id).val())=='' || $.trim($("#"+n.id).val())=='selectone'){
                flag=false;                
               $("#"+n.id).css("color","red");
               if( $.trim($("#"+n.id).val())=='selectone')
                    $("#"+n.id).parent().append("<span style='padding-left:160px;' class='error'>*</span>");
                else
                    $("#"+n.id).parent().append("<span style='padding-left:15px;' class='error'>*</span>");
                $("#"+n.id).focus();                
        }
        }
      }
    );
        if(!flag)
            $('#'+elem).append("<div class='error'>*Required</div>")
    return flag;
   }
})(jQuery);