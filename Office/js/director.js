/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


 $(document).ready(function(){
     $(".status").hide();
$.getScript("../common/servertime.jsp", function(){ });
    var url="../Faculty/AjaxPages/welcome.jsp";
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Loading Welcome Page</center>");

        $.ajax({
                        type: "POST",
                        url: url,
                        success: function(msg){
                             $('#right').html(msg);
                             smartColumns(200,250);
                             loadSoftware();
                             $('#status').html("<center>Loaded Successfully</center>");
                             t=setTimeout("clearmsg()",3000);
                        }

        });
 });

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
                   //alert(msg);
                   $('#tabs-6').html(msg);
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
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=timetable&section="+section+"&semester="+semester+"&date="+date,
            success: function(msg){
                   $('#tabs-4').html(msg);
                   $('#date2').datepicker({ dateFormat: 'dd/mm/yy' });
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
    var url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=getreportdetail",
            success: function(msg){
                   $('#status').html("<center>Loaded Successful</center>");
                   reportdata=msg
                    $.ajax({
                            type: "POST",
                            url: url,
                            data:"action=none",
                            success: function(msg){
                                   $('#right').html(msg);
                                    $('#tabs').tabs();
                                    cumulativeAttendance()
                                   //$('#status').html("<center>Loaded Successful</center>");
                                    //t=setTimeout("clearmsg()",3000);
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
     $('#status').html("<center><img src='../images/loading.gif'/>Loading Cumulative Report</center>");
    curpage=cumulativeAttendance;
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=cumulative&month="+month+"&semester="+semester+"&section="+section,
            success: function(msg){
                   $('#cumulative').html(msg);
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
                                    url: "../Faculty/AjaxPages/StudentDetail.jsp",
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
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=day&semester="+semester+"&section="+section+"&date="+date,
            success: function(msg){
                  $('#tabs-2').html(msg);
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
                                    url: "../Faculty/AjaxPages/StudentDetail.jsp",
                                    data:"student_id="+$(this).attr('title'),
                                    success: function(msg){
                                           $('#tooltip').html(msg)
                                    }
                                });
                        });
                  $('#status').html("<center>Loaded Successful</center>");
                  $('#date1').datepicker({ dateFormat: 'dd/mm/yy' });
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
    url="../Faculty/AjaxPages/Reports.jsp"
    $.ajax({
            type: "POST",
            url: url,
            data:"action=mark&semester="+semester+"&section="+section,
            success: function(msg){
                  $('#tabs-3').html(msg);
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
                                    url: "../Faculty/AjaxPages/StudentDetail.jsp",
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