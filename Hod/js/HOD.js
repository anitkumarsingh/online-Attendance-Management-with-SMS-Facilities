/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 
 
 
 $(document).ready(function(){

$.getScript("../common/servertime.jsp", function(){ });
 });
 function getTimetableReport(){
    // alert("ji")
     var url="./AjaxPages/ShowTimeTable.jsp";
     
        $('#status').show();
        $('#status').html("Loading...")
        $.ajax({
                type: "POST",
                url: url,
                success: function(msg){
                   //alert(msg)
                    $('#right').html($.trim(msg))
                    $('#status').html("<center>Loaded</center>");
                    t=setTimeout("clearmsg()",3000);
                }
            });
           // t=setTimeout("clearmsg()",3000);
 }
 /*---timetable*/
function gettimetable(){
    var semester=$('#semester').val();
    var section=$('#section').val();
    //alert("semester="+semester+"&section="+section)
     $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading Timetable</center>");
     curpage=gettimetable;
      $.ajax({
                type: "POST",
                url: "../TimeTable/viewTimetable.jsp",
                data:"semester="+semester+"&section="+section,
                success: function(msg){
                   $('#timetable').html(msg);
                   $('#status').html("Loaded");
                    t=setTimeout("clearmsg()",3000);
               }
      });
}