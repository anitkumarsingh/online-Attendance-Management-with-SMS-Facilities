<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery.js"></script>
<script src="../js/login.js"></script>
<title>Garc</title>

<script>
$(document).ready( function() {
$("#login").hide();
 });

 function loginvalidation(){
 var username=document.getElementById("username").value;
 var pass=document.getElementById("password").value;
 alert(("In guidelines ");
$('#err').html("Please Wait ...")
  $.ajax({
                type: "POST",
                url: "./common/loginvalidation.jsp",
                data: "username="+username+"&password="+pass,
                success: function(msg){
                    if(jQuery.trim(msg)=='error')
                         $('#err').html("User Name / Password is incorrect");
                   else{
                       $('#err').html("Login Successful")
                         window.location=msg;
                   }
                }
            });
 }
</script>
<%@ include file="/common/servertime.jsp" %>
</head>

<body>
<div class="overlay" id="login">
		<span class="logo4">SUWEGA</span>


		<span style="position:relative;margin:10px 0 0 10% ;text-align: left;color:white"  >
		User Name <input name="username" type="text" class="smalltext" id="username" />
		Password <input name="password" type="password" class="smalltext" id="password"/>
		<input name="Submit1" type="button" value="Login"  class="smallbutontext" onclick="loginvalidation()"/>
		</span>
                <span class="error" id="err"></span> | <span class="error" id="err" style="cursor:hand" onclick='$("#login").toggle(200)'> X </span>	</div>
    <div class="options" align="right">
		<a href="#" onclick='$("#login").toggle(200)'>Login </a> | <a href="#">Library </a> | <a href="#">Result Analyser</a>
	</div>
<div id="top_wrapper">
	<div id="banner">


	<div id="logo">
			<div class="logo1">SUWEGA</div>
			<div class="logo2">Resource Center</div>
			<div class="logo3"><%=dept%></div>
		</div>
	<div id="Search_box"><center><%=college%></center></div>

    <div id="servertime" align="right">Time</div>
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li><a href="../index.jsp">Home</a></li>
                            <li><a href="#">Achievemnts</a></li>
                            <li><a href="FacultyProfile.jsp">Faculty Profile</a></li>
                            <li><a href="#">Guidelines</a></li>
                            <li><a href="#">Gallery</a></li>
                	</ul>
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  <div id="top_div">
      <br/>
		<h1>Do's</h1>
		<div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">
	    <p id="plaintext"><strong>1. </strong>Be in time for class</p>
            <p id="plaintext"><strong>2. </strong>Keep your surroundings (room, walls, corridors etc.) clean</p>
            <p id="plaintext"><strong>3. </strong>Appear in all the internal examinations</p>
            <p id="plaintext"><strong>4. </strong> Handle all the campus resources carefully</p>
            <p id="plaintext"><strong>5. </strong>Be attentive to and appreciative of the visitors</p>
            <p id="plaintext"><strong>6. </strong>Participate in the lectures / presentation given by the faculty (external as well as internal)</p>
            <p id="plaintext"><strong>7. </strong>Dress decently</p>
            <p id="plaintext"><strong>8. </strong>Switch the fans & lights off when classroom is not in use</p>
            <p id="plaintext"><strong>9. </strong>Approach faculty / Mentor for Counseling</p>
            <p id="plaintext"><strong>10. </strong>Inform the concerned authority about mishaps and accidents</p>
<br/>
            <h1>Dont's</h1>
            <p id="plaintext"><strong>1. </strong> Being absent on the reopening day after the vacation (Summer & Winter)</p>
            <p id="plaintext"><strong>2. </strong>Being late for the class after breaks (Lunch & Tea)</p>
            <p id="plaintext"><strong>3. </strong>Having a non-serious attitude towards studies and campus in general</p>
            <p id="plaintext"><strong>4. </strong>Having lack of commitment to the institution</p>
            <p id="plaintext"><strong>5. </strong>Being absent without prior intimation</p>
            <p id="plaintext"><strong>6. </strong>Being absent during the internal examinations / tests</p>
            <p id="plaintext"><strong>7. </strong>Being absent a day before internals / Presentations etc</p>
            <p id="plaintext"><strong>8. </strong>Littering the class rooms & corridors</p>
            <p id="plaintext"><strong>9. </strong>Talking during guest lecture</p>
            <p id="plaintext"><strong>10. </strong>Talking in the classroom during lectures</p>
            <p id="plaintext"><strong>11. </strong>Talking in the library in a loud voice</p>
            <p id="plaintext"><strong>12. </strong> Using cell phones in the classroom, lab & the library</p>
            <p id="plaintext"><strong>13. </strong>Being absent during the College functions (College Days & Sports Day)</p>
            <p id="plaintext"><strong>14. </strong>Staining the campus premises</p>
            <p id="plaintext"><strong>15. </strong>Misbehaving in the bus, class and campus in general</p>
            </div>

  </div>
	
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer"><a href="#">Home</a> | <a href="#">Achievemnts</a> | <a href="#">Faculty Profile</a> | <a href="#">Guidelines</a> | <a href="#">Gallery</a> | <a href="#">Library</a>  <br />
    <br />
  <span class="copyright">Visitor Count:0</span> |
  <span class="copyright">Copyright SUWEGA </span></div>

</body>
</html>
