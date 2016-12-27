 <%@ include file="/common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/jquery.autocomplete.css" />
<script src="../js/jquery.js"></script>
<link type="text/css" rel="stylesheet" href="../css/redmond/jquery-ui.css" />
<script src="../js/jquery-ui.js"></script>
<script src="../js/jquery.autocomplete.pack.js"></script>
<script src="./js/Timetable.js"></script>

<title>Index</title>
</head>

<body>

<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
			<div class="logo1">SUWEGA</div>
			<div class="logo2"> Resource Center</div>
			<div class="logo3"><%=dept%></div>
		</div>
	<div id="Search_box"><center><%=college%></center></div>
    <div id="servertime" align="right"></div>
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="semesterplanner.jsp">Faculty Desk</a></li>
                            <li><a href="../common/logoutvalidation.jsp">SignOut</a></li>
                        </ul>
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
    <div id="status" class="status"></div>
    <p align="right"> <input type="checkbox" onclick=" $('#left').toggle();"/>SHOW/HIDE SIDEBAR</p>
 	<div id="top_div">
            <div id="left">
                <ul>
                    <li><a href="#" onclick="loadSemester()">Assign Periods</a></li>
                </ul>
            </div>

		<div id="right" style="width:680px;">
                    <div id="option"></div>
                    <div id="result">
			<h3>Welcome</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">Sed consectetuer tellus quis augue. Vivamus sed massa. Nulla pharetra orci vel ligula. Pellentesque eu magna. Sed molestie, arcu a pharetra gravida, dui pede bibendum ante, a luctus arcu eros a lacus. Cras scelerisque. Duis placerat egestas augue.
			</div>
			<div align="right" class="read">[ <a href="#"></a> ]</div>
                    </div>
		</div>

		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer"><a href="#">Home</a> | <a href="#">Attendance</a> | <a href="#">Resources</a> | <a href="#">Assesment</a> | <a href="#">Time Table</a> | <a href="#">Announcement</a> | <a href="#">Semester Planner</a> | <a href="#">My Documents</a> <br />
    <br />
  <span class="copyright">Visitor Count:0</span> |
  <span class="copyright">Copyright </span></div>

</body>
</html>

