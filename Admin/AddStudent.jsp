 
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
<%@pageimport="java.sql.*"  %>
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
<script src="js/AddStudent.js"></script>


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
                            <li><a>Student Entry</a></li>
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
             <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>         
                    <h3>Student Details</h3>
                   
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
                                        <th>Name</th>
                                        <th><input type="text" name="student_name" value="" class="required" id="add_student_name" /></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Student ID</th>
                                        <td><input type="text" name="student_id" value="" class="required" id="add_student_id" /></td>
                                    </tr>
                                    <tr>
                                        <th>Batch</th>
                                        <td>
                                            <%
                                            int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                            //out.print(year);
                                            year-=NO_OF_YEARS;%>
                                            <select name="batch" class="required" id="add_batch">
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=year;i<=year+NO_OF_YEARS;i++){%>
                                                <option value="<%=i%>"><%=i%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Semester</th>
                                        <td>
                                            <select name="semester" class="required" id="add_semester" >
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_YEARS*2;i++){%>
                                                <option><%=i%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Section</th>
                                        <td colspan="3"><select name="section" class="required" id="add_section" >
                                                <option value="selectone">Please Select...</option>
                                                <%
                                                 //NO_OF_SECTIONS
                                                 for(int i=1;i<=NO_OF_SECTIONS;i++){%>         
                                                <option><%=(char)('A'-1+i)%></option>
                                                <%}%>
                                            </select>
                                       </td>
                                    </tr>
                                   
                                </tbody>
                            </table>
                          
                                            <center><input type="button" value="Submit" name="addstudent" onclick="add()"/></center>

                            <%
if(request.getParameter("student_name")!=null){
    try{

        Connection connection =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        String sql="insert into students(student_id,pass,student_name,semester,section,batch) values('"+request.getParameter("student_id")+"','"+request.getParameter("student_id")+"','"+request.getParameter("student_name")+"',"+request.getParameter("semester")+","+(request.getParameter("section").trim().charAt(0)-'A'+1)+","+request.getParameter("batch")+");";
        //out.print(sql);
        int rec=st.executeUpdate(sql);
        if(rec>0)
            out.print("<span class=error>Record Inserted</span>");
        else
            out.print("<span class=error>No Record Inserted</span>");
        connection.close();
       
        }
        catch(Exception e){
            out.print("<span class=error>"+e.toString()+"</span>");
        }
    }

%>
                            </form>
                        </div>
                        <div id="tabs-2" >
                            <div id="years">

                                <ul class="nobullet">
                                    <li>Year</li>
                               <%for(int i=1;i<=NO_OF_YEARS;i++){%>
                               <li> <a href="#" onclick="$('#status').show(),$('#status').html('<center><img src=\'../images/loading.gif\'/>Loading...</center>'),ViewStudents('<%=i%>')"><%=i%></a></li>
                               <%}%>
                                </ul>
                            </div>
                                <div id="StudentDetail"></div>
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
<div id="dialog" title="Warning">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the record ?
         </p>
</div>
</body>
</html>

