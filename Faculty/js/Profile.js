/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


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

function Profile(){
url="AjaxPages/Profile.jsp"
$('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Loading</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        //alert("hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#right').html(msg)
                        $('#tabs').tabs();
                        $('#status').html("<center>Loaded Successfully</center>");
                         t=setTimeout("clearmsg()",3000);

                   }
 });
}

function addInfoStaff(){

  if($.validate('tabs-1')==false)
            return;
        $('#status').show();
    $('#status').html("<center><img src='../images/loading.gif'/>Updating</center>");
url="AjaxPages/Profile.jsp"
     var name = encodeMyHtml($('#staffname').val());
     var qualification=encodeMyHtml($('#qualification').val());
     var designation=encodeMyHtml($('#designation').val());
     var subj_handled=encodeMyHtml($('#subj_handeled').val());
     var aos=encodeMyHtml($('#area_specialization').val());
     var email=encodeMyHtml($('#email').val());
     var phone=encodeMyHtml($('#ph_no').val());
     var aboutu=encodeMyHtml($('#aboutu').val());
     var title=encodeMyHtml($('#title').val());
//alert("name="+name+"&qual="+qualification+"&desig="+designation+"&subj_handled="+subj_handled+"&aos="+aos+"&email="+email+"&phone="+phone+"&aboutu="+aboutu+"&action=addInfo");
$.ajax({
                type: "POST",
                url: url,
                data:"name="+name+"&title="+title+"&qual="+qualification+"&desig="+designation+"&subj_handled="+subj_handled+"&aos="+aos+"&email="+email+"&phone="+phone+"&aboutu="+aboutu+"&action=addInfoStaff",
                success: function(msg){
                        //alert("hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#tabs-1').html(msg)
                        $('#tabs').tabs();
                        Profile()
                   }
 });
}

function changePass(){
if(!$.validate('form'))
    return;
url="AjaxPages/Profile.jsp";
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Changing Password</center>");
$('#status').show();
var new_pass = encodeMyHtml($('#password').val());
var old_pass =encodeMyHtml($('#oldpass').val());
$.ajax({
                type: "POST",
                url: url,
                data:"action=changePass&oldpass="+old_pass+"&newpass="+new_pass+"&rand="+Math.random(),
                success: function(msg){
                        //alert(msg)
                        $('#status').html("<center>"+msg+"</center>");
                        $('#password').val("");
                        $('#oldpass').val("");
                        $('#confirmpassword').val("");
                        $('#status').html("<center>Loaded Successfully</center>");
                         t=setTimeout("clearmsg()",3000);
                        //alert(msg)
                }
 });
}