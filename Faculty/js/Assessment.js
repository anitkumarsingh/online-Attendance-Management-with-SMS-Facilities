/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/* Author: Dinesh Kumar
 * Created on : Aug 05, 2009, 2:38:17 PM
 * */
var del_sno;
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

function Assessment(){
url="AjaxPages/Assessment.jsp";
curpage=Assessment;
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading Assesment</center>");

$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg)
                        $('#addForm table').jqTransform({imgPath:'jqtransformplugin/img/'});
                        $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                        $('#tabs').tabs();
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
                                          url="AjaxPages/Assessment.jsp"
                                         $('#status').show();
                                         $('#status').html("<center><img src='../images/loading.gif'/>Deleting Assesment</center>");
                                         $.ajax({
                                                type: "POST",
                                                url: url,
                                                data:"sno="+del_sno+"&action=delete",
                                                success: function(msg){

                                                        $('#status').html("<center>Loaded Successful</center>");
                                                        $('#right').html(msg);
                                                        $('#tabs').tabs();
                                                        t=setTimeout("clearmsg()",3000);
                                                        Assessment();
                                               }
                                            });
                                },
                                Cancel: function() {
                                        $(this).dialog('close');
                                }
                        }
                });
                        t=setTimeout("clearmsg()",3000);
               }
 });
}

function AddAssessmentPlan(){

     curpage=AddAssessmentPlan;
     var type = encodeMyHtml($('#type').val());
     var date=encodeMyHtml($('#date').val());
     var weightage=encodeMyHtml($('#weightage').val());
     var marks=encodeMyHtml($('#marks').val());
     if($.validate('addForm')==false)
     return;
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Adding</center>");
     //alert("subj_id="+subj_id+"&section="+section+"&category="+category+"&topic="+topic+"&pl_date="+pl_date+"&pl_hr="+pl_hrs+"&ac_hr="+ac_hrs+"&sc_date="+ac_date+"&action=add")
     url="AjaxPages/Assessment.jsp"
     //$('#status').html("AjaxPages/CourseWork.jsp?subj_id="+subj_id+"&section="+section+"&category="+category+"&topic="+topic+"&pl_date="+pl_date+"&pl_hr="+pl_hrs+"&ac_hr="+ac_hrs+"&sc_date="+ac_date+"&action=view");
         $.ajax({
                type: "POST",
                url: url,
                data: "&type="+type+"&date="+date+"&weightage="+weightage+"&marks="+marks+"&action=add",
                success: function(msg){
                        $('#status').show();
                        $('#status').html("<center>Loaded Successful</center>");
                        Assessment();
            }
            });
    }

     function DeleteAssessmentPlan(sno){
        del_sno=sno;
         $('#dialog').dialog('open');
    }

 function UpdateAssessmentPlan(sno){
     if($.validate('addForm')==false)
         return;
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Updating Assesment</center>");
     var type = encodeMyHtml($('#edittype').val());
     var date=encodeMyHtml($('#editdate').val());
     var weightage=encodeMyHtml($('#editweightage').val());
     var marks=encodeMyHtml($('#editmarks').val());
     //alert("staff_id="+id+"&staff_name="+staff_name+"&username="+username+"&qualification="+qualification+"&title="+title+"&type="+type+"&action=update")
     url="AjaxPages/Assessment.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"sno="+sno+"&type="+type+"&date="+date+"&weightage="+weightage+"&marks="+marks+"&action=update",
                success: function(msg){
                        
                        $('#status').html("<center>Loaded Successful</center>");
                        Assessment()
                }
            });
    }

function EditAssessmentPlan(sno){
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Editing Assesment</center>");
        url="AjaxPages/Assessment.jsp"
        $.ajax({
                type: "POST",
                url: url,
                data:"sno="+sno+"&action=editview",
                success: function(msg){
                      
                       $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg);
                        $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
				//alert($('#date').val());
                        $('#editdate').datepicker({ dateFormat: 'dd/mm/yy' });
                        $('#tabs').tabs();
                        t=setTimeout("clearmsg()",3000);
                }
            });
    }
function getStudents(id){
$('#status').show();
url="AjaxPages/AssessmentMarks.jsp"
$('#status').html("<center><img src='../images/loading.gif'/>Loading Student List</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&examid="+id,
                success: function(msg){                        
                        $('#studentsDispaly').html(msg);
                        $('#tabs').tabs();
                        $('#status').html("<center>Loaded Successful</center>");
                        t=setTimeout("clearmsg()",3000);
                }
            });
}

function AssessmentMarks(){
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading Marks</center>");
url="AjaxPages/AssessmentMarks.jsp"
curpage=AssessmentMarks;
$.ajax({
                type: "POST",
                url: url,
                data:"action=list&rand="+Math.random(),
                success: function(msg){                    
                       $('#Select').html(msg);
                       $('#tabs').tabs();
                       $('#status').html("<center>Loaded Successful</center>");
                       t=setTimeout("clearmsg()",3000);
                }
            });
}

function AddMarks(id){

 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Adding Marks</center>");
url="AjaxPages/AssessmentMarks.jsp"
var arg="&";
 $("#studentsDispaly input[type=text]").each(
    function(i,n) {
        if(n.id!="none" || n.id!=undefined){
          arg=arg+n.id+"="+$("#"+n.id).val()+"&";
        }
      }
    );

         arg="action=add&examid="+id+arg;
        //$('#status').html(arg);
        $.ajax({
                type: "POST",
                url: url,
                data:arg,
                success: function(msg){
                       $('#status').show();
                       $('#status').html("<center>Loaded Successful</center>");
                       getStudents(id);
                }
            });
}

function ViewAssessment(){
url="AjaxPages/ViewAssessment.jsp"
curpage=ViewAssessment;
 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=list&rand="+Math.random(),
                success: function(msg){
                       $('#status').show();
                       $('#tabs-3').html(msg);
                       $('#tabs').tabs();
                        $('.Table').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                            colWidths: [50,200]
                            
                        });
                       $('#status').html("<center>Loaded Successful</center>");
                       t=setTimeout("clearmsg()",3000);
                }
            });
}