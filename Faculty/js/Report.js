/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor. aug 30 12.39AM
 */

var curreport;
/*js for OD form*/
function markOD(){
 var arg="&student=";
 $("#right input[type=checkbox]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
          arg=arg+n.id+"-"+($("#"+n.id).is(':checked')?"O":$("#"+n.id).is(':disabled')?"P":"A")+"~";
        }
      }
    );
    
    url="AjaxPages/ODForm.jsp"
    var incharge=new Array();
    incharge=$('#incharge').val().split("-");
    var semester=incharge[0];
    var section=incharge[1];
    var date=$('#date').val();
    //$('#right').html("action=add&section="+section+"&semester="+semester+"&date="+date+arg)
    $.ajax({
            type: "POST",
            url: url,
            data:"action=add&section="+section+"&semester="+semester+"&date="+date+arg,
            success: function(msg){                  
                   $('#status').html("<center>Added Successful</center>");
                   getODForm();
            }
    });
}
function showODForm(){
        
    $('#status').show();
    url="AjaxPages/ODForm.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=none&date=",
            success: function(msg){
                   $('#right').html(msg);
                   $('#date').datepicker({dateFormat: 'dd/mm/yy'});
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}
function getODForm(){
    var incharge=new Array();
    incharge=$('#incharge').val().split("-");
    //alert(incharge[0]+"-"+incharge[1])
    if($('#date').val()=="")
        return;
    $('#status').show();
    curpage=getODForm;
    var semester=incharge[0];
    var section=incharge[1];
    var date=$('#date').val();
    url="AjaxPages/ODForm.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=showList&section="+section+"&semester="+semester+"&date="+date,
            success: function(msg){
                   $('#right').html(msg);
                   $('#date').datepicker({dateFormat: 'dd/mm/yy'});
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}
/*---- End of  OD form*/
function timetablereport(){
    curreport=timetablereport;
    var semester=$("#semester").val();
    var section=$("#section").val();
    var date=$('#date2').val();
    if($.trim(date)==""){
        date="none"
    }
    
    $('#status').show();
    curpage=timetablereport;
    url="AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=timetable&section="+section+"&semester="+semester+"&date="+date,
            success: function(msg){
                   $('#tabs-4').html(msg);
                   $('#date2').datepicker({dateFormat: 'dd/mm/yy'});
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}
function Report(){
    var reportdata;
    curreport=Report;
    $('#status').show();
    curpage=Report;
    var url="AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=getreportdetail",
            success: function(msg){
                   var i=0;
                   $('#status').html("<center>Loaded Successful</center>");
                   reportdata=msg
                    $.ajax({
                            type: "POST",
                            url: url,
                            data:"action=none",
                            success: function(msg){
                                  //alert(reportdata)
                                   $('#right').html(msg);
                                    $('#tabs').tabs();
                                    $('button').button();
                                    if(reportdata.search("3")==-1){
                                  
                                        $('#tabs').tabs().tabs('select', 3);
                                        timetablereport();
                                        i++;
                                    }
                                    else{
                                        $('#tabs-4').hide();
                                        $('#li4').hide();
                                    }
                                    if(reportdata.search("2")==-1){
                                        $('#tabs').tabs().tabs('select', 2);
                                        internalMarks();
                                        i++;
                                    }
                                    else{
                                        $('#tabs-3').hide();
                                        $('#li3').hide();
                                    }
                                    if(reportdata.search("1")==-1){
                                         $('#tabs').tabs().tabs('select', 0);
                                        cumulativeAttendance();
                                        i++;
                                    }
                                    else{
                                        $('#tabs-1').hide();
                                        $('#tabs-2').hide();
                                        $('#li1').hide();
                                        $('#li2').hide();
                                    }
                                    if(i==0){
                                        $('#tabs').tabs().tabs('select', 4);
                                        CourseProgressReport();
                                    }

                             }
                    });
            }
    });
}

function cumulativeAttendance(){
    curreport=cumulativeAttendance;
    var semester=$("#semester").val();
    var section=$("#section").val();
    var month=$("#month").val();
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading Cumulative Report. This May take Long Time</center>");
    curpage=cumulativeAttendance;
    url="AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=cumulative&month="+month+"&semester="+semester+"&section="+section,
            success: function(msg){
                   $('#cumulative').html(msg);
                   $('button').button();
                   $(".popup").click(function () {
                             
                              var pos = $(this).position();
                                var left= pos.left;
                                $('#tooltip').css("left", left)
                                var top= pos.top-100;
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
                   $('#status').html("<center>Loaded Successful</center>");
                  
                    t=setTimeout("clearmsg()",3000);
            }
    });
}
function nav_dayAttendance(link){
    var date=$('#date1').val();
    var date_split=date.split("/");
    var current=new Date();
    //var newer=new Date();
   // current.setFullYear(date_split[2], date_split[1]-1, date_split[0]);
    if(link=="prev")
        current.setFullYear(date_split[2], date_split[1]-1, date_split[0]-7);
    else if(link=="next"){
        //alert(date_split[2]+","+ (date_split[1]-1)+","+ date_split[0]+7)
        current.setFullYear(date_split[2], date_split[1]-1, parseInt(date_split[0])+7);
}
   // alert(current)
   // alert("New Date "+current.getDate()+"/"+current.getMonth()+1+"/"+current.getFullYear())
    $('#date1').val(current.getDate()+"/"+(current.getMonth()+1)+"/"+current.getFullYear())
    dayAttendance();
}
function dayAttendance(){
    curreport=dayAttendance;
    var semester=$("#semester").val();
    var section=$("#section").val();
    var date=$('#date1').val();

    if($.trim(date)==""){
        date="none"
    }


     $('#status').show();
    curpage=dayAttendance;
    url="AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=day&semester="+semester+"&section="+section+"&date="+date,
            success: function(msg){
                  $('#tabs-2').html(msg);
                  $('button').button();
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
                  $('#status').html("<center>Loaded Successful</center>");
                  $('#date1').datepicker({dateFormat: 'dd/mm/yy'});
                  t=setTimeout("clearmsg()",3000);
            }
    });
}
function internalMarks(){
    curreport=internalMarks;
    var semester=$("#semester").val();
    var section=$("#section").val();

     $('#status').show();
    curpage=internalMarks;
    url="AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=mark&semester="+semester+"&section="+section,
            success: function(msg){
                  $('#tabs-3').html(msg);
                  $('button').button();
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
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}

function CourseCoverageReport(){
    curreport=CourseCoverageReport;
    var sem=$("#semester").val();
    var sec=$("#section").val();
    var sub_id=$('#subjid').val();
    if($.trim(sub_id)==""){
        sub_id="none"
    }
    $('#status').show();
    //alert("action=courseoutline&section="+sec+"&semester="+sem+"&subjectid="+sub_id)
    curpage=CourseCoverageReport;
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=coursecoverage&section="+sec+"&semester="+sem+"&subjectid="+sub_id,
            success: function(msg){
                   //alert(msg);
                   $('#tabs-7').html(msg);
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}


function CourseProgressReport(){
    
    curreport=CourseProgressReport;
    var semester=$("#semester").val();
    var section=$("#section").val();
    var subject_id=$('#subject').val();
    if($.trim(subject_id)==""){
        subject_id="none"
    }
    $('#status').show();
    curpage=CourseProgressReport;
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=courseprogress&section="+section+"&semester="+semester+"&subject_id="+subject_id,
            success: function(msg){

                   $('#tabs-5').html(msg);
                   $('button').button();                 
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}


function CourseOutlineReport(){
    curreport=CourseOutlineReport;
    var sem=$("#semester").val();
    var sec=$("#section").val();
    var sub_id=$('#subjectid').val();
    if($.trim(sub_id)==""){
        sub_id="none"
    }
    $('#status').show();
    //alert("action=courseoutline&section="+sec+"&semester="+sem+"&subjectid="+sub_id)
    curpage=CourseOutlineReport;
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=courseoutline&section="+sec+"&semester="+sem+"&subjectid="+sub_id,
            success: function(msg){
                  // alert(msg);
                   $('#tabs-6').html(msg);
                   $('#status').html("<center>Loaded Successful</center>");
                    t=setTimeout("clearmsg()",3000);
            }
    });
}


function exportXL( divid) {

    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "../common/export.jsp");
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "data");
        hiddenField.setAttribute("value", $('#'+divid+" .scrollTableContainer").html());

        form.appendChild(hiddenField);


    document.body.appendChild(form);    // Not entirely sure if this is necessary
    form.submit();
}
