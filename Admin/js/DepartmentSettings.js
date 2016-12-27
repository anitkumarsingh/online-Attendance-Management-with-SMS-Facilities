
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
                    ViewDept();
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
                                           $('#status').html("<center>Deleting...</center>");
                                            url="./AjaxPages/ShowDeptSetting.jsp"
                                             $.ajax({
                                                    type: "POST",
                                                    url: url,
                                                    data:"year="+delete_id+"&action=delete",
                                                    success: function(msg){
                                                            $('#status').html(msg)
                                                           ViewDept();
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

    function ViewDept(){

        url="./AjaxPages/ShowDeptSetting.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"&action=view",
                success: function(msg){
                       $('#DeptDetail').html(msg)
                       $('#status').html("<center>Loading Completed</center>");
                }
            });
             t=setTimeout("clearmsg()",3000);
    }
     function DeleteDept(id){
      delete_id=id;
      $('#dialog').dialog('open');
    }
      function EditDept(id){

         $('#status').show();
        url="./AjaxPages/ShowDeptSetting.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Editing...</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"year="+id+"&action=editview",
                success: function(msg){
                       $('#status').html("<center>Loaded</center>");
                       $('#DeptDetail').html(msg)
                       $('#DeptDetail table').jqTransform({imgPath:'jqtransformplugin/img/'});
                       t=setTimeout("clearmsg()",3000);
                      // ViewStudents(1);
                }
            });
    }

 function UpdateDept(id){

      if($.validate('form')==false)
            return;
     $('#status').show();
     url="./AjaxPages/ShowDeptSetting.jsp"
     var semester=encodeMyHtml($('#editsem').val());
     var section=encodeMyHtml($('#editsection').val());
     var elective=encodeMyHtml($('#editelective').val());
     var grade =($('#editgrade').attr('checked')==true)?"YES":"null";
     //alert("year="+id+"&semester="+semester+"&section="+section+"&elective="+elective+"&grade="+grade+"&action=update")
         $.ajax({
                type: "POST",
                url: url,
                data:"year="+id+"&semester="+semester+"&section="+section+"&elective="+elective+"&grade="+grade+"&action=update",
                success: function(msg){
                       $('#status').html(msg)
                       //alert(msg)
                       ViewDept();

                }
            });
    }