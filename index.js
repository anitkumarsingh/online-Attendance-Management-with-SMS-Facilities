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

function FacultyProfile(){
url="AjaxPages/FacultyProfile.jsp"
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        //alert("hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#top_div').html(msg)
                        $('#bottom_div').html("");


                   }
 });
}


