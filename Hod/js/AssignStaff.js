/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
                    // Tabs
                    $('#tabs').tabs();
                   
                    $('#status').hide();
                    $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
                    //ViewStudents(1);
                     $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
                     
                });
var t
function clearmsg(){
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
    clearTimeout(t);
}

    function ShowDetails(sem){
        
        if(sem==""){
            $('#status').show();
            $('#status').html("Plase Select");
            $('#section').attr("disabled", "true")
            $('#Showfaculty').html("");
            t=setTimeout("clearmsg()",3000);

            return;
        }

        url="./AjaxPages/ShowAssignStaff.jsp";
        $('#status').show();
        $('#status').html("Loading...")
        $.ajax({
                type: "POST",
                url: url,
                data:"semester="+sem+"&action=view",
                success: function(msg){
                   
                    $('#SectionDiv').html($.trim(msg))
                    $('#SectionDiv').jqTransform({imgPath:'jqtransformplugin/img/'});
                    $('#status').html("<center>Loaded</center>");
                }
            });
            t=setTimeout("clearmsg()",3000);
    }

     function ShowStaff(sem){
        var section=encodeMyHtml($('#section').val());
        $('#status').show();
        $('#status').html("Loading...");
        url="./AjaxPages/ShowAssignStaff.jsp"
        $('#status').html("<center><img src='../images/loading.gif'/>Staff</center>");
        $.ajax({
                type: "POST",
                url: url,
                data:"section="+section+"&semester="+sem+"&action=show",
                success: function(msg){
                       $('#status').html("<center>Loaded</center>");
                       $('#Showfaculty').html(msg)
                       
                       t=setTimeout("clearmsg()",3000);
                }
            });
    }

    function getAssignedStaff(sem)
    {

        $('#status').show();
        $('#status').html("<center>Loading</center>");
        url="./AjaxPages/ShowAssignStaff.jsp"
        var arg="";
        $("#Showfaculty select").each(
        function(i,n) {
            if(n.id!="none"){
            arg=arg+n.id+"="+$("#"+n.id).val()+'&';
        }
      });
    arg=arg+"section="+$("#section").val();
     //alert(arg+"&action=Assign")
            $.ajax({
                type: "POST",
                url: url,
                data:arg+"&semester="+sem+"&action=Assign",
                success: function(msg){
                       //alert(msg)
                       $('#status').html(msg);
                       }
            });
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
   