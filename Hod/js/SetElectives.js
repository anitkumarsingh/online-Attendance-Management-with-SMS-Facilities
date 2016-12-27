/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var del_id;
    $(function(){
                    $('#tabs').tabs();                    
                    $('#status').hide();
                    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
                    ViewElective();
                    $('form').jqTransform({imgPath:'jqtransformplugin/img/'});
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
                                        url="./AjaxPages/ShowElective.jsp"
                                        $.ajax({
                                                type: "POST",
                                                url: url,
                                                data:"subject_id="+del_id+"&action=delete",
                                                success: function(msg){
                                                      // alert(msg)
                                                       $('#status').html(msg)
                                                       ViewElective();
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
    clearTimeout(t);
}

    function ViewElective(){
        //alert("./AjaxPages/ShowSubject.jsp?semester="+yr*2)
        url="./AjaxPages/ShowElective.jsp"
            $.ajax({
                type: "POST",
                url: url,
                data:"&action=view",
                success: function(msg){
                       $('#ElectiveDetail').html(msg)
                       $('#status').html("<center>Loading Completed</center>");
                       t=setTimeout("clearmsg()",3000);
                }
            });
            
    }
     function DeleteElective(id){
       // alert("./AjaxPages/ShowAllStudents.jsp?semester="+yr*2)
        del_id=id;
        $('#dialog').dialog('open');
    }