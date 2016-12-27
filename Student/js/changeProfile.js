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
url="AjaxPages/changeProfile.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#curriculam').show();
                        $('#curriculam').html(msg)
                        $('#tabs').tabs();
                        $('#report').hide();                        
                        t=setTimeout("clearmsg()",3000);
                   }
 });
}

function addInfo(){
url="AjaxPages/changeProfile.jsp"
     var sslc = encodeMyHtml($('#sslc').val());
     var hsc  =encodeMyHtml($('#hsc').val());
     var ug_univ=encodeMyHtml($('#uguniv').val());
     var ug_dept=encodeMyHtml($('#ugdept').val());
     var ug_perct=encodeMyHtml($('#ug').val());
     var email=encodeMyHtml($('#email').val());
     var phone=encodeMyHtml($('#ph_no').val());
     var address=encodeMyHtml($('#address').val());
     $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Saving ...</center>");
//alert("name="+name+"&qual="+qualification+"&desig="+designation+"&subj_handled="+subj_handled+"&aos="+aos+"&email="+email+"&phone="+phone+"&aboutu="+aboutu+"&action=addInfo");
$.ajax({
                type: "POST",
                url: url,
                data:"sslc="+sslc+"&hsc="+hsc+"&uguniv="+ug_univ+"&ugdept="+ug_dept+"&ug_perct="+ug_perct+"&email="+email+"&phone="+phone+"&address="+address+"&action=addInfo",
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#curriculam').html(msg)
                        //changeProfile();
                        $('#tabs').tabs();
                        Profile();
                   }
 });
}

function changePassword(){
if(!$.validate('form'))
    return;
url="AjaxPages/changeProfile.jsp";
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
var new_pass = encodeMyHtml($('#password').val());
var old_pass =encodeMyHtml($('#oldpass').val());
$.ajax({
                type: "POST",
                url: url,
                data:"action=changePass&oldpass="+old_pass+"&newpass="+new_pass+"&rand="+Math.random(),
                success: function(msg){
                        $('#status').html("<center>"+msg+"</center>");
                        $('#password').val("");
                        $('#oldpass').val("");
                        $('#confirmpassword').val("");
                        t=setTimeout("clearmsg()",3000);
                }
 });
}