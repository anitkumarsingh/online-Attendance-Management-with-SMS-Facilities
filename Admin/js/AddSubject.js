

 var delete_sem,delete_id;
function add(){

         if($.validate('addForm')==false)
            return;
        document.forms[0].submit();
}
 $(function(){
                   $('#tabs').tabs();

                   // $('#status').hide();
                    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
                    ViewSubject(1);
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
                                           $('#status').html("Deleting");
                                            url="./AjaxPages/ShowSubject.jsp"
                                             $.ajax({
                                                    type: "POST",
                                                    url: url,
                                                    data:"subject_id="+delete_id+"&action=delete",
                                                    success: function(msg){
                                                           $('#status').html(msg)
                                                           ViewSubject(delete_sem);
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

    function ViewSubject(sem){
         $('#status').show();
         $('#status').html('<img src=\'../images/loading.gif\'/>Loading...');
        url="./AjaxPages/ShowSubject.jsp"
            $.ajax({
                type: "POST",
                url: url,
                data:"semester="+sem+"&action=view",
                success: function(msg){

                       $('#SubjectDetail').html(msg)
                       $('#status').html("<center>Loading Completed</center>");
                }
            });
            t=setTimeout("clearmsg()",3000);
    }
     function DeleteSubject(id,semester){
       delete_sem=semester;
       delete_id=id;
       //alert("hi");
       $('#dialog').dialog('open');
    }

    function EditSubject(id){
          $('#status').show();
        url="./AjaxPages/ShowSubject.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Editing...</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"subject_id="+id+"&action=editview",
                success: function(msg){
                       $('#SubjectDetail').html(msg)
                       $('#SubjectDetail table').jqTransform({imgPath:'jqtransformplugin/img/'});
                        $('#status').html("<center><b>Loading Completed<b></center>");
                       t=setTimeout("clearmsg()",3000);
                      // ViewStudents(1);
                }
            });
    }

    function UpdateSubject(id,semester){
        if($.validate('updateForm')==false)
            return;
         $('#status').show();

        var subject_name= encodeMyHtml($('#subj_name').val());
        var elective =($('#electiveupdate').attr('checked')==true)?"YES":"null";
        var lab =($('#labupdate').attr('checked')==true)?"YES":"null";
      url="./AjaxPages/ShowSubject.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Updating ...</center>");
       //alert("subject_id="+id+"&subject_name="+subject_name+"&semester="+semester+"&elective="+elective+"&action=update")
         $.ajax({
                type: "POST",
                url: url,
                data:"subject_id="+id+"&subject_name="+subject_name+"&semester="+semester+"&elective="+elective+"&lab="+lab+"&action=update",
                success: function(msg){

                       $('#status').html(msg)
                       ViewSubject(semester);
                }
            });
    }

