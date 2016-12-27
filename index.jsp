<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/table-style.css" />
<script src="js/jquery.js"></script>
<script src="js/login.js"></script>
<script src="js/garcEssentials.js"></script>
<style type="text/css">
    @import url(css/scrolling_table.css);
    @import url(css/credit-styles.css);
</style>
<!--[if IE]>
    <style type="text/css">
        @import url(css/scrolling_table.ie.css);
    </style>
<![endif]-->
 
<title>SUWEGA</title>
</head>
<body>
    <div id="status" class="status">Loading ...</div>
    <div class="overlay" id="login" style="display:none">
		<span style="position:relative;margin:40px 0 0 10%;padding-left:150px; text-align: left;color:white;"  >
		User Name <input name="username" type="text" class="smalltext" id="username" onkeydown="onEnter()" />
		Password <input name="password" type="password" class="smalltext" id="password" onkeydown="onEnter()" />
		<input name="Submit1" type="button" value="Login"   class="smallbutontext" onclick="loginvalidation()"/>
		</span>
                <span class="error" id="err"></span> | <span class="error" id="err" style="cursor:hand" onclick='$("#login").slideToggle(200)'> X </span>	</div>
        <div class="options" align="right">
		<a href="#" onclick='$("#login").slideToggle(200)'>Login </a> | 
	</div>
<div id="top_wrapper">
	<div id="banner">
	
	
	<div id="logo">
             <div class="logo1"><img src="./images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center><%=college%></center></div>
    <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>
   
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="#" onclick="ResourceSearch()">Resources</a></li>
                            <li><a href="#" onclick="ArticleSearch()">Articles</a></li>
                            <li><a href="#" onclick="FacultyProfile()">Faculty Profile</a></li>
                            <li><a href="#" onclick="guidlines()">Guidelines</a></li>
                            <li><a href="#" onclick="StudentProfile()">Student Profile</a></li>
                            <li><a href="#" onclick="Credit()">Credits</a></li> 
                 	</ul> 
                         
                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="./common/SemesterSwich.jsp" %></div>
			<div style="clear:both"></div>
                         
		</div>
                 
	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  <div id="top_div">
            <h1>Welcome to SUWEGA</h1>
            <div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">
            <p align="justify" class="style1" id="plaintext">Recognizing   that currently multiple dissimilar repositories exist  to share,   transfer and maintain academic information, course material, course management   review and realizing the need to use IT based solution to deal with this   situation, SUWEGA has evolved. </p>
            <p align="justify" class="style1" id="plaintext">The   system is meant to create and maintain academic information with a view to assisting students &nbsp; - &nbsp; <strong id="website">  Resource Center (SUWEGA). </strong></p>
            <p id="plaintext"><strong>SUWEGA Users </strong></p>
            <p  id="plaintext"><strong>Administrator: </strong>Creates users and sets privileges.</p>
            <p  id="plaintext"><strong>Head of the Department: </strong>Sets timetable, schedules   internal tests, allocates subjects.</p>
            <p  id="plaintext"><strong>Faculty Members: </strong>Manage courses, update attendance   and internal marks.</p>
            <p  id="plaintext"><strong>Students: </strong>Can view announcements, attendance,   internal marks and download course materials.</p>

		</div>

  </div>
	<div id="bottom_div">
	 
	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer"><a href="index.jsp">Home</a> | <a href="#" onclick="ResourceSearch()">Resources</a> | <a href="#"  onclick="ArticleSearch()">Article</a>| <a href="#" onclick="FacultyProfile()">Faculty Profile</a> | <a href="#" onclick="guidlines()">Guidelines</a> | <a href="#" onclick="StudentProfile()">Student Profile</a>  <br />
    <br />
  <span class="copyright">Visitor Number:<%@ include file="/common/hitcount.jsp" %></span> |
  <span class="copyright">Suwega </span></div>

</body>
</html>
