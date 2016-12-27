/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * ramkumar onsept 25,2009 @10:54.27 AM
 */
function getSubjectGrid(){
     url="./AjaxPages/curriculam.jsp"
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=none",
                    success: function(msg){
                            $('#status').html("<center>Loaded Successful</center>");
                            //alert(msg)
                            $('#curriculam').show();
                            $('#curriculam').html(msg)
                            $('#report').hide();
                            smartColumns(280,130);
                            t=setTimeout("clearmsg()",3000);
                            }
     });
}
function getCourseOutline(subject_id,section){
     url="./AjaxPages/curriculam.jsp";
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");     
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=courseoutline&subject_id="+subject_id+"&section="+section,
                    success: function(msg){
                      //  alert(msg);
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#report').html(msg)
                            $("#curriculam").hide();
                            $("#report").show();
                            t=setTimeout("clearmsg()",3000);
                            }
     });
}

function getCourseProgress(subject_id,section){
//alert("action=courseprogress&subject_id="+subject_id+"&section="+section);
     url="./AjaxPages/curriculam.jsp";
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=courseprogress&subject_id="+subject_id+"&section="+section,
                    success: function(msg){
                      //  alert(msg);
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#report').html(msg)
                            $("#curriculam").hide();
                            $("#report").show();
                             $('.Table').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                            colWidths: [100,400,60,60,100]
                            });
                            t=setTimeout("clearmsg()",3000);
                            }
     });
}

function back(){
    $('#report').hide();
    $("#curriculam").show();
}
function getCourseCoverage(subject_id,section){
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
     url="./AjaxPages/curriculam.jsp";
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=coursecoverage&subject_id="+subject_id+"&section="+section,
                    success: function(msg){
                      //  alert(msg);
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#report').html(msg)
                            $("#curriculam").hide();
                            $("#report").show();
                            t=setTimeout("clearmsg()",3000);
                            }
     });
}

function getAdvanceAttendance(month,subject_id){
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");    
     url="./AjaxPages/curriculam.jsp";
     
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=advanceattendance&month="+month+"&subject_id="+subject_id,
                    success: function(msg){
                       // alert(msg);
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#report').html(msg)
                            $("#curriculam").hide();
                            $("#report").show();
                            t=setTimeout("clearmsg()",3000);
                            }
     });
}

function getStudentTimetable(semester,section){
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");    
      $.ajax({
                type: "POST",
                url: "../TimeTable/viewTimetable.jsp?semester="+semester+"&section="+section,
                success: function(msg){
                    $('#status').html("<center>Loaded Successful</center>");
                    $('#report').html(msg)
                    $("#curriculam").hide();
                    $("#report").show();
                    t=setTimeout("clearmsg()",3000);
               }
      });
}
function getStudentmarks(subject_id){
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");    
    url="./AjaxPages/curriculam.jsp";
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=studentmarks&subject_id="+subject_id,
                    success: function(msg){
                      //  alert(msg);
                            $('#status').html("<center>Loaded Successful</center>");
                            $('#report').html(msg)
                            $("#curriculam").hide();
                            $("#report").show();
                            t=setTimeout("clearmsg()",3000);
                            }
     });
}
/* INBOX */
var delete_id;

function deleteMail(id){
    delete_id=id;
     $('#dialog').dialog('open');
 }

function viewMail(id){
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
url="../Faculty/AjaxPages/inbox.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Opening Mail</center>");

$.ajax({
                type: "POST",
                url: url,
                data:"action=viewmail&id="+id,
                success: function(msg){
                        //alert(msg)
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#curriculam').html(msg)
                        t=setTimeout("clearmsg()",3000);
               }
 });

}
function loadInBox(){
url="../Faculty/AjaxPages/inbox.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading Assesment</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=inbox",
                success: function(msg){

                        $('#status').html("<center>Loaded Successful</center>");
                        $('#report').hide();
                        $('#curriculam').html(msg)
                        $('#curriculam').show();
                        $('#report').hide();
                        $('#grid').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                            colWidths: [200,400,100,100]
                        });
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
                                          $('#status').show();
                                         $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");    
                                        url="../Faculty/AjaxPages/inbox.jsp"
                                        $('#status').show();
                                        $('#status').html("<center><img src='../images/loading.gif'/>Opening Mail</center>");

                                        $.ajax({
                                                        type: "POST",
                                                        url: url,
                                                        data:"action=delete&id="+delete_id,
                                                        success: function(msg){

                                                                $('#status').html("<center>Loaded Successful</center>");
                                                                loadInBox();
                                                       }
                                         });
                       },
				Cancel: function() {
					$(this).dialog('close');
				}
			}
		});     
                       
               }
 });

}
function formatItem(row) {
		return row[0] + " (<strong>Name: " + row[1] + "</strong>)";
	}
	function formatResult(row) {
		return row[0].replace(/(<.+?>)/gi, '');
	}
function compose(){
url="../Faculty/AjaxPages/inbox.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading Assesment</center>");

$.ajax({
                type: "POST",
                url: url,
                data:"action=compose",
                success: function(msg){

                        $('#status').html("<center>Loaded Successful</center>");
                        $('#curriculam').html(msg)
                        new nicEditor().panelInstance('composedata');
                        $("#tolist").autocomplete("../Faculty/AjaxPages/search.jsp", {
                                width: 300,
                                multiple: true,
                                matchContains: true,
                                formatItem: formatItem,
                                formatResult: formatResult

                        });
                         document.getElementById('form1').onsubmit=function() {
                            document.getElementById('form1').target = 'inline'; //'upload_target' is the name of the iframe
                            }
                        t=setTimeout("clearmsg()",3000);
               }
 });


}
