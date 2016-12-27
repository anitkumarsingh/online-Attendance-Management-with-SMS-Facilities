
 function onduty(){
     $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Retriving Permission...</center>");
    url="./AjaxPages/facultysetup.jsp";
         $.ajax({
                type: "POST",
                url: url,
                data:"&action=odform",
                success: function(msg){
                       $('#tabs-4').html(msg)
                       $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
                       $('#status').html("<center>Loaded Successful</center>");
                       t=setTimeout("clearmsg()",3000);
                }
            });
}
function addODIncharge(){
    $('#status').html("<center><img src='../images/loading.gif'/>Retriving Permission...</center>");
    url="./AjaxPages/facultysetup.jsp"
    var semester=$('#year').val();
    var section=$('#section').val();
    var staff_id=$('#staff_id').val();
         $.ajax({
                type: "POST",
                url: url,
                data:"&semester="+semester+"&section="+section+"&staff_id="+staff_id+"&action=addODForm",
                success: function(msg){
                    //$('#tabs-4').html(msg)
                    onduty();
                }
            });
}
function deleteIncharge(staff_id,semester,section){
    $('#status').html("<center><img src='../images/loading.gif'/>Retriving Permission...</center>");
    var url="./AjaxPages/facultysetup.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"&semeter="+semester+"&section="+section+"&staff_id="+staff_id+"&action=deleteincharge",
                success: function(msg){
                      onduty();
                }
            });
}

var delete_id;
function setpermission(){
    var arg="items=";
    var count=0;
     $("input:checked").each(
    function(i,n) {
        if(n.id!="none"){
          arg=arg+n.id+'~';
          count++;
        }
      }
    );
//alert(arg)
         url="./AjaxPages/facultysetup.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"action=add&count="+count+"&"+arg,
                success: function(msg){
                       //$('#tabs-3').html(msg)
                       $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
                       $('#status').html("<center>Loaded Successful</center>");
                       permission();
                       t=setTimeout("clearmsg()",3000);
                }
            });
}
function permission(){
    url="./AjaxPages/facultysetup.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"&action=view",
                success: function(msg){
                       $('#tabs-3').html(msg)
                        $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
                       $('#status').html("<center>Loaded Successful</center>");
                       t=setTimeout("clearmsg()",3000);
                }
            });

}
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
                    ViewStaff();
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
                                         $('#status').html("<center><img src='../images/loading.gif'/>Deleting...</center>");
                                         url="./AjaxPages/ShowStaff.jsp"
                                             $.ajax({
                                                    type: "POST",
                                                    url: url,
                                                    data:"staff_id="+delete_id+"&action=delete",
                                                    success: function(msg){
                                                            $('#status').html(msg)
                                                             ViewStaff();
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

    function ViewStaff(){
       // alert("./AjaxPages/ShowAllStudents.jsp?semester="+yr*2)
        url="./AjaxPages/ShowStaff.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"&action=view",
                success: function(msg){
                       $('#StaffDetail').html(msg)
                       $('#status').html("<center>Loaded Successful</center>");
                        t=setTimeout("clearmsg()",3000);
                }
            });

    }
     function DeleteStaff(id){
         //alert("hi")
         delete_id=id;
         $('#dialog').dialog('open');
    }
      function EditStaff(id){

          $('#status').show();
        url="./AjaxPages/ShowStaff.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Editing...</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"staff_id="+id+"&action=editview",
                success: function(msg){
                       $('#StaffDetail').html(msg);
                       $('#status').html("loaded");
                       $('#StaffDetail table').jqTransform({imgPath:'jqtransformplugin/img/'});
                       t=setTimeout("clearmsg()",3000);
                      // ViewStudents(1);
                }
            });
    }
 function resetStaffPassword(id){
        alert("hi")
        $('#status').show();
         $('#status').html("<center><img src='../images/loading.gif'/>Deleting...</center>");
         url="./AjaxPages/ShowStaff.jsp"
             $.ajax({
                    type: "POST",
                    url: url,
                    data:"staff_id="+id+"&action=reset_password",
                    success: function(msg){
                            $('#status').html(msg)
                            alert(msg)
                             ViewStaff();
                    }
                });
    }

 function UpdateStaff(id){
       if($.validate('form')==false)
            return;
     $('#status').show();
     var staff_name= encodeMyHtml($('#staff_name').val());
     var username=encodeMyHtml($('#user_name').val());
     var qualification=encodeMyHtml($('#qual').val());
     var designation=encodeMyHtml($('#desig').val());
     var type=encodeMyHtml($('#usertype').val());
     var etitle = encodeMyHtml($('#edit_title').val());
     //alert("staff_id="+id+"&staff_name="+staff_name+"&username="+username+"&qualification="+qualification+"&type="+type+"&action=update")
      // alert("designation="+designation)
        url="./AjaxPages/ShowStaff.jsp"
         $.ajax({
                type: "POST",
                url: url,
                data:"staff_id="+id+"&title="+etitle+"&designation="+designation+"&staff_name="+staff_name+"&username="+username+"&qualification="+qualification+"&type="+type+"&action=update",
                success: function(msg){
                       //alert(msg)
                       $('#status').html(msg)
                       ViewStaff();
                }
            });
    }