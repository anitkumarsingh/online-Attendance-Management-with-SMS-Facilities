/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/* Author: Dinesh Kumar
 * Date: July 28,2009 *
 * */
var del_sno;
 function DeleteCoursePlan(sno){
     del_sno=sno
$('#dialog').dialog('open');

    }

 function UpdateCoursePlan(sno){
     if($.validate('hor-minimalist-b')==false)
            return;
     $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Updating</center>");

     var category = encodeMyHtml($('#edit_category').val());
     var topic=encodeMyHtml($('#edit_topic').val());
     var pl_hrs=encodeMyHtml($('#edit_pl_hr').val());
     
     //alert("staff_id="+id+"&staff_name="+staff_name+"&username="+username+"&qualification="+qualification+"&title="+title+"&type="+type+"&action=update")
     url="AjaxPages/CoursePlan.jsp"
             $.ajax({
                type: "POST",
                url: url,
                data:"sno="+sno+"&category="+category+"&topic="+topic+"&pl_hr="+pl_hrs+"&action=update",
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        CoursePlan();
                }
            });
    }

function EditCoursePlan(sno){

        url="AjaxPages/CoursePlan.jsp";
        $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Editing</center>");
        $.ajax({
                type: "POST",
                url: url,
                data:"sno="+sno+"&action=editview",
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg);
                        $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
                        $('#date').datepicker();
                        $('#tabs').tabs();
                        t=setTimeout("clearmsg()",3000);
                }
            });
    }

 function AddCoursePlan(){
     //curpage=AddCoursePlan;
     var category = encodeMyHtml($('#category1').val()+"#"+$('#category2').val()+"#"+$('#category3').val()+"#"+$('#category4').val()+"#"+$('#category5').val());
     var topic=encodeMyHtml($('#topic1').val()+"#"+$('#topic2').val()+"#"+$('#topic3').val()+"#"+$('#topic4').val()+"#"+$('#topic5').val());
     var pl_hrs=encodeMyHtml($('#pl_hr1').val()+"#"+$('#pl_hr2').val()+"#"+$('#pl_hr3').val()+"#"+$('#pl_hr4').val()+"#"+$('#pl_hr5').val());
     //alert("category="+category+"&topic="+topic+"&pl_date="+pl_date+"&pl_hr="+pl_hrs+"&ac_hr="+ac_hrs+"&ac_date="+ac_date+"&action=view")
        url="AjaxPages/CoursePlan.jsp"
    //    if($.validate('addForm')==false)
    //        return;
         $('#status').show();
         $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
         $.ajax({
            type: "POST",
            url: url,
            data: "category="+category+"&topic="+topic+"&pl_hr="+pl_hrs+"&action=view",
            success: function(msg){
                    //alert(msg)
                    //$('#status').html("<center>Loaded Successful</center>");
                    CoursePlan();
                    //alert(msg);
                    //$('#right').html(msg);
                    //$('#date').datepicker();
                    //$('#tabs').tabs();
                    //t=setTimeout("clearmsg()",3000);
        }
        });
        //$('#status').html("AjaxPages/CourseWork.jsp?subj_id="+subj_id+"&section="+section+"&category="+category+"&topic="+topic+"&pl_date="+pl_date+"&pl_hr="+pl_hrs+"&ac_hr="+ac_hrs+"&sc_date="+ac_date+"&action=view");
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
function CoursePlan(){
    $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");

url="AjaxPages/CoursePlan.jsp"
curpage=CoursePlan;
var layout;
var tab2;
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                   
                   // alert(msg)
                       layout=msg;
                       
                       url="AjaxPages/CourseOutline.jsp"
                        $.ajax({
                                        type: "POST",
                                        url: url,
                                        data:"action=none&rand="+Math.random(),
                                        success: function(msg){
                                               tab2=msg
                                                 url="AjaxPages/CourseCoverage.jsp"
                                                $.ajax({
                                                                type: "POST",
                                                                url: url,
                                                                data:"action=none&rand="+Math.random(),
                                                                success: function(msg){
                                                                    $('#right').html(layout)
                                                                     $('#addForm table').jqTransform({imgPath:'jqtransformplugin/img/'});
                                                                     
                                                                        $('#tabs').tabs();
                                                                        $('#tabs-2').html(tab2)
                                                                       $('#tabs-3').html(msg)                                                                      
                                                                       //nicEditors.allTextAreas() ;
                                                                       new nicEditor().panelInstance('area3');
                                                                       new nicEditor().panelInstance('syllabus');
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
                                                                                                 $('#status').show();
                                                                                                 $('#status').html("<center><img src='../images/loading.gif'/>Deleting</center>");
                                                                                                        url="AjaxPages/CoursePlan.jsp"
                                                                                                         $.ajax({
                                                                                                                type: "POST",
                                                                                                                url: url,
                                                                                                                data:"sno="+del_sno+"&action=delete",
                                                                                                                success: function(msg){
                                                                                                                          $('#status').html("<center>Successfully Deleted</center>");
                                                                                                                        t=setTimeout("clearmsg()",3000);
                                                                                                                        CoursePlan();
                                                                                                                        //$('#right').html(msg);
                                                                                                                        //$('#date').datepicker();
                                                                                                                        //$('#tabs').tabs();

                                                                                                               }
                                                                                                            });
                                                                               },
                                                                                        Cancel: function() {
                                                                                                $(this).dialog('close');
                                                                                        }
                                                                                }
                                                                        });
                                                                       $('#status').html("<center>Loaded Successfully</center>");
                                                                 }
                                                 });

                                         }
                                    });
                       }
   });


     

