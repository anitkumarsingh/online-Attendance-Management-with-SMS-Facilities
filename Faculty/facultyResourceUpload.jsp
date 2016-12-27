<%-- 
    Document   : FacultyResourceUpload
    Created on : Aug 7, 2009, 6:53:52 PM
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
<%@page import="java.sql.*"  %>
<%@ include file="../common/DBConfig.jsp" %>
<%@ include file="../common/FlashPaperConfig.jsp" %>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <%@ page import="java.net.URLDecoder"%>
   <center><table border="2" width="200px;">
        <tr><td><h1>Your files  uploaded </h1></td></tr>
        <%!
            public boolean isContains(String arr[],String key){
                if(key.equals(""))
                    return true;
                for(int i=0;i<arr.length-1;i++)
                    if(arr[i].equalsIgnoreCase(key))
                       return true;
                    
                return false;
            }
        %>
   <%
   Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
   Statement st=con.createStatement();
   String title="",desc="",category="";
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {
     out.print("Oops! file cannot be uploaded");
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
               if(item.getFieldName().equals("desc"))
                   if(!item.getString().trim().equals(""))
                        desc=item.getString();
               if(item.getFieldName().equals("ddltitle"))
                   if(!item.getString().trim().equals("Please Select"))
                        desc=item.getString();
               if(item.getFieldName().equals("title"))
                   title=item.getString();
               if(item.getFieldName().equals("category"))
                   category=item.getString();

	   } else {
		   try {
                           String staff_id=session.getAttribute("userid").toString();
                           String elective=session.getAttribute("elective").toString();
                           String subject_id=session.getAttribute("subject_id").toString();
                           String semester=session.getAttribute("semester").toString();
                           int section= Integer.parseInt(session.getAttribute("section").toString());
                           int cur_year= java.util.Calendar.getInstance().get(java.util.Calendar.YEAR) ;
                           String path=config.getServletContext().getRealPath("/")+"uploadedFiles/"+RESOURCE_UPLOAD+"/"+cur_year+"/"+subject_id+"["+section+"]/";
                           new File(path).mkdirs();

			   File itemName =new File(URLDecoder.decode(item.getName()));
                           out.print(itemName.getName());

                           //find the extension of the file
                           int mid= itemName.getName().lastIndexOf(".");
                           String ext=itemName.getName().substring(mid+1,itemName.getName().length());
                           if(!isContains(FILETER,ext)){
                              // out.print("Cannot  Upload the file:"+itemName.getName());
                               %>
                               <script>
                                   alert("Cannot  Upload the file:<%=itemName.getName()%>");
                               </script>
                                   
                               <%
                               return;
                            }

			   File savedFile = new File(path+itemName.getName());
			   item.write(savedFile);
			   out.println("<tr><td><b>Your file has been saved at the loaction:</b></td></tr><tr><td><b>"+config.getServletContext().getRealPath("/")+"uploadedFiles/"+itemName.getName()+"</td></tr>");
                           
                          

                           if(FLASH_PAPER && isContains(FLASH_PAPER_SUPPORTS,ext)){
                                String ConvertQuery=FLASH_PAPER_EXE+" "+path+itemName.getName()+" -o "+path+itemName.getName()+".swf";
                                Runtime r=Runtime.getRuntime();
                                Process p=null;
                                p=r.exec(ConvertQuery);
                                p.waitFor();

                                out.print(ConvertQuery);
                           }
                           //Runtime.getRuntime().exec(convertString);
                        String sql="insert into resource (staff_id,subject_id,section,semester,filename,`date`,title,`desc`,category,folder)values('"+staff_id+"','"+subject_id+"','"+section+"','"+semester+"','"+itemName.getName().replace("'","''").replace("\\", "\\\\")+"',curdate(),'"+title+"','"+desc+"','"+category+"','"+cur_year+"')";
                           //out.print(sql);
                           st.executeUpdate(sql);
                          
//"C:\
		   } catch (Exception e) {
			  //out.print( e.toString());
		   }
	   }
	   }
           
   }
 con.close();
   %>
    </table>
   </center>
     <script>
         parent.document.forms[0].reset();
     </script>

<!--

refence:http://www.developershome.com/wap/wapUpload/wap_upload.asp?page=jsp
http://www.developershome.com/wap/wapUpload/wap_upload.asp?page=jsp3
http://www.roseindia.net/jsp/file_upload/uploadingMultipleFiles.shtml
http://forums.codecharge.com/posts.php?post_id=44078
-->