<%--
    Document   : index
    Created on : July 20, 2009, 10:12:04 PM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@ include file="/common/pageConfig.jsp" %>

<%@page import="java.sql.*"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery.js"></script>
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="../css/table-style.css" />
<link type="text/css" rel="stylesheet" href="../css/ingrid.css" />
<link type="text/css" rel="stylesheet" href="../js/modelbox/styles/modal-window.css" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script src="../js/jquery.ingrid.js"></script>
<script src="../js/nicEdit.js"></script>
<script src="../js/jquery.autocomplete.pack.js"></script>
<link type="text/css" rel="stylesheet" href="../css/FileBrowser.css" />
<script src="./js/HOD.js"></script>
<script src="./js/HODReport.js"></script>
<script src="../js/FileBrowser.js" type="text/javascript"></script>
<script src="../js/garcEssentials.js" type="text/javascript"></script>
<script src="../js/modelbox/scripts/modal-window.min.js" type="text/javascript"></script>


<script>
   $(document).ready(function() {

       var url="../Faculty/AjaxPages/welcome.jsp"
            $.ajax({
                type: "POST",
                url: url,
                success: function(msg){
                   // alert(msg);
                       $('#right').html(msg);
                       smartColumns(200,250);
                       $('#status').html("<center>Loading Completed</center>");
                       loadSoftware();
                }
            });
            t=setTimeout("clearmsg()",3000);
    });
</script>
<style type="text/css">
    @import url(../css/scrolling_table.css);
</style>
  <style type="text/css">

		.progress-bar-background {
                        -webkit-border-radius: 5px;
			background-color: white;
			width: 100%;
			position: relative;
			overflow:hidden;
			top: 0;
			left: 0;
		}

		.progress-bar-complete {
			background-color: #3399CC;
			width: 50%;
			position: relative;
			overflow:hidden;
			top: -12px;
			left: 0;
		}

		#progress-bar {

                        -webkit-border-radius: 5px;
			width: 200px;
			height: 15px;
			overflow:hidden;
			border: 1px black solid;
		}
	</style>
<title>Index</title>
</head>

<body>
    <div id="status" class="status">Loading ...</div>
<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
             <div class="logo1"><img src="../images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center><%=college%></center></div>
    <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
			<li><a href="#">Home</a></li>
			<li><a href="AssignStaff.jsp">Assign Staff</a></li>
                        <li><a href="SetElective.jsp">Set Electives</a></li>
                         <li><a href="#" onclick="getTimetableReport()">Time Table</a></li>
                         <li><a onclick="Report()">Reports</a></li>
			<li><a href="../Faculty">Faculty Desk</a></li>
                        <li><a href="../common/logoutvalidation.jsp">SignOut</a></li>
            </ul>
            <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>   
			<div style="clear:both"></div>
		</div>
	</div>
      	<div style="clear:both"></div>
</div>

 <div id="content_wrapper">
  
 	<div id="top_div">


		<div id="right">
			<h3>Welcome</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
                             Please Wait ...
			</div>
			
		</div>

		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer">
                         <a href="index.jsp">Home</a>
			 <a href="AssignStaff.jsp">Assign Staff</a> |
                         <a href="SetElective.jsp">Set Electives</a> |
                         <a href="#" onclick="getTimetableReport()">Time Table</a> |
                         <a onclick="Report()">Reports</a>
    <br />
  <span class="copyright">Visitor Number:<%@ include file="../common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright SUWEGA </span></div>

</body>
</html>