t=setTimeout("clearmsg()",3000);
}
 
function CourseOutline(){
    curpage=CourseOutline;
    ViewCourseOutline();
}

function AddCourseOutline(){
 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Adding</center>");
     var course_outline = encodeMyHtml(nicEditors.findEditor('area3').getContent());
     //curpage=AddCourseOutline;
     url="AjaxPages/CourseOutline.jsp"
      
           $.ajax({
                type: "POST",
                url: url,
                data: "course_outline="+course_outline+"&action=add",
                success: function(msg){
                       $('#status').html("<center>Added Successful</center>");
                        nicEditors.findEditor('area3').setContent(msg);
                        t=setTimeout("clearmsg()",3000);
                 }
            });

    }

function ViewCourseOutline(){
     url="AjaxPages/CourseOutline.jsp"
     $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
    curpage=ViewCourseOutline;
         $.ajax({
                type: "POST",
                url: url,
                data: "&action=view",
                success: function(msg){
                   // alert($.trim(msg))
                    nicEditors.findEditor('area3').setContent(msg);
                    $('#status').html("<center>Loaded Successfully</center>");
                    t=setTimeout("clearmsg()",3000);
            }
            });

    }


function CourseCoverage(){
    curpage=CourseCoverage;
    ViewCourseCoverage();
}

function AddCourseCoverage(){
     var data = encodeMyHtml(nicEditors.findEditor('syllabus').getContent());
    // curpage=AddCourseCoverage;
     $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
     url="AjaxPages/CourseCoverage.jsp"
           $.ajax({
                type: "POST",
                url: url,
                data: "data="+data+"&action=add",
                success: function(msg){
                       $('#status').html("<center>Loaded Successful</center>");
                        nicEditors.findEditor('syllabus').setContent(msg);
                        $('#status').html("<center>Loaded Successfully</center>");
                        t=setTimeout("clearmsg()",3000);
                 }
            });

    }

function ViewCourseCoverage(){
     url="AjaxPages/CourseCoverage.jsp"
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
curpage=ViewCourseCoverage;
         $.ajax({
                type: "POST",
                url: url,
                data: "&action=view",
                success: function(msg){
                     
                     $('#status').html("<center>Loaded Successfully</center>");
                     nicEditors.findEditor('syllabus').setContent(msg);
                     t=setTimeout("clearmsg()",3000);
            }
            });

    }

 function CourseDelivery(){
    curpage=CourseDelivery;
    ViewCourseDelivery();
}

 function ViewCourseDelivery(){
     url="AjaxPages/CourseDelivery.jsp"
     $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
    curpage=ViewCourseDelivery;
         $.ajax({
                type: "POST",
                url: url,
                data: "&action=view",
                success: function(msg){
                   //alert($.trim(msg))
                   $('#status').html("<center>Loaded Successfully</center>");
                   t=setTimeout("clearmsg()",3000);
                   $('#tabs-4').html(msg);
                   $('.dates').datepicker({ dateFormat: 'dd/mm/yy' ,showOn: 'button', buttonImage: '../images/calendar.gif', buttonImageOnly: true  });
                   //
            }
            });
    }

function UpdateCourseDelivery(sno){
 url="AjaxPages/CourseDelivery.jsp"
 $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
 var ac_hr = encodeMyHtml($('#ac_hr'+sno ).val());
 var acdate = encodeMyHtml($('#date'+sno).val());
 //alert("sno="+sno+"&ac_hr="+ac_hr+"&date="+acdate+"&action=update")
 $.ajax({
            type: "POST",
            url: url,
            data: "sno="+sno+"&ac_hr="+ac_hr+"&ac_date="+acdate+"&action=update",
            success: function(msg){
                //alert(msg);
                CourseDelivery();
                $('#date').datepicker();
        }
        });
 
}

 function CourseProgress(){
    curpage=CourseProgress;
    ViewCourseProgress();
}

 function ViewCourseProgress(){
     url="AjaxPages/CourseProgress.jsp"
     $('#status').show();
 $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
    curpage=ViewCourseProgress;
         $.ajax({
                type: "POST",
                url: url,
                data: "&action=view",
                success: function(msg){
                   //alert($.trim(msg))
                   $('#status').html("<center>Loaded Successfully</center>");
                   t=setTimeout("clearmsg()",3000);
                   $('#tabs-5').html(msg)
                    $('.Table').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                            colWidths: [100,300]
                            });
            }
            });
    }