 
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

<script src="js/admin.js"></script>
<!-- jQuery UI -->
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>
<script src="js/AddStaff.js"></script>

<title>AddStaff</title>
</head>

<body>
     <div class="options" align="right">

        <a href="AdminProfile.jsp">Settings</a> |
        <a href="MyDocument.jsp">My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>

    </div>
  <div id="status" class="status"><b>Loading ...</b></div>
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
                            <li><a>Staff Entry</a></li>
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
			<h3>Staff Details</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
			<div id="tabs" style="display:none">
			<ul>
				<li><a href="#tabs-1">Add User</a></li>
				<li><a href="#tabs-2">Edit/Delete</a></li>
                                <li><a href="#tabs-3" onclick="permission()">Permission</a></li>
                                <li> <a href="#tabs-4" onclick="onduty()">OnDuty </a></li>
			</ul>
			<div id="tabs-1">
                            <form id="addForm" method="post">
                            
                                <table style="margin:auto" cellspacing="2" cellpadding="1" width="75%">
                                 <tr>
                                     <th>Staff Name</th>
                                     <td><input name="staffname" id="staffname" class="required" /></td>
                                 </tr>

                                 <tr>
                                     <th>Garc User Name</th>
                                     <td><input name="username" id="username" class="required" /></td>
                                 </tr>
                                  <tr>
                                      <th>Qualification</th>
                                      <td><input name="qualification" id="qualification" class="required"  /></td>
                                  </tr>
                                  <tr align="left">
                                     <th>Designation</th>
                                     <td>
                                         <select id="designation" name="designation" class="required" title="Choose the title">
                                             <option value="selectone">Please Select...</option>
                                             <%
                                             for(int i=0;i<STAFF_DESIGNATION.length;i++)
                                             {                            %>
                                             <option value="<%=STAFF_DESIGNATION[i]%>"><%=STAFF_DESIGNATION[i]%></option>
                                             <%}%>
                                         </select>
                                     </td>
                                 </tr>
                                 <tr>
                                     <th>Title</th>
                                     <td><select id="title" name="title" class="required" title="Choose the title">
                                         <option value="selectone">Please Select...</option>
                                         <option value="Mr.">Mr.</option>
                                         <option value="Mrs.">Mrs.</option>
                                         <option value="Ms.">Ms.</option>
                                         <option value="Dr.">Dr.</option>
                                    </select></td>
                                 </tr>
                                 <tr>
                                    <th>Login Type</th>
                                    <td><select id="type" name="type" class="required" title="Choose your Login Type">
                                            <option value="selectone">Please Select...</option>
                                            <option value="Director">Director</option>
                                            <option value="HOD">HOD</option>
                                            <option value="Staff">Staff</option>
                                            <option value="Office">Office</option>
                                            <option value="Library">Library</option>
                                             <option value="Library">Lab</option>
                                            <option value="Garc">SUWEGA</option>
                                        </select></td>
                                </tr>
                              </table>
                            <center>    <input type="button" value="Submit" onclick="add();"/></center>
                           
     <% try {
                Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();

                ResultSet rset;
                if(request.getParameter("title")!=null) // For add Entry
                {
                    int i=0,priority=0;
                    String staffid,staff_name,user_name,password,title,qualification,date,type,designation;
                    type=request.getParameter("type");
                    title = request.getParameter("title");
                    staff_name = request.getParameter("staffname");
                    user_name = request.getParameter("username");
                    qualification = request.getParameter("qualification");
                    designation = request.getParameter("designation");
                    //dept = request.getParameter("dept");
                    for(i=0;i<STAFF_DESIGNATION.length;i++)
                    {
                        if(STAFF_DESIGNATION[i].equals(designation))
                            break;
                    }
                    priority=STAFF_PRIORITY[i];
                    date =null;

                    int rec=statement.executeUpdate("insert into staff (pass,staff_name,user_name,qualification,user_type,designation,priority,title) values('"+user_name.replace("'", "''").replace("\\", "\\\\")+"','"+staff_name.replace("'", "''").replace("\\", "\\\\")+"','"+user_name.replace("'", "''").replace("\\", "\\\\")+"','"+qualification.replace("'", "''").replace("\\", "\\\\")+"','"+type+"','"+designation+"',"+priority+",'"+title+"')");
                     if(rec>0)
                        out.print("<span class=error>Record Inserted</span>");
                     else
                        out.print("<span class=error>No Record Inserted</span>");

                    connection.close();
                    
               }
                
                connection.close();
                
               }catch(Exception e){
                    out.print("<span class=error>"+e.toString()+"</span>");
            }%>
                            </form>
                           </div>
			<div id="tabs-2">
			  <div id="StaffDetail"></div></div>
                            <div id="tabs-3">
                                
                            </div>
                             <div id="tabs-4">
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
  <span class="copyright">SUWEGA </span></div>
<div id="dialog" title="Warning">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the record ?
         </p>
</div>
</body>
</html>

