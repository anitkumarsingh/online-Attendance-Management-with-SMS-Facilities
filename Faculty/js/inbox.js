/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * 23 aug 11.02 pm
 */
 
 var del_id;
function deleteMail(id){
del_id=id;
$('#dialog').dialog('open');
}
function viewMail(id){
url="AjaxPages/inbox.jsp"
curpage=loadInBox;
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Opening Mail</center>");

$.ajax({
                type: "POST",
                url: url,
                data:"action=viewmail&id="+id,
                success: function(msg){
                        //alert(msg)
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg)
                        t=setTimeout("clearmsg()",3000);
               }
 });

}
function loadInBox(){
url="AjaxPages/inbox.jsp"
curpage=loadInBox;
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading Assesment</center>");

$.ajax({
                type: "POST",
                url: url,
                data:"action=inbox",
                success: function(msg){
                    
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg)
                        $('#grid').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                            colWidths: [200,400,100,100]
                        });
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
                                         url="AjaxPages/inbox.jsp"
                                            curpage=loadInBox;
                                            $('#status').show();
                                            $('#status').html("<center><img src='../images/loading.gif'/>Opening Mail</center>");

                                            $.ajax({
                                                            type: "POST",
                                                            url: url,
                                                            data:"action=delete&id="+del_id,
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
                        t=setTimeout("clearmsg()",3000);
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
url="AjaxPages/inbox.jsp"
curpage=compose;
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading Assesment</center>");

$.ajax({
                type: "POST",
                url: url,
                data:"action=compose",
                success: function(msg){

                        $('#status').html("<center>Loaded Successful</center>");
                        $('#right').html(msg)
                        new nicEditor().panelInstance('composedata');
                        $("#tolist").autocomplete("AjaxPages/search.jsp", {
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
