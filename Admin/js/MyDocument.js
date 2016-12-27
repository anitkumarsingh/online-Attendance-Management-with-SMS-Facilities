
var delete_name,delete_type;
$(function(){
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
                                        var data="";
                                        if(delete_type=="dir")
                                            data="rmfile="+delete_name
                                        else
                                            data="rmdir="+delete_name
                                     $.ajax({
                                                    type: "POST",
                                                    url: "MyDocument.jsp",
                                                    data:data,
                                                    success: function(msg){
                                                           //alert(msg)
                                                           if(delete_type=="dir")
                                                               browse('none');
                                                           else
                                                               browse($('#directory').val());
                                                    }
                                                });
                       },
				Cancel: function() {
					$(this).dialog('close');
				}
			}
		});
                });

function clearmsg(){

  $(".status").hide();
    clearTimeout(t);
}

function createDir(){
    $('#status').show();
    $('#status').html('<img src=\'../images/loading.gif\'/>Loading...');
    $.ajax({
                type: "POST",
                url: "MyDocument.jsp",
                data:"create="+$('#new_dir').val(),
                success: function(msg){
                    browse('none');
                    $('#status').html("<center><b>Loading Completed<b></center>");
                }
            });
}
function deleteFile(name,type){

    delete_name=name;
    delete_type=type;
    $('#dialog').dialog('open');
}

