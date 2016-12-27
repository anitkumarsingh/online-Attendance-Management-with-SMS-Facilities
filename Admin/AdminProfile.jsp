 
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
    if(request.getParameter("cursemester")!=null)
        session.setAttribute("DB_Name", request.getParameter("cursemester"));
 %>
<%@ include file="../common/pageConfig.jsp" %>
<%@page import="java.sql.*,java.io.*"  %>

<%
if(request.getParameter("cursemester")!=null)
    session.setAttribute("DB_Name", request.getParameter("cursemester"));
 String id = session.getAttribute("userid").toString();
//out.print(id);
Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement statement = connection.createStatement();
String old_password="",new_pass="",pass="";
ResultSet rs=null;
Statement st=null;
if(request.getParameter("action")!=null && request.getParameter("action").toString().equals("addnews")){
    st=connection.createStatement();
    String sql="";
    if(!request.getParameter("data").equals("")){
        sql="insert into newsupdate values(null,'"+request.getParameter("data")+"',now())";
        st.executeUpdate(sql);
    }
    sql="select * from newsupdate ";
    rs=st.executeQuery(sql);
    if(!rs.next()){
        out.print("No News Update");
        connection.close();
        
        return;
    }
    out.print("<br><br><table id='hor-minimalist-b'><tr><th>News</th><th>Date</th><th>Action</th></thead>");
    do{
        %>
        <tr>
        <td><%=rs.getString(2)%> </td>
        <td><i><%=rs.getString(3)%></i></td>
        <td><ul class="action">
                        <li onclick="deletenews('<%=rs.getString(1)%>')" class="delete"><a >Trash</a></li>
            </ul></td>
        
        </tr>
        <%
    }while(rs.next());
    out.print("</TABLE>");
    connection.close();
   
    return;
}
else if(request.getParameter("action")!=null && request.getParameter("action").toString().equals("delete")){
    String sql="delete from newsupdate where id="+request.getParameter("id");
    statement.executeUpdate(sql);
     connection.close();
    
    return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/table-style.css" />
<script src="../js/jquery.js"></script>
<script src="js/admin.js"></script>
<!-- jQuery UI -->
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>


<script src="js/AdminProfile.js"></script>

<title>Profile</title>
</head>

<body> 
    <div class="options" align="right">
       
        <a>Settings</a> |
        <a href="MyDocument.jsp">My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>
        
    </div>

<div id="status" class="status"> Loading ...</div>
<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
             <div class="logo1"><img src="../images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center><%=college%></center></div>
    <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>
    <div id="servertime" align="right"></div>
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
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>

     <%

               
                rs=statement.executeQuery("select * from staff where staff_id like '"+id+"'");
                if(rs.next())
                    old_password=rs.getString(4);
                if(request.getParameter("userid")!=null)
                {
                    pass=request.getParameter("userid");
                if(pass.equalsIgnoreCase(old_password))
                {
                    new_pass=request.getParameter("password");
                    statement.executeUpdate("update staff set pass='"+new_pass+"' where staff_id='"+id+"'");

                    out.print("<span class=error> New Password Set</span>");
                }
                else
                    out.print("<span class=error> Wrong Password</span>");
                }
                if(request.getParameter("action")!=null && request.getParameter("action").toString().equals("switch"))
                {
               
                    Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                    st=con.createStatement();
               
                    Connection conn = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                    
                             
                    /*rs=statement.executeQuery("SELECT * FROM students where batch=2008 and student_id < 31508621026");
                    while(rs.next())
                    {
                       stmt.executeUpdate("insert into semesterinfo.semester_students_info(student_name,student_id,semester,section,batch) values('"+rs.getString("student_name")+"','"+rs.getString("student_id")+"',2,1,2008)");
                    }*/
                    
                    try{
                        String db_name="garc"+request.getParameter("db_name");

                        ResultSet rset=statement.executeQuery("show tables");

                        st.executeUpdate("create database "+db_name); 
                        out.print(db_name+ " Database Created");
                        int rows=0;
                        while(rset.next()){
                            //out.print("CREATE TABLE "+db_name+"."+rset.getString(1)+" LIKE "+rset.getString(1));
                            st.executeUpdate("CREATE TABLE "+db_name+"."+rset.getString(1)+" LIKE "+rset.getString(1));
                            out.print(rset.getString(1)+ " table is Created<br>");
                            if(rset.getString(1).equals("misc")||rset.getString(1).equals("students")||rset.getString(1).equals("staff")||rset.getString(1).equals("subjects")){
                                 rows = st.executeUpdate("INSERT INTO "+db_name+"."+rset.getString(1)+" SELECT * FROM "+rset.getString(1));
                                  if (rows == 0){
                                   out.println("Don't add any row!<br>");
                                  }
                                  else{
                                    out.println(rows + " row(s)affected.<br>");         
                                  }
                            }
                        }
                        rows=st.executeUpdate("update "+db_name+".students set semester=semester+1");
                        if (rows == 0){
                                   out.println("Don't add any row!<br>");
                                  }
                                  else{
                                    out.println(rows + " row(s)affected.<br>");         
                                  }
                        rows=st.executeUpdate("delete from  "+db_name+".students where  semester > "+NO_OF_YEARS*2);
                        if (rows == 0){
                                   out.println("Don't add any row!<br>");
                                  }
                                  else{
                                    out.println(rows + " row(s)affected.<br>");         
                                  }
                                try{
                                // Create file 
                                
                                FileWriter fstream = new FileWriter(getServletContext().getRealPath("/")+".\\common\\config.ini",true);
                                    BufferedWriter appand = new BufferedWriter(fstream);
                                
                                appand.write(db_name);
                                
                                if(request.getParameter("alias").toString().equals(""))
                                    appand.write("="+db_name);
                                else
                                    appand.write("="+request.getParameter("alias").toString());
                                appand.newLine();
                                //Close the output stream
                                appand.close();
                                }catch (Exception e){//Catch exception if any
                                  System.err.println("Error: " + e.getMessage());
                                }
                    }
                    

                    catch(Exception e){
                        out.print(e.toString());
                        }
                        conn.close();                
                        con.close();
                   

                }
               connection.close();
              
              %>



<div id="content_wrapper">
    
 	<div id="top_div">
		<div id="right">
                     <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>         
                     <h3>Change Profile</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Add </a></li>
                                <li><a href="#tabs-2">New Semester</a></li>
                                 <li><a href="#tabs-3" onclick="addnews()">Updates</a></li>
				
			</ul>
			<div id="tabs-1">
                            <form id="addForm" method="post" action="#">
                                <table width="100%">
                                    <thead>
                                        <tr>
                                             <th>Properties</th><th>Entries</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <td>Old Password</td> <td><input class="required" type=password name=userid id="userid"/></td>
                                        </tr>
                                        <tr>
                                            <td>New Password</td> <td><input class="required"type=password name=password id="password" /></td>
                                        </tr>
                                        <tr>
                                            <td>Confirm Password</td> <td><input class="required"type=password name=confirmpassword id="confirmpassword" /></td>
                                        </tr>
                                    </tbody>
                                 </table>
                                <br/> <center><input type="Submit" value=Submit /></center>

                            </form>

                        </div>
			<div id="tabs-2">
                             <%int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);%>
                             Year:<select id="year">                                 
                             <option value='<%=year+1%>'><%=year+1%></option>
                             <option value='<%=year%>' selected><%=year%></option>
                             <option value='<%=year-1%>'><%=year-1%></option>
                             </select>&nbsp;  
                             Semester:
                             <select id="semtype">
                                 <option value="odd">ODD</option>
                                 <option value="even">EVEN</option>
                             </select>
                                     
                         Alias:<input type="text" name="alias" id="alias"/>   
                         
                          <div id="warning" class="error"><br/><br/>Note: This option should be used only at the end of each Semester</div>
                          <br /><br/>
                          <center><input type="button" id="switch" value="Switch to Next Semester" onclick="NewSemester()" /></center>
                        </div>
                             <div id="tabs-3" >
                                News: <input type="Text" id="msg"  size="50"/><input type="button" value="Add" onclick="addnews()"/>
                                <div id="news"></div>
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
  <span class="copyright">Copyright  SUWEGA </span></div>
        <div id="dialog" title="Warning" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> This action performs the  following changes
                            <ul>
                            <li>New Database will be created.</li>
                            <li>New Tables will be created.</li>
                            <li>Admin & HOD has to feed some of the information once again.</li>
                            <li>Some Information may be lost. </li>
                            </ul>Are you sure?</p>
</div>
</body>
</html>

