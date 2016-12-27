

 $(document).ready(function(){
                   $('#tabs').tabs();
                    $('#status').hide();
                    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
                     $("#dialog").dialog({
			bgiframe: true,
			resizable: false,
			height:255,
                        width: 485,
			modal: true,
                        autoOpen: false,
			overlay: {
				backgroundColor: '#000',
				opacity: 0.5
			},
			buttons: {
				'Continue': function() {
                                         $('#status').show();
                                         $('#status').html("<center><img src='../images/loading.gif'/>It Take Long Time To Switch...</center>");
                                         $('#switch').attr('disabled', 'disabled');

                                         $(this).dialog('close');
                                         url="./AdminProfile.jsp"
                                         $('#status').html("<center><img src='../images/loading.gif'/>Switching to New Semester</center>");
                                         $.ajax({
                                                type: "POST",
                                                url: url,
                                                data:"action=switch&db_name="+$('#year').val()+$('#semtype').val()+"&alias="+$('#alias').val(),
                                                success: function(msg){
                                                       //alert("You have sucessfull Switched Semester");
                                                       $('#status').html("<center>Switched Sucessfully</center>");
                                                       t=setTimeout("clearmsg()",3000);
                                                       $('#switch').removeAttr('disabled');
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

function addnews(){
    var url="./AdminProfile.jsp";
    //alert($('#msg').val());
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
    $.ajax({
            type: "POST",
            url: url,
            data:"action=addnews&data="+$('#msg').val(),
            success: function(msg){
                $('#status').html("<center>Loaded</center>");
                t=setTimeout("clearmsg()",3000);
                $('#news').html(msg)
            }
        });
}
function deletenews(id){
    var url="./AdminProfile.jsp";
    //alert($('#msg').val());
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
    $.ajax({
            type: "POST",
            url: url,
            data:"action=delete&id="+id,
            success: function(msg){
                //$('#news').html(msg)
                $('#status').html("<center>Deleted</center>");
                addnews();
            }
        });
}

function NewSemester()
{

    $('#dialog').dialog('open');

}