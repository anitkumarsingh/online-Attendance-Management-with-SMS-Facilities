<%-- 
    Document   : ShowResources
    Created on : Aug 4, 2009, 4:25:34 PM
    Author     : Ramkumar
--%>
<%@page import="java.sql.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>
<%@ include file="../../common/FlashPaperConfig.jsp" %>
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
      if(session.getAttribute("semester")==null){
        out.print("<h3><center>No Subjects Assigned!</center></h3>");
        return;
    }
	if(request.getParameter("action")!=null && request.getParameter("action").equals("autosuggestion")){%>
		<select id="ddltitle" name="ddltitle" onblur="check()" class="chk" >
                        <option value="Please Select">Please Select</option>
                        <%
                        
                             Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                             Statement stmt=con.createStatement();
                             String staff_id=session.getAttribute("userid").toString();
                             String subject_id=session.getAttribute("subject_id").toString();
                             int section= Integer.parseInt(session.getAttribute("section").toString());
				     String unit=request.getParameter("unit").toString();
                             String sql="select topic from course_planner where subject_id='"+subject_id+"' and section='"+section+"' and category='"+unit+"'";
				     out.print(sql);
                             ResultSet rs=stmt.executeQuery(sql);
                             while(rs.next()){
                                 %>
                                 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                                 <%
                             }
                             con.close();
                       
                        %>
                    </select>
	<%return;}
 %>
 <%!
            public boolean isContains(String arr[],String key){
                if(key.equals(""))
                    return false;
                for(int i=0;i<arr.length-1;i++)
                    if(arr[i].equalsIgnoreCase(key))
                       return true;

                return false;
            }
        %>

