/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function cumulativeReport(){ 
 url="AjaxPages/ShowAttendance.jsp"
 $('#status').html("<center><img src='../images/loading.gif'/>Deleting Attendance</center>");
 $('#status').show();
//alert("action=report&month="+$('#month').val()+"&hour=");
 $.ajax({
                type: "POST",
                url: url,
                data:"action=report&month="+$('#month').val()+"&hour=",
                success: function(msg){
                       $('#studentlist').html(msg);
                       $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                       $('#status').html("<center>Loaded Successfully</center>");
                       
                       $(".popup").click(function () {
                             
                              var pos = $(this).position();
                                var left= pos.left;
                                $('#tooltip').css("left", left)
                                var top= pos.top-150;
                                $('#tooltip').css("top", top)
                                $('#tooltip').show();
                                //alert($(this).html())
                                $('#tooltip').html("please Wait...");
                              
                                 $.ajax({
                                    type: "POST",
                                    url: "./AjaxPages/StudentDetail.jsp",
                                    data:"student_id="+$(this).attr('title'),
                                    success: function(msg){
                                        
                                           $('#tooltip').html(msg)
                                    }
                                });
                        });
                       t=setTimeout("clearmsg()",3000);
                }
            });
}
function loadtopic(unit){
 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Retriving Student Info</center>");
 var url="AjaxPages/ShowAttendance.jsp";
$.ajax({
                type: "POST",
                url: url,
                data:"action=loadtopic&unit="+unit+"&rand="+Math.random(),
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");
                       $('#li_topic').html(msg);
                        t=setTimeout("clearmsg()",3000);
                }
            });
}
function DeleteAttendance(){
 $('#dialog').dialog('open');
}
function advance(){
url="AjaxPages/ShowAttendance.jsp";

 if($.validate('action')==false)
     return;
if( $('#hrs').val().substr(-1,1)==',' ){
   alert("Please check the hour input");
   return;
}

 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Retriving Student Info</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=view&hour="+$('#hrs').val()+"&date="+$('#date').val()+"&rand="+Math.random(),
                success: function(msg){
                       $('#studentlist').html(msg);
                       $('#list li').css('width', '50%');
                      // $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                       $('#status').html("<center>Loaded Successful</center>");
                       
                        t=setTimeout("clearmsg()",3000);
                }
            });
}


function attendance(){
    $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
url="AjaxPages/ShowAttendance.jsp"
curpage=attendance;
$.ajax({
                type: "POST",
                url: url,
                data:"action=showall&rand="+Math.random(),
                success: function(msg){
                       $('#right').html(msg);
                       $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                       $("#dialog").dialog( 'destroy' ) ;
                        $("#dialog").dialog({
                        bgiframe: true,
                        resizable: false,
                        height:50,
                        width: 325,
                        modal: true,
                        autoOpen: false,
                        overlay: {
                                backgroundColor: '#000',
                                opacity: 0.5
                        },
                        buttons: {
                                'Continue': function() {
                                         $(this).dialog('close');
                                            url="AjaxPages/ShowAttendance.jsp"
                                             $('#status').html("<center><img src='../images/loading.gif'/>Deleting Attendance</center>");
                                             $('#status').show();
                                            $.ajax({
                                                            type: "POST",
                                                            url: url,
                                                            data:"action=delete&hour="+$('#hrs').val()+"&date="+$('#date').val()+"&rand="+Math.random(),
                                                            success: function(msg){
                                                                   $('#right').html(msg);
                                                                   $('#list li').css('width', '50%');
                                                                   $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                                                                   $('#status').html("<center>Deleted Successfully</center>");
                                                                    attendance();
                                                            }
                                                        });
                                },
                                Cancel: function() {
                                        $(this).dialog('close');
                                }
                        }
                });
                        $('button').button();
                       $('#status').html("<center>Loaded Successful</center>");
                        t=setTimeout("clearmsg()",3000);
                }
            });
}



function feedAttendance(mode){

 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Submitting</center>");
var url="AjaxPages/ShowAttendance.jsp"
var arg="&student=";
 $("#right input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
          arg=arg+$("#"+n.id).val()+"-"+ ($("#"+n.id).is(':checked')?"A":"P") +'~';
        }
      }
    );

         arg="action="+mode+"&date="+ encodeMyHtml($('#date').val())+"&topic="+$('#topic').val()+"&hour="+$('#hrs').val()+arg;
       // $('#status').html(arg);
       //alert(arg);
        $.ajax({
                type: "POST",
                url: url,
                data:arg,
                success: function(msg){
                       $('#status').html("Adding...");
                       $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                      // $('#right').html(msg);
                      // setTimeout("attendance()",2000);
                       attendance();
                }
            });
}
function selectgroup(student_id){
$("#"+student_id+" input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
           if($("#"+n.id).is(':checked'))
                $("#"+n.id).attr('checked', false);
            else
                $("#"+n.id).attr('checked', true);
        }
      }
    );
}
function InvertSelect(){
    $("#right input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
           if($("#"+n.id).is(':checked'))
                $("#"+n.id).attr('checked', false);
            else
                $("#"+n.id).attr('checked', true);
        }
      }
    );
}