/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * ramkumar sept 24 2009 @3 52.13 pm
 */

function clearmsg(){
  $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
 clearTimeout(t);
}

function loadhome(){
url="./AjaxPages/home.jsp"
$.ajax({
                type: "POST",
                url: url,
                data:"action=profile",
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");                       
                        $('#welcome').html(msg);
                        smartColumns(220,210);//Execute the function when page loads
                      
                        }
 });
}
function loadinboxcount(){
url="./AjaxPages/home.jsp"
$.ajax({
                type: "POST",
                url: url,
                data:"action=inboxcount",
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#inbox_count').html(msg)
                        
                }
 });
}
function loadAttendance(){
    url="./AjaxPages/home.jsp"
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=attendance",
                    success: function(msg){
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#attendance').html(msg)
                            
                            }
     });
}

function loadNews(){
    url="./AjaxPages/home.jsp"
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=updates",
                    success: function(msg){
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#news').html(msg)
                            
                            }
     });
}
function loadGallery(){
    url="./AjaxPages/home.jsp"
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=gallery",
                    success: function(msg){
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#welcome').html(msg);
                            
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


function QuestionBankView(){
url="AjaxPages/QuestionBankDownload.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#curriculam').show();
                        $('#curriculam').html(msg)
                        $('#tabs').tabs();
                        $('#report').hide();
                        t=setTimeout("clearmsg()",3000);
                   }
 });
}