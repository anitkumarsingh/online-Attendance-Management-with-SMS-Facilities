 
<%@page import="Garc.ConnectionManager.*"  %>
<%@ include file="../common/FlashPaperConfig.jsp" %>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 String path="";
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
               if(item.getFieldName().equals("directory")){
                   if(!(item.getString().equals("none") || item.getString().equals("..")))
                        path=item.getString();
                  
                   }
           } else {
		   try {
                           if(path.equals(""))
                                path=config.getServletContext().getRealPath("/")+"uploadedFiles\\"+MYDOCUMENT+"\\"+session.getAttribute("userid")+"\\";
                           new File(path).mkdirs();
                          
			   File itemName =new File(item.getName());
                           out.print(itemName.getName());

			   File savedFile = new File(path+itemName.getName());
			   item.write(savedFile);
			   out.println("<tr><td><b>Your file has been saved at the loaction:</b></td></tr><tr><td><b>"+config.getServletContext().getRealPath("/")+"uploadedFiles/"+itemName.getName()+"</td></tr>");
//"C:\
		   } catch (Exception e) {
			  out.print( e.toString());
		   }
	   }
	   }

   }

   %>
    </table>
   </center>
     <script>
         parent.browse(parent.document.getElementById('directory').value);
         parent.document.forms[0].reset();
     </script>

 