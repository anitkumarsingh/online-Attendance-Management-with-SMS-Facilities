 
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/table-style.css" />
<link rel="stylesheet" href="../js/transform/jqtransformplugin/jqtransform.css" type="text/css" media="all" />
<script src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/transform/jqtransformplugin/jquery.jqtransform.js" ></script>
<script src="../js/jquery.validate.pack.js"></script>
<script src="js/admin.js"></script>
<!-- jQuery UI -->
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script src="js/DepartmentSettings.js"></script>



<title>Department Details</title>
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
                            <li><a >Course Details</a></li>
                            <li><a href="AddStaff.jsp">Staff Entry</a></li>
                            <li><a href="AddStudent.jsp">Student Entry</a></li>
                            <li><a href="AddSubject.jsp">Subject Entry</a></li>
                            <li><a href="ElectiveStudents.jsp">Elective</a></li>
                            <li><a href="SemesterPlanner.jsp">Semester Planner</a></li>
                            <li><a href="QuestionBank.jsp">Question Bank</a></li>
                            <li><a href="inbox.jsp">Inbox</a></li>
                        </ul>
           
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>

    




<div id="content_wrapper">
    
 	<div id="top_div">
		<div id="right">
                     <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>         
			<h3>Department Settings</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
			<div id="tabs" style="display:none">
			<ul>
				<li><a href="#tabs-1">Add</a></li>
				<li><a href="#tabs-2">Edit/Delete</a></li>
			</ul>
			<div id="tabs-1">
                            <form id="addForm" method="post">
                                <table style="margin:auto" cellspacing="2" cellpadding="1" width="50%">
                                <thead>
                                    <tr>
                                        <th>Year</th>
                                         <td colspan="3"><select name="year" id="year" class="required" >
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_YEARS;i++){%>
                                                <option value="<%=i%>"><%=i%></option>
                                                <%}%>
                                            </select>
                                       </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Semester</th>
                                         <td colspan="3"><select name="semester" id="semester" class="required" >
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_YEARS*2;i++){%>
                                                <option value="<%=i%>"><%=i%></option>
                                                <%}%>
                                            </select>
                                       </td>
                                    </tr>
                                    <tr>
                                        <th>No. of Section</th>
                                        <td colspan="3"><select name="section" id="section" class="required" >
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_SECTIONS;i++){%>
                                                <option value="<%=i%>"><%=i%></option>
                                                <%}%>
                                            </select>
                                       </td>
                                    </tr>
                                    <tr>
                                        <th>No. of Electives</th>
                                        <td colspan="3"><select name="electives">
                                                <option value="0">None</option>
                                                <%for(int i=1;i<10;i++){%>
                                                <option value="<%=i%>"><%=i%></option>
                                                <%}%>
                                            </select>
                                       </td>
                                    </tr>
                                    <tr>
                                          <th>Grade System</th>
                                          <td><input name="grade" id="grade" id="grade" type="checkbox" value="YES"/>YES</td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                             <center><input type="button" value="Submit" name="deptsettings" onclick="add()"/></center>

                             <%
         try {

                Connection connection =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();

                ResultSet rset;
                if(request.getParameter("year")!=null) {
                    String year,section,sem,no_electives,grade;
                    year = request.getParameter("year");
                    section = request.getParameter("section");
                    sem=request.getParameter("semester");
                    no_electives=request.getParameter("electives");
                    grade=(request.getParameter("grade")!=null && request.getParameter("grade").toString().equals("YES")?"YES":"null");
                    String query="insert into section(year,sectioncount,semester,no_of_electives,grade) values('"+year+"','"+section+"','"+sem+"','"+no_electives+"','"+grade+"')";
                    int rec=statement.executeUpdate(query);
                    if(rec>0)
                        out.print("<span class=error>Record Inserted</span>");
                    else
                        out.print("<span class=error>No Record Inserted</span>");
                    }
                   connection.close();
                   
                   }catch(Exception e){
                        out.print("<span class=error>"+e.toString()+"</span>");
                    }%>
                            </form>
                           </div>
			<div id="tabs-2">
			  <div id="DeptDetail"></div></div>
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
<div id="dialog" title="Warning" >
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the record ?
         </p>
</div>
</body>
</html>

