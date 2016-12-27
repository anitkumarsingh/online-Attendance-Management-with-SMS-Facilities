 
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

<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
<script src="js/SemPlan.js"></script>

<title>Question Bank</title>
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
                            <li><a href="#">Question Bank</a></li>
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
			<h3>Question Bank Upload</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Upload Question Bank</a></li>


			</ul>
			<div id="tabs-1">
                         <form id="addForm" method="POST" enctype="multipart/form-data" name="form1" id="form1">
                                <table style="margin:auto" cellspacing="2" cellpadding="1" width="75%">
                                 <tr>
                                     <th>Semester</th>
                                    
                                     <td><select id="semester" name="semester" class="required" title="Choose the title">
                                             <option value="selectone">Please Select...</option>
                                        <%for(int i=1;i<=NO_OF_YEARS*2;i++){%>
                                        <option><%=i%></option>
                                        <%}%>
                                        </select>
                                     </td>
                                 </tr>
                                 <tr>
                                     <th>Choose File</th>
                                     <td><input name="file1" type="file" id="file1" ></td>
                                 </tr>
                              </table>

                                        <center><input type="submit" value="Submit" onclick="add()" /></center>

                                    </form>


                        </div>


<%

Connection connection =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement st=connection.createStatement();
String semester="";
if(request.getParameter("action")!=null &&  request.getParameter("action").equals("delete")){
    String sql="delete from questionbank where filename='"+request.getParameter("filename")+"'";
    st.executeUpdate(sql);
}
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {
     //out.print("Oops! file cannot be uploaded");
 } else {
	   FileItemFactory factory = new DiskFileItemFactory();
	   ServletFileUpload upload = new ServletFileUpload(factory);
	   List items = null;
	   try {
		   items = upload.parseRequest(request);
	   } catch (FileUploadException e) {
		   e.printStackTrace();
	   }
	   Iterator itr = items.iterator();
	   while (itr.hasNext()) {
	   FileItem item = (FileItem) itr.next();
	   if (item.isFormField()) {
               if(item.getFieldName().equals("semester"))
                   semester=item.getString();
	   } else {
		   try {

                           String path=config.getServletContext().getRealPath("/")+"uploadedFiles/QuestionBank/";
                           new File(path).mkdirs();

			   File itemName =new File(item.getName());
                           //out.print(itemName.getName());

                           //find the extension of the file
                           int mid= itemName.getName().lastIndexOf(".");
                           String ext=itemName.getName().substring(mid+1,itemName.getName().length());
                           if(!(ext.equalsIgnoreCase("zip")||ext.equalsIgnoreCase("rar"))){
                               out.print("Cannot  Upload the file:"+itemName.getName());
                               
                            }
                            else{
			   File savedFile = new File(path+itemName.getName());
			   item.write(savedFile);
                          
                           String sql="insert into questionbank values('"+semester+"','"+itemName.getName()+"')";
                           st.executeUpdate(sql);
                           
			   out.println("<b>Your file has been saved </b><br>");
                          }

		   } catch (Exception e) {
			  //out.print( e.toString());
		   }
	   }
	   }

   }
String sql="select * from questionbank";
ResultSet rs=st.executeQuery(sql);

%>
 <table id="hor-minimalist-b">
            <thead>
            <tr  cellspacing="2" cellpadding="1">
                <th>Semester</th>
                <th>Uploaded Question Bank</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <% while(rs.next()){%>
             <tr>
                            <td><%=rs.getString(1)%></td>
                            <td><a href="../common/fileDownload.jsp?type=QB&filename=<%=rs.getString(2)%>" ><%=rs.getString(2)%></a></td>
                            <td><a href='./QuestionBank.jsp?action=delete&filename=<%=rs.getString(2)%>' ><ul class="action"><li class="delete">Trash</li></ul></a></td>
             </tr>
            <%}

connection.close();

%>
            </tbody>
 </table>

            <div id="warning" class="error"><center>Note: Click on the Question Bank to download the Files</center></div>

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

