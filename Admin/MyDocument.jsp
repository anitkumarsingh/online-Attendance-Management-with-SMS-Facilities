 
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
<%@page import="java.sql.*,java.io.*" %>

<%@ include file="../common/FlashPaperConfig.jsp" %>
<%!
public static boolean deleteDir(File dir){
    try{
		// If it is a directory get the child
		if(dir.isDirectory()) {
			// List all the contents of the directory
			File fileList[] = dir.listFiles();

			// Loop through the list of files/directories
			for(int index = 0; index < fileList.length; index++) {
				// Get the current file object.
				File file = fileList[index];

				// Call deleteDir function once again for deleting all the directory contents or
				// sub directories if any present.
				deleteDir(file);
			}
		}
 
		// Delete the current directory or file.
	        dir.delete();
                return true;
                }
    catch(Exception e){
        return false;
        }
	}
%>
<%
    if(request.getParameter("create")!=null){
          boolean success = (new File(application.getRealPath("/") +"uploadedFiles\\"+MYDOCUMENT+"\\"+session.getAttribute("userid")+"\\"+ request.getParameter("create").toString())).mkdirs();
        if (success)
          out.print("Directory: " + request.getParameter("create").toString() + " created");
        else
          out.print("Failed to Create "+ request.getParameter("create").toString());
        
        return;
    }
    else if(request.getParameter("rmfile")!=null){
          boolean success = (new File(request.getParameter("rmfile").toString().replace('/', '\\'))).delete();
        if (success)
          out.print("Directory: " + request.getParameter("rmfile").toString() + " Deleted");
        else
          out.print("Failed to Remove");
        return;
    }
    else if(request.getParameter("rmdir")!=null){
          boolean success = deleteDir(new File(request.getParameter("rmdir").toString()));
        if (success)
          out.print("Directory: " + request.getParameter("rmdir").toString() + " Deleted");
        else
          out.print("Failed to Remove");
        return;
    }

%>
<%@ include file="../common/pageConfig.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery.js"></script>

<!-- jQuery UI -->
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>

<!-- File Tree -->
<script src="../js/FileBrowser.js" type="text/javascript"></script>
<link href="../css/FileBrowser.css" rel="stylesheet" type="text/css" media="screen" />

<script src="js/MyDocument.js"></script>
<script src="js/admin.js"></script>
<script>
    $(document).ready(function(){
                  
                   browse('none');
                 $('#inline').hide();
                   document.getElementById('form1').onsubmit=function() {
                    document.getElementById('form1').target = 'inline'; //'upload_target' is the name of the iframe
                    }
            });
</script>

<title>Index</title>
</head>

<body>
 <div class="options" align="right">

        <a href="AdminProfile.jsp">Settings</a> |
        <a href="MyDocument.jsp">My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>

    </div>
<div id="top_wrapper">
     <div class="options" align="right">

        <a href="AdminProfile.jsp">Settings</a> |
        <a >My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>

    </div>
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
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>
<div id="status" class="status">Loading...</div>
<div id="content_wrapper">
    
 	<div id="top_div">
		<div id="right">
                     <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>         
			<h3>My Document</h3>
			<div align="justify"  style=" border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
                            <table width="100%" cellpadding="20px">
                                <tr>
                                    <td valign="top" width="40%">
                                        <div id="options">
                                            
                                            <p class="caption"> Folder: </p>
                                            <ul class="action">
                                                <li><input type="text" id="new_dir"/></li><li class="create" onclick="createDir()"><a href="#" >Create</a></li>
                                            </ul>
                                             <form action="../common/MyDocumentUpload.jsp" method="POST" enctype="multipart/form-data" name="form1" id="form1">

                                                 <input type="hidden" id="directory" name="directory" value="none"  />
                                                 <input type="hidden" id="file" name="hidden_file" />

                                                 <p class="caption">Selected Folder</p>
                                                 <ul class="action">
                                                     <li> <span id="span_dir" style="padding-right:20px;"></span></li>
                                                     <li class="cancel" onclick="deleteFile($('#directory').val(),'dir')"><a href="#" >Delete</a></li>
                                                 </ul>

                                                 <p class="caption">Selected File</p>
                                                 <ul class="action">
                                                     <li><span id="span_file" style="padding-right:20px;"></span> </li>
                                                     <li class="cancel"><a href="#" onclick="deleteFile($('#file').val(),'file')" >Delete</a></li>
                                                     <li class="download"><a href="#" onclick="window.open('../common/fileDownload.jsp?type=MYDOCUMENT&filename='+$('#file').val())" >Download</a></li>
                                                 </ul>
                                                 <p class="caption">Upload File:</p>
                                                 <ul class="action">
                                                     <li><input type="file" name="file" value="Upload" /></li>
                                                     <li class="upload"> <input type="submit" name="Submit" id="submit" value="Submit file" /></li>
                                                 </ul>
                                                 <iframe id="inline" name="inline" src="" ></iframe>
                                             </form>

                                          </div>
                                    </td >
                                    <td valign="top" width="25%" >
                                       <div id="list" style="position:relative;float:left"></div>
                                    </td>
                                </tr>
                            </table>
                            <%
                            if(request.getParameter("error")!=null){
                                if(request.getParameter("error").equals("no"))
                                        out.print("<span class=error>Uploaded Successfully</span>");
                                else
                                        out.print("<span class=error>"+request.getParameter("error")+"</span>");
                            }
                            %>
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
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the file/folder ?
         </p>
</div>
</body>
</html>
