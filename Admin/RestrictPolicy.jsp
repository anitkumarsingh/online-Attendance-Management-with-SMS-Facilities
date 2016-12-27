 
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("admin"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@ include file="../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>
<%@page import="Garc.ConnectionManager.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery.js"></script>
<script src="../js/login.js"></script>

<!-- jQuery UI -->
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>

<style type="text/css">
	#student {  width: 100%;list-style: none;  }
	#student li { margin: 2px; padding: 0.3em; font-size: .8em; height: 18px;width:25%; float: left;display: block;}
        #faculty {  width: 100%;list-style: none;  }
	#faculty li { margin: 2px; padding: 0.3em; font-size: .8em; height: 18px;width:25%; float: left;display: block;}
</style>
<script src="js/RestrictPolicy.js"></script>


<title>Index</title>
</head>

<body>
     <div class="options" align="right">

        <a href="AdminProfile.jsp">Settings</a> |
        <a href="MyDocument.jsp">My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>

    </div>
 <div id="status" class="status"> Status</div>
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
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="DepartmentSettings.jsp">Course Details</a></li>
                            <li><a href="AddStaff.jsp">Staff Entry</a></li>
                            <li><a href="AddStudent.jsp">Student Entry</a></li>
                            <li><a href="AddSubject.jsp">Subject Entry</a></li>
                            <li><a href="ElectiveStudents.jsp">Elective</a></li>
                            <li><a href="SemesterPlanner.jsp">Semester Planner</a></li>
                            <li><a href="QuestionBank.jsp">Question Bank</a></li>
                            <li><a href="inbox.jsp">Inbox</a></li>
                </ul>
                
	</div>
	<div style="clear:both"></div>
     </div>
</div>

<div id="content_wrapper">
   
 	<div id="top_div">

		<div id="right">
			<h3>Restriction Policy</h3>
                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %> </div>         
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
                               <div id="tabs">
                                        <ul>
                                                <li><a href="#tabs-1">Students</a></li>
                                                <li><a href="#tabs-2">Faculty</a></li>
                                        </ul>
                                        <div id="tabs-1">
                                            <div align="right">Year <select name="year" id="year" onchange="loadStudent(this.value)">
                                                    <% for(int i=1;i<=NO_OF_YEARS;i++){%>
                                                    <option value="<%=i%>"><%=i%></option>
                                                    <%}%>
                                                </select></div>
                                                <ol id="student">
                                                    
                                                </ol>
                                                <center><input type="button" value="Disable Selected" onclick="disableSelected('student')"/><input type="button" value="Diable All" onclick="disableAll('student')"/></center>
                                        </div>
                                        <div id="tabs-2">
                                             <ol id="faculty">

                                                </ol>
                                            <center><input type="button" value="Disable Selected" onclick="disableSelected('faculty')"/><input type="button" value="Diable All" onclick="disableAll('faculty')"/></center>
                                        </div>

                                </div>
			</div>
		</div>

		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer">
                                <a href="index.jsp">Home</a> |
                                <a href="DepartmentSettings.jsp">Course Details</a> |
                                <a href="AddStaff.jsp">Staff Entry</a> |
                                <a href="AddStudent.jsp">Student Entry</a> |
                                <a href="AddSubject.jsp">Subject Entry</a> |
                                <a href="ElectiveStudents.jsp">Elective</a> |
                                <a href="AdminProfile.jsp">Profile</a> |
                                <a href="MyDocument.jsp">My Documents</a> <br />

    <br />
  <span class="copyright">Visitor Count: <%@ include file="../common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright SUWEGA </span></div>

</body>
</html>