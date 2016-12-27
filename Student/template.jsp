<%--
    Document   : index
    Created on : Sept 18, 2009, 12:05:52 AM
    Author     : RamKumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
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

<title>Index</title>
</head>

<body>
    <div class="status" id="status"> Loading ... </div>
 <div class="options" align="right">
		<a href="../common/logoutvalidation.jsp">SignOut </a> |
</div>
<div id="top_wrapper">
	<div id="banner">

	<div id="logo">
            <div class="logo1"><img src="../images/garc.png" height="80px" width="150px"/></div>


		</div>
	<div id="Search_box"><center><%=college%></center></div>
 <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>

	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul id="nav">
			
			
			
			
			<li><a href="#" onclick="home()">Home</a></li>
                        <li><a href="#" onclick="getSubjectGrid()">Curriculum</a></li>
                        <li><a href="#" onclick="getStudentTimetable('<%=session.getAttribute("semester")%>','<%=session.getAttribute("section")%>')">TimeTable</a></li>
                        <li><a href="#" id="inboxmnu" onclick="loadInBox()">Inbox</a></li>
                    
                        <li><a href="#" onclick="window.open('../uploadedFiles/SemesterPlanner/<%=(Integer.parseInt( session.getAttribute("semester").toString() )+1)/2%>.htm')">Semester Planner</a></li>
                        <li><a href="#" onclick="Profile()">Profile</a></li>
                        <li><a href="#" onclick="QuestionBankView()">Question Bank</a></li>
                        <li><a href="/js/sudoku/index.html" onclick="$(this).modal({width:433, height:553}).open(); return false;" >Sudoku</a> </li>
                        </ul>
                        <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %> </div>         
			<div style="clear:both"></div>
		</div>
	</div>
                       
	<div style="clear:both"></div>
</div>
<div id="main">
 <div id="content_wrapper">
  <div id="top_div">
      <div id="report"></div>
      <div id="curriculam">Loading ...</div>
  </div>
     <div style="clear:both"></div>
</div>
</div>

<div id="footer_div" class="footer"><a href="#" onclick="home()">Home</a> | <a href="#" onclick="getSubjectGrid()">Curriculum</a> | <a href="#" onclick="getStudentTimetable('<%=session.getAttribute("semester")%>','<%=session.getAttribute("section")%>')">Time Table</a> | <a href="#" onclick="loadInBox()">Inbox</a> | <a href="#" onclick="window.open('../uploadedFiles/SemesterPlanner/<%=(Integer.parseInt( session.getAttribute("semester").toString() )+1)/2%>.htm')">Semester Planner</a> | <a href="#"  onclick="QuestionBankView()">Question Bank</a> | <a href="#" onclick="Profile()">Profile</a> | <a  href="/js/sudoku/index.html" onclick="$(this).modal({width:433, height:553}).open(); return false;" >sudoku</a>  <br />
    <br />
  <span class="copyright">Visitor Number:<%@ include file="/common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright  </span></div>
                        <div id="dialog" title="Warning" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the record ?
         </p>
</div>
</body>
</html>






