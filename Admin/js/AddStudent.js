
var delete_id;
function add(){

         if($.validate('addForm')==false)
            return;
        document.forms[0].submit();
}

 $(function(){
                    // Tabs
                    $('#tabs').tabs();

                    //$('#status').hide();
                    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
                    ViewStudents(1);
                    $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
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
                                            url="./AjaxPages/ShowAllStudents.jsp"
                                             $('#status').html("<center><img src='../images/loading.gif'/>Deleting Student</center>");
                                             $.ajax({
                                                    type: "POST",
                                                    url: url,
                                                    data:"student_id="+delete_id+"&action=delete",
                                                    success: function(msg){
                                                           $('#status').html(msg)
                                                           ViewStudents(1);
                                                    }
                                             });
                       },
				Cancel: function() {
					$(this).dialog('close');
				}
			}
		});
                });
var t
function clearmsg(){
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
  $(".error").hide();
    clearTimeout(t);
}

    function ViewStudents(yr){
        url="./AjaxPages/ShowAllStudents.jsp";
       // $('#tabs-2').html("<center><img src='../images/loading.gif'/></center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"semester="+yr*2+"&action=view",
                success: function(msg){
                       $('#StudentDetail').html(msg)
                       $('#status').html("<center>Loading Completed</center>");
                }
            });
            t=setTimeout("clearmsg()",3000);
    }
     function DeleteStudent(id){
        delete_id=id;
        $('#dialog').dialog('open');
    }

    function resetPassword(id){

                    $('#status').show();
                    url="./AjaxPages/ShowAllStudents.jsp"
                     $('#status').html("<center><img src='../images/loading.gif'/>Deleting Student</center>");
                     $.ajax({
                            type: "POST",
                            url: url,
                            data:"student_id="+id+"&action=reset_password",
                            success: function(msg){
                                   $('#status').html(msg)
                                   alert(msg)
                                   ViewStudents(1);
                            }
                     });
    }

     function EditStudent(id){
          $('#status').show();
        url="./AjaxPages/ShowAllStudents.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Editing...</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"student_id="+id+"&action=editview",
                success: function(msg){

                       $('#StudentDetail').html(msg)
                       $('#StudentDetail table').jqTransform({imgPath:'jqtransformplugin/img/'});
                        $('#status').html("<center><b>Loading Completed<b></center>");
                       t=setTimeout("clearmsg()",3000);
                      // ViewStudents(1);
                }
            });
    }

    function UpdateStudent(id,semester){
        if($.validate('updateForm')==false)
            return;
         $('#status').show();
        var student_name= encodeMyHtml($('#student_name').val());
        var semester=encodeMyHtml($('#semester').val());
        var section=encodeMyHtml($('#section').val());
        var batch=encodeMyHtml($('#editbatch').val());
      url="./AjaxPages/ShowAllStudents.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Updating ...</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"student_id="+id+"&student_name="+student_name+"&batch="+batch+"&section="+section+"&semester="+semester+"&action=update",
                success: function(msg){

                       $('#status').html(msg)
                       ViewStudents((semester)/2);
                }
            });
    }