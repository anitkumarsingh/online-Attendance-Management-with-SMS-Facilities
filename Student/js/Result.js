/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 $(document).ready( function() {

            $.getScript("../common/servertime.jsp", function(){
     });
 });

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

function Result(){
    
url="./AjaxPages/Result.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                         //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#curriculam').hide();
                        $('#report').html(msg)
                        $('#report').show();
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function OverallResult(){
    $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
url="./AjaxPages/Result.jsp"
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=overall&rand="+Math.random(),
                success: function(msg){
                         //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg)
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}


function FindResult(sem){
    $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
//alert(sem)
url="./AjaxPages/Result.jsp"
$.ajax({
                type: "POST",
                url: url,
                data:"action=find&semester="+sem,
                success: function(msg){
                       //alert(msg);
                       if($.trim((msg))=="0")
                            {
                              
                              GetResult(sem)
                            }
                        else
                            {
                            $('#status').html("<center>Loaded Successful</center>")
                            $('#right').html(msg)
                            }
                            t=setTimeout("clearmsg()",3000);
                        }
 });
}

function GetResult(sem){
    
    $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
url="./AjaxPages/Result.jsp"
//alert(sem)
$.ajax({
                type: "POST",
                url: url,
                data:"action=show&semester="+sem,
                success: function(msg){
                        //alert(msg)
                        //alert("hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg)
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function AddResult(sem){
    $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Adding ...</center>");
//alert("hi")
url="./AjaxPages/Result.jsp"
var arg="&";
 $("#right input[type=text]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
          arg=arg+n.id+"="+$("#"+n.id).val()+"&";
        }
      }
    );
$("#right select").each(
        function(i,n) {
            if(n.id!="none"){
            arg=arg+n.id+"="+$("#"+n.id).val()+'&';
        }
      });
         arg="action=add&semester="+sem+arg;
        // $('#status').html("./AjaxPages/Result.jsp?"+arg);
        //alert(arg)
        //$('#status').html(arg);
        $.ajax({
                type: "POST",
                url: url,
                data:arg,
                success: function(msg){
                       //alert(('#examtype').val());
                       $('#status').html("<center>Loaded Successful</center>");
                       //$('#right').html(msg)
                       FindResult(sem);
                }
            });
}

     function DeleteSemesterResult(sno){
         $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Deleting ...</center>");
         url="AjaxPages/SemesterResult.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"sno="+sno+"&action=delete",
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        SemesterResult();
                        //$('#tabs').tabs();
               }
            });
    }

