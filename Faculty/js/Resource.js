/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var del_name;
function toggle(){
    $('#ddltitle:hidden').show(function(){
        $('#desc').hide();
        return;
    });
    //$('#desc').show();
    $('#desc:hidden').show(function(){
        $('#ddltitle').hide();
        return;
    });
    //alert("hi");
}
function SubjectResources(){
    $('#status').show();
    curpage=SubjectResources;
    url="AjaxPages/ShowResources.jsp"
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=subject&rand="+Math.random(),
                    success: function(msg){
                       // alert(msg);
                           $('#right').html(msg)
                           $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                           // $('#inline').hide();
                           document.getElementById('form1').onsubmit=function() {
                            document.getElementById('form1').target = 'inline'; //'upload_target' is the name of the iframe
                            }
                            
                           $('#status').html("<center>Loaded Successful</center>");
                            t=setTimeout("clearmsg()",3000);
                    }
    });
}
function suggession(){
	
	$('#status').show();
    url="AjaxPages/ShowResources.jsp"
    $('#status').html("<center><img src='../images/loading.gif'/>Loading Article List</center>");
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=autosuggestion&unit="+$('#category').val()+"&rand="+Math.random(),
                    success: function(msg){
                       // alert(msg);
                           $('#autosuggestion').html(msg);                                               
                           $('#status').html("<center>Loaded Successful</center>");
                            t=setTimeout("clearmsg()",3000);
			 }
                    
    });

}
function ArticleResources(){
    curpage=ArticleResources;
    $('#status').show();
    url="AjaxPages/ShowResources.jsp"
    $('#status').html("<center><img src='../images/loading.gif'/>Loading Article List</center>");
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=article&rand="+Math.random(),
                    success: function(msg){
                       // alert(msg);
                           $('#right').html(msg);
                            //$('#inline').hide();
                           document.getElementById('form1').onsubmit=function() {
                            document.getElementById('form1').target = 'inline'; //'upload_target' is the name of the iframe
                            }
                            
                           $('#status').html("<center>Loaded Successful</center>");
                            t=setTimeout("clearmsg()",3000);
                    }
    });
}
function ViewSubjectResource(){
    curpage=ViewSubjectResource;
    $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading Subject Resources</center>");
    url="AjaxPages/ShowResources.jsp"
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=viewresource&rand="+Math.random(),
                    success: function(msg){
                        //alert(msg);
                       $('#right').html($.trim(msg))
                       $('#status').html("<center>Loaded Successful</center>");
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
                                                             $('#status').html("<center><img src='../images/loading.gif'/>Deleting Resource</center>");
                                                             url="AjaxPages/ShowResources.jsp"
                                                            $.ajax({
                                                                            type: "POST",
                                                                            url: url,
                                                                            data:"action=deleteresource&filename="+del_name+"&rand="+Math.random(),
                                                                            success: function(msg){

                                                                              ViewSubjectResource();
                                                                              $('#status').html("<center>Loaded Successful</center>");
                                                                            }
                                                            });
                                                },
                                                Cancel: function() {
                                                        $(this).dialog('close');
                                                }
                                        }
                                });
                        t=setTimeout("clearmsg()",3000);
                        $('.Table').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                             colWidths: [100,200,75,100,50]
                            
                        });
                    }
    });
}
function deleteresource(filename){
    
    del_name=filename;
     $('#dialog').dialog('open');
     
}
function ViewArticle(){
    url="AjaxPages/ShowResources.jsp"
    $.ajax({
                    type: "POST",
                    url: url,
                    data:"action=viewarticle&rand="+Math.random(),
                    success: function(msg){
                       // alert(msg);
                       $('#right').html($.trim(msg))
                       $('#status').html("<center>Loaded Successful</center>");
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
                                                            url="AjaxPages/ShowResources.jsp";
                                                            $('#status').show();
                                                            $('#status').html("<center><img src='../images/loading.gif'/>Deleting Article</center>");
                                                           
                                                            $.ajax({
                                                                            type: "POST",
                                                                            url: url,
                                                                            data:"action=deletearticle&filename="+del_name+"&rand="+Math.random(),
                                                                            success: function(msg){
                                                                              $('#status').html("<center>Deleted Successfully</center>");
                                                                              ViewArticle();
                                                                            }
                                                            });
                                                                                                        },
                                                Cancel: function() {
                                                        $(this).dialog('close');
                                                }
                                        }
                                });
                        t=setTimeout("clearmsg()",3000);
                        $('.Table').ingrid({
                            initialLoad: false,
                            sorting: false,
                            paging: false,
                             colWidths: [150,200]
                            
                        });
                    }
    });
}
function deleteArticle(filename){
    del_name=filename;
     $('#dialog').dialog('open');
}