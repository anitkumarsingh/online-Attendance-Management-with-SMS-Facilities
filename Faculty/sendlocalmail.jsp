<%-- 
    Document   : sendlocalmail
    Created on : Aug 24, 2009, 10:11:09 PM
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
<%@ include file="../common/FlashPaperConfig.jsp" %>
<%@page import="Garc.ConnectionManager.*"  %>
<%@ include file="../common/DBConfig.jsp" %>
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

   Connection con=DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
   Statement st=con.createStatement();
   String subject="",to="",body="ahaha";
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
               
               if(item.getFieldName().equals("tolist"))
                   to=item.getString();
               if(item.getFieldName().equals("subject"))
                   subject=item.getString().replace("'", "''").replace("\\","\\\\");
               if(item.getFieldName().equals("body"))
                   body=item.getString();
	   } else {
		   try {
                           
                           String staff_id=session.getAttribute("userid").toString();                           
                           String path=config.getServletContext().getRealPath("/")+"uploadedFiles/"+MAIL_UPLOAD+"/";
                           new File(path).mkdirs();

			   File itemName =new File(item.getName());
                           out.print(itemName.getName());

                           //find the extension of the file
                           int mid= itemName.getName().lastIndexOf(".");
                           String ext=itemName.getName().substring(mid+1,itemName.getName().length());
                           double rand=Math.random();
			   File savedFile = new File(path+rand+itemName.getName());
			   item.write(savedFile);
			   out.println("<tr><td><b>Your file has been saved at the loaction:</b></td></tr><tr><td><b>"+config.getServletContext().getRealPath("/")+"uploadedFiles/"+itemName.getName()+"</td></tr>");

                           java.util.StringTokenizer token=new java.util.StringTokenizer(to,",");
                           while(token.hasMoreElements()){
                               String[] value=token.nextToken().split(":");
                               if(value[1].trim().equalsIgnoreCase("staff")){
                                   if(value[0].trim().equalsIgnoreCase("all")){
                                       String sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                               "select '"+session.getAttribute("userid")+"','"+subject+"',staff_id,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"' from staff where user_type not like 'Admin'";
                                       st.executeUpdate(sql);
                                    }
                                   else{
                                       
                                       String sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                                "values ('"+session.getAttribute("userid")+"','"+subject+"',(select staff_id from staff where user_name like '"+value[0].trim()+"'),'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"')";
                                      
                                        st.executeUpdate(sql);
                                   }
                               }
                               else if(value[1].trim().equalsIgnoreCase("student")){
                                   if(value[0].trim().equalsIgnoreCase("all")){
                                        String sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                               "select '"+session.getAttribute("userid")+"','"+subject+"',student_id,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"' from students";
                                       st.executeUpdate(sql);
                                    }
                                   else{
                                       String sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                               " values('"+session.getAttribute("userid")+"','"+subject+"','"+value[0]+"','"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"')";
                                       st.executeUpdate(sql);
                                       }
                               }
                               else if(value[1].trim().equalsIgnoreCase("subject")){
                                   String[] sub_sec=value[0].split("-");
                                   String sql="select semester,subject_id,elective from subject where subject_id = '"+sub_sec[0]+"'";
                                   ResultSet rs=st.executeQuery(sql);
                                   out.print(sql);
                                   String semester="";
                                   if(rs.next())
                                       if(rs.getString("elective").equals("null"))
                                            semester=rs.getString("semester");
                                   out.print(semester+"<--");
                                   if(semester.equals(""))
                                       sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                           "select '"+session.getAttribute("userid")+"','"+subject+"',student_id,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"'  from elective_students where subject_id like '"+sub_sec[0]+"'";
                                   else
                                       sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                           "select '"+session.getAttribute("userid")+"','"+subject+"',student_id,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"' from students where semester="+semester +" and section ='"+sub_sec[1]+"'";
                                   out.print(sql);
                                   st.executeUpdate(sql);
                               }
                               else if(value[1].trim().equalsIgnoreCase("semester")){
                                   String sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                               "select '"+session.getAttribute("userid")+"','"+subject+"',student_id,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"' from students where semester ="+value[0];
                                   st.executeUpdate(sql);
                               }
                               else if(value[1].trim().equalsIgnoreCase("all")){
                                    String sql="insert into mail (sender_id,`subject`,`to`,msg,`timestamp`,attachment) " +
                                               "(select '"+session.getAttribute("userid")+"','"+subject+"',student_id,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"' from students) " +
                                               " union " +
                                               "(select '"+session.getAttribute("userid")+"','"+subject+"', staff_id ,'"+body+"',now(),'"+savedFile.getName().replace("'", "''").replace("\\", "\\\\").replace((rand+""), "")+"' from staff where user_type not like 'Admin')";
                                //    out.print(sql);
                                       st.executeUpdate(sql);
                               }

                           }
                           //String sql="insert into resource (staff_id,subject_id,section,semester,filename,`date`,title,`desc`,category)values('"+staff_id+"','"+subject_id+"','"+section+"','"+semester+"','"+itemName.getName().replace("'","''").replace("\\", "\\\\")+"',curdate(),'"+title+"','"+desc+"','"+category+"')";

                           //st.executeUpdate(sql);


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
         parent.loadInBox();
     </script>