<%if(request.getParameter("action").equals("subject")){%>
<%

int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
<center><h3><%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h3></center><br>
 <form action="facultyResourceUpload.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
     <div style="float:left">
        <table>
            
            <tr>
                <td>Unit / Category</td>
            </tr>
            <tr>
                <td><input type="text" style="width:300px;" name="category" id="category" class="chk"  onblur="check()" onKeyUp  ="suggession()"></td>
            </tr>
            <tr>
                <td>Title</td>
            </tr>
            <tr>
                <td>
                    <textarea style="width:300px;display:none" name="desc" id="desc" class="chk"  onblur="check()"></textarea>
			  <div id="autosuggestion">
                    * Unit is mandatory
			  </div>
                    <a href='#' onclick="toggle()"><sup>Change</sup></a>
                </td>
            </tr>
		<tr>
                <td>Resource Title</td>
            </tr>
            <tr>
                <td><input type="text" style="width:300px;" name="title" id="title" class="chk"  onblur="check()"></td>
            </tr>
		<tr><td><sup>ex: Assignment,Presentation</sup></td></tr>
            <tr>
                <td ><p style="font-weight:bolder">Multiple file Upload</p></td>
            </tr>
            <tr>
                <td>
                               <input name="file1" type="file" id="file1">
                <td>
            </tr>
            <tr>
                <td>
                              <input name="file2" type="file" id="file2">
                </td>
            <tr>
                <td>
                              <input name="file3" type="file" id="file3">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" name="Submit" id="submit" value="Submit files" />
                </td>
            </tr>
            <tr>
                <td><iframe id="inline" name="inline" src="" style="display:none"></iframe></td>
            </tr>

        </table>
     </div>  
 </form>
 <%}
 else if(request.getParameter("action").equals("article")){
    %>
     <form action="FacultyArticleUpload.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
         <div style="float:left"  >
        <table >
            <tr>
                <td>Article Title</td>
            </tr>
            <tr>
                <td><input type="text" style="width:300px;" name="title" id="title" class="chk"  onblur="check()"></td>
            </tr>
           
            <tr>
                <td>Description</td>
            </tr>
            <tr>
                <td><textarea style="width:300px;" name="desc" id="desc" class="chk" onblur="check()"></textarea></td>
            </tr>
            <tr>
                <td align="center">Multiple file Upload</td>
            </tr>
            <tr>
                <td>
                               Specify file: <input name="file1" type="file" id="file1">
                <td>
            </tr>
            
            <tr>
                <td align="center">
                    <input type="submit" name="Submit" id="submit" value="Submit files" />
                </td>
            </tr>
            <tr>
                <td><iframe id="inline" name="inline" src="" ></iframe></td>
            </tr>

        </table>
     </div>
          </form>
         <%}
         else if(request.getParameter("action").equals("deleteresource")){
             Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
             Statement stmt=con.createStatement();
             String staff_id=session.getAttribute("userid").toString();
             String subject_id=session.getAttribute("subject_id").toString();
             int section= Integer.parseInt(session.getAttribute("section").toString());
             String sql="delete from resource where staff_id ="+staff_id+" and subject_id='"+subject_id+"' and section='"+section+"' and filename='"+request.getParameter("filename")+"'";
             stmt.executeUpdate(sql);
             con.close();
             java.io.File f =new java.io.File(config.getServletContext().getRealPath("/")+"uploadedFiles/"+RESOURCE_UPLOAD+"/"+subject_id+"["+section+"]/"+request.getParameter("filename"));
             f.delete();

         }
         else if(request.getParameter("action").equals("deletearticle")){
             Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
             Statement stmt=con.createStatement();
             String staff_id=session.getAttribute("userid").toString();
             String subject_id=session.getAttribute("subject_id").toString();
             int section= Integer.parseInt(session.getAttribute("section").toString());
             String sql="delete from article where staff_id ="+staff_id+"  and filename='"+request.getParameter("filename")+"'";
             stmt.executeUpdate(sql);
             con.close();
             java.io.File f =new java.io.File(config.getServletContext().getRealPath("/")+"uploadedFiles/"+ARTICLE_UPLOAD+"/"+staff_id+"/"+request.getParameter("filename"));
             f.delete();
         }
        else if(request.getParameter("action").equals("viewarticle")){
             Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
             Statement stmt=con.createStatement();
             String staff_id=session.getAttribute("userid").toString();
             String subject_id=session.getAttribute("subject_id").toString();
             int section= Integer.parseInt(session.getAttribute("section").toString());
             String sql="select * from article where staff_id ="+staff_id;
             ResultSet rs= stmt.executeQuery(sql);
             %>
            <div style='float:left;width:600px;'>
                <table  class='Table' >
                    <thead>
                        <th>Title</th>                        
                        <th>Date</th>
                        <th>File Name</th>
                        <th>Action</th>
                    </thead>
                    <tbody>
             <%
             while(rs.next()){
                 %>
                 <tr>
                     <td><%=rs.getString("title")%></td>                    
                     <td><%=rs.getString("date")%></td>
                     <td><%=rs.getString("filename")%></td>
                     <td title="<%=rs.getString("desc")%>">
                         <ul class="action">
                             
                             <li onclick="window.location='../common/fileDownload.jsp?filename=<%=  staff_id+"/"+rs.getString("filename")+"&type=ARTICLE"%>'" style="background:url('../images/download.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;</li>
                             <%
                             int mid= rs.getString("filename").lastIndexOf(".");
                              String ext=rs.getString("filename").substring(mid+1,rs.getString("filename").length());

                                if(FLASH_PAPER && isContains(FLASH_PAPER_SUPPORTS,ext)){%>
                             <li onclick="window.open('../common/fileViewer.jsp?filename=<%=  staff_id+"/"+rs.getString("filename")+"&type=ARTICLE"%>')" style="background:url('../images/view.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;</li>

                             <%}%>
                             <li  onclick="deleteArticle('<%=rs.getString("filename")%>')" style="background:url('../images/delete.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;</li>
                         </ul>
                     </td>
                 </tr>
            <%}%>
             </tbody></table></div>
             <%con.close();
         }
         else if(request.getParameter("action").equals("viewresource")){
             Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
             Statement stmt=con.createStatement();
             String staff_id=session.getAttribute("userid").toString();
             String subject_id=session.getAttribute("subject_id").toString();
             int section= Integer.parseInt(session.getAttribute("section").toString());
             String sql="select *,DATE_FORMAT(`date`, '%m/%d/%Y') x from resource where staff_id ="+staff_id+"  and subject_id='"+subject_id+"' and section='"+section+"' order by category";
             //out.print(sql);
             ResultSet rs= stmt.executeQuery(sql);
             %>
             <div style='float:left;width:600px;'>
                 <table class='Table' >
                     <thead>
                     <th>Category</th>
                     <th>Topic</th>                                          
                     <th>Date</th>
                     <th>File Name</th>
                     <th>Action</th>
                 </thead>
                 <tbody>
             <%
             while(rs.next()){
                 %>
                 <tr>
                     <td><%=rs.getString("category")%></td>
                     <td><%=rs.getString("desc")%></td>                                         
                     <td><%=rs.getString("x")%></td>
                     <td><%=rs.getString("filename")%></td>
                     <td >
                         <ul class="action">
                             
                               
                             <li onclick="window.location='../common/fileDownload.jsp?filename=<%=rs.getString("folder")%>/<%=subject_id+"["+section+"]/"+rs.getString("filename")+"&type=RESOURCE"%>'" style="background:url('../images/download.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;&nbsp;</li>
                             
                             <%
                             int mid= rs.getString("filename").lastIndexOf(".");
                              String ext=rs.getString("filename").substring(mid+1,rs.getString("filename").length());
                                if(FLASH_PAPER && isContains(FLASH_PAPER_SUPPORTS,ext)){%>
                             <li onclick="window.open('../common/fileViewer.jsp?filename=<%=rs.getString("folder")%>/<%=subject_id+"["+section+"]/"+rs.getString("filename")+"&type=RESOURCE"%>')" style="background:url('../images/view.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;&nbsp;</li>
                             <%}%>
                             <li onclick="deleteresource('<%=rs.getString("filename")%>')" style="background:url('../images/delete.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;&nbsp;</li>
                         </ul>
                     </td>
                 </tr>
                 <%
             }
            %>
            </tbody></table></div>
            <%
             con.close();
         }

         %>
     
         <ul class="sidemenu">
         <li style="background-color:#EDF3F3;text-align:right;padding:5px 15px 5px 5px;">Subject</li>
         <li style="padding:10px 0 0 0"><a href="#" onclick="SubjectResources()">Add Resources</a></li>
         <li style="padding:10px 0 10px 0"><a href="#" onclick="ViewSubjectResource()">View Resources</a></li>
         <li style="background-color:#EDF3F3;text-align:right;padding:5px 15px 5px 5px;">Article</li>
         <li style="padding:10px 0 0 0"><a href="#" onclick="ArticleResources()">Add Article</a></li>
         <li style="padding:10px 0 10px 0"><a href="#" onclick="ViewArticle()">View Article</a></li>
     </ul>

  