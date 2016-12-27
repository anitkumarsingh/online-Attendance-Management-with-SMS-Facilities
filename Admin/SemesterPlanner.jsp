 
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
<%@page import="Garc.ConnectionManager.*"  %>

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

<title>Semester Planner</title>
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
                            <li><a href="#">Semester Planner</a></li>
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
			<h3>Semester Planner Upload</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Upload Semester Plan</a></li>
				

			</ul>
			<div id="tabs-1">
                         <form id="addForm" method="POST" enctype="multipart/form-data" name="form1" id="form1">
                                <table style="margin:auto" cellspacing="2" cellpadding="1" width="75%">
                                 <tr>
                                     <th>Year</th>
                                     <td><select id="year" name="year" class="required" title="Choose the title">
                                             <option value="selectone">Please Select...</option>
                                        <%for(int i=1;i<=NO_OF_YEARS;i++){%>
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

                                        <br> <br> <center><input type="submit" value="Submit" onclick="add()" /></center>

                                    </form>


                        </div>
			
                        
<%
String year="";
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
               if(item.getFieldName().equals("year"))
                   year=item.getString();
	   } else {
		   try {
                          
                           String path=config.getServletContext().getRealPath("/")+"uploadedFiles/SemesterPlanner/";
                           new File(path).mkdirs();

			   File itemName =new File(item.getName());
                           //out.print(itemName.getName());

                           //find the extension of the file
                           int mid= itemName.getName().lastIndexOf(".");
                           String ext=itemName.getName().substring(mid+1,itemName.getName().length());
                           if(!(ext.equalsIgnoreCase("html")||ext.equalsIgnoreCase("htm"))){
                               out.print("Cannot  Upload the file:"+itemName.getName());
                               
                            }
                            else{
			   File savedFile = new File(path+year+".htm");
			   item.write(savedFile);
			   out.println("<b>Your file has been saved </b><br>");
                          }
                         
		   } catch (Exception e) {
			  //out.print( e.toString());
		   }
	   }
	   }
           
   }
File file=new File(config.getServletContext().getRealPath("/")+"uploadedFiles/SemesterPlanner/");
file.mkdirs();
String files[]=file.list();
%>
 <table id="hor-minimalist-b">
            <thead>
            <tr  cellspacing="2" cellpadding="1">
                <th>Semester</th>
                <th>Uploaded Files</th>
            </tr>
            </thead>
            <tbody>
            <% for(int i=0;i<files.length;i++){%>
             <tr>
                            <td><%=i+1%></td>
                            <td><a href="#" onclick="<%="window.open('../uploadedFiles/SemesterPlanner/"+files[i]+"')"%>" ><%=files[i]%></a></td>
             </tr>
            <%}%>
            </tbody>
 </table>

            <div id="warning" class="error"><center>Note: Click on the Uploaded Files to view the Semester Planner</center></div>

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

