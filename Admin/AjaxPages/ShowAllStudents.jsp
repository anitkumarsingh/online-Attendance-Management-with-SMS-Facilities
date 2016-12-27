 
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
<%@ include file="../../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>

<%
  try{
        
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        if(request.getParameter("action").toString().equals("view")){
            String sql="select student_id,student_name,section,batch from students where semester="+request.getParameter("semester")+" or semester="+(Integer.parseInt(request.getParameter("semester").toString())-1);
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            <table id="hor-minimalist-b">
            <thead>
            <tr  cellspacing="2" cellpadding="1">
                <th>Student ID</th>
                <th>Student Name</th>
                <th>Batch</th>
                <th>Section</th>
                <th >Action</th>
            </tr>
            </thead>
            <tbody>
            <%
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=(char)(rs.getInt(3)+'A'-1)%></td>
                <td>
                    <ul class="action">
                        <li onclick="DeleteStudent('<%=rs.getString(1)%>')" class="delete"><a >Trash</a></li>
                <li  onclick="EditStudent('<%=rs.getString(1)%>')" class="edit"><a href="#">Edit</a></li>
                <li  onclick="resetPassword('<%=rs.getString(1)%>')" class="edit"><a href="#">Reset Password</a></li>
                </ul>
                </td>
            </tr>
            <%
            }
            %>
            </tbody>
        </table>
            <%
        }
        else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from students where student_id="+request.getParameter("student_id");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span class=success>Updated</span>");
            else
                out.print("<span class=success>No Change</span>");
        }

           else if(request.getParameter("action").toString().equals("update")){
            String sql="update students set student_name='"+request.getParameter("student_name")+"', section="+request.getParameter("section")+", batch="+request.getParameter("batch")+",semester="+request.getParameter("semester")+" where student_id='"+request.getParameter("student_id")+"'";
           // out.print(sql);
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span class=success>Updated</span>");
            else
                out.print("<span class=success>No Change</span>");
        }
             else if(request.getParameter("action").toString().equals("reset_password")){
            String sql="update students set pass='"+request.getParameter("student_id")+"' where student_id='"+request.getParameter("student_id")+"'";
           // out.print(sql);
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span class=success>Updated</span>");
            else
                out.print("<span class=success>No Change</span>");
            }
            else if(request.getParameter("action").toString().equals("editview")){
            String sql="select student_name,section,semester,batch from students where student_id='"+request.getParameter("student_id")+"'";
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){

            %>
            <form id="updateForm" name="updateForm">
            <table style="margin:auto" cellspacing="2" cellpadding="1" width="50%" >
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th><%=request.getParameter("student_id")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>Student Name</th>
                        <td><input type="text" name="student_name" id="student_name" class="required"  value="<%=rs.getString(1)%>" /></td>
                    </tr>
                    <tr>
                                        <th>Batch</th>
                                        <td>
                                            <%
                                            int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                            //out.print(year);
                                            year-=NO_OF_YEARS;%>
                                            <select name="editbatch" id="editbatch" class="required" >
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=year;i<=year+NO_OF_YEARS;i++){%>
                                                <option value="<%=i%>" <%=(rs.getInt(4)!=i)?"":"selected"%>><%=i%></option>
                                                <%}%>
                                            </select>
                                        </td>
                     </tr>
                     <tr>
                                        <th>Semester</th>
                                        <td colspan="3">
                                            <select name="semester" id="semester" class="required">
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_YEARS*2;i++){%>
                                                <option value="<%=i%>"  <%=(rs.getInt(3)!=i)?"":"selected"%>><%=i%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Section</th>
                                        <td colspan="3"><select name="section" id="section" class="required" >
                                                <option value="selectone">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_SECTIONS;i++){%>
                                                <option value="<%=i%>" <%=(rs.getInt(2)!=i)?"":"selected"%>><%=(char)('A'-1+i)%></option>
                                                <%}%>
                                            </select>
                                       </td>
                                    </tr>

                   
                </tbody>
            </table>
        </form>
                    <center><input type="button" value="Update" name="update" onclick="UpdateStudent('<%=request.getParameter("student_id")%>',$('#semester').val())"/></center>
            <%
           }
            else
                out.print("<span class=success>No Record Found!</span>");
        }
        connection.close();


  }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }

%>
