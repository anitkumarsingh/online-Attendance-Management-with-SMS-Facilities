 
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
           
            %>
            <table id="hor-minimalist-b">
                <tr>
                <th>Name</th>
                <th>Qualification</th>
                <th>Designation</th>
                <th>Login Type</th>
                <th>User Name</th>
                <th>Action</th>
                </tr><%
            ResultSet rs=st.executeQuery("select staff_name,user_name,qualification,staff_id,user_type,designation,title from staff where user_type='Director'");
            if(rs.next()){
            %>
            <tr>
                <td><%=rs.getString(7)+" "+rs.getString(1)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(6)%></td>
                <td><%=rs.getString(5)%></td>
                <td><%=rs.getString(2)%></td>
                <td><ul class="action">
                <li onclick="DeleteStaff('<%=rs.getString(4)%>')" class="delete"><a>Trash</a></li>
                <li onclick="EditStaff('<%=rs.getString(4)%>')" class="edit"><a href="#">Edit</a></li>
                <li onclick="resetStaffPassword('<%=rs.getString(4)%>')" class="edit"><a href="#">Reset</a></li>
                </ul>
            
            </tr>
            <%}
            rs=st.executeQuery("select staff_name,user_name,qualification,staff_id,user_type,designation,title from staff where user_type='HOD'");
            if(rs.next()){
            %>
            <tr>
                <td><%=rs.getString(7)+" "+rs.getString(1)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(6)%></td>
                <td><%=rs.getString(5)%></td>
                <td><%=rs.getString(2)%></td>
                <td><ul class="action">
                <li onclick="DeleteStaff('<%=rs.getString(4)%>')" class="delete"><a >Trash</a></li>
                <li onclick="EditStaff('<%=rs.getString(4)%>')" class="edit"><a href="#">Edit</a></li>
                <li onclick="resetStaffPassword('<%=rs.getString(4)%>')" class="edit"><a href="#">Reset</a></li>
                </ul>

            </tr>
            <%}
            rs=st.executeQuery("select staff_name,user_name,qualification,staff_id,user_type,designation,title from staff where user_type='Staff' or user_type='Office' or user_type='Library' or user_type='Garc' order by priority");
            while(rs.next()){
            %>
            <tr>
                <td><%=rs.getString(7)+" "+rs.getString(1)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(6)%></td>
                <td><%=rs.getString(5)%></td>
                <td><%=rs.getString(2)%></td>
                <td><ul class="action">
                <li onclick="DeleteStaff('<%=rs.getString(4)%>')" class="delete"><a>Trash</a></li>
                <li onclick="EditStaff('<%=rs.getString(4)%>')" class="edit"><a href="#">Edit</a></li>
                <li onclick="resetStaffPassword('<%=rs.getString(4)%>')" class="edit"><a href="#">Reset</a></li>
                </ul>

            </tr>
            <%
            }%>
            </table><%
        }
        else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from staff where staff_id="+request.getParameter("staff_id");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span>No Change...</span>");
        }

        else if(request.getParameter("action").toString().equals("update")){
            int i=0,priority=0;
            String designation=request.getParameter("designation");
            out.print(designation);
            for(i=0;i<STAFF_DESIGNATION.length;i++)
                    {
                        if(STAFF_DESIGNATION[i].equals(designation))
                            break;
                    }
            priority=STAFF_PRIORITY[i];
            String sql="update staff set staff_name='"+request.getParameter("staff_name")+"',user_name='"+request.getParameter("username")+"',qualification='"+request.getParameter("qualification")+"',user_type='"+request.getParameter("type")+"',designation='"+designation+"',priority="+priority+", title='"+request.getParameter("title")+"' where staff_id="+request.getParameter("staff_id");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span >"+sql+"No Change...</span>");
         }

            else if(request.getParameter("action").toString().equals("reset_password")){
            String username="";
            ResultSet rset1=st.executeQuery("select user_name from staff where staff_id="+request.getParameter("staff_id"));
            if(rset1.next())
                username=rset1.getString("user_name");
            String sql="update staff set pass='"+username+"' where staff_id="+request.getParameter("staff_id");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span >"+sql+"No Change...</span>");
         }
            else if(request.getParameter("action").toString().equals("editview")){

            String sql="select staff_id,staff_name,user_name,qualification,user_type,designation,title from staff where staff_id="+request.getParameter("staff_id");
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){

            %>
           <table style="margin:auto" cellspacing="2" cellpadding="1" width="60%" id="form">
                <thead>
                    <tr>
                        <th>Staff ID</th>
                        <th><%=request.getParameter("staff_id")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Staff Name</td>
                        <td><input type="text" name="staff_name" id="staff_name" class="required" value="<%=rs.getString(2)%>" /></td>
                    </tr>
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="user_name" id="user_name" class="required" value="<%=rs.getString(3)%>" /></td>
                    </tr>
                    <tr>
                        <td>Qualification</td>
                        <td><input type="text" name="qual" id="qual" class="required" value="<%=rs.getString(4)%>" /></td>
                    </tr>
                    <tr>
                                     <td>Title</td>
                                     <td><select id="edit_title" name="edit_title" class="required" title="Choose the title">
                                         <option value="selectone">Please Select...</option>
                                         <option value="Mr."  <%=(rs.getString(7)!=null && rs.getString(7).equals("Mr."))?"selected":""%>>Mr.</option>
                                         <option value="Mrs." <%=(rs.getString(7)!=null && rs.getString(7).equals("Mrs."))?"selected":""%>>Mrs.</option>
                                         <option value="Ms."  <%=(rs.getString(7)!=null && rs.getString(7).equals("Ms."))?"selected":""%>>Ms.</option>
                                         <option value="Dr."  <%=(rs.getString(7)!=null && rs.getString(7).equals("Dr."))?"selected":""%>>Dr.</option>
                                    </select></td>
                    </tr>
                    <tr align="left">
                         <td>Designation</td>
                         <td>
                             <select id="desig" name="desig" class="required" title="Choose the title">
                                 <option value="selectone">Please Select...</option>
                                 <%
                                 for(int i=0;i<STAFF_DESIGNATION.length;i++)
                                 {                            %>
                                 <option value="<%=STAFF_DESIGNATION[i]%>" <%=(rs.getString(6)!=null && rs.getString(6).equals(STAFF_DESIGNATION[i]))?"selected":""%>><%=STAFF_DESIGNATION[i]%></option>
                                 <%}%>
                             </select>
                         </td>
                    </tr>
                    <tr>
                        <td>Login Type</td>
                        <td><select id="usertype" name="usertype" class="required" title="Choose the title">
                                    <option value="selectone">Please Select...</option>
                                    <option value="Director" <%=(rs.getString(5).equals("Director"))?"selected":""%>>Director</option>
                                    <option value="HOD" <%=(rs.getString(5).equals("HOD"))?"selected":""%>>HOD</option>
                                    <option value="Staff" <%=(rs.getString(5).equals("Staff"))?"selected":""%>>Staff</option>
                                    <option value="Office" <%=(rs.getString(5).equals("Office"))?"selected":""%>>Office</option>
                                    <option value="Library" <%=(rs.getString(5).equals("Library"))?"selected":""%>>Library</option>
                                    <option value="Time Table" <%=(rs.getString(5).equals("Time Table"))?"selected":""%>>Time Table</option>
                                    <option value="Achievement" <%=(rs.getString(5).equals("Acievement"))?"selected":""%>>Achievement</option>
                                    <option value="Garc" <%=(rs.getString(5).equals("Garc"))?"selected":""%>>Garc</option>
                                    <option value="OTHER" <%=(rs.getString(5).equals("Other"))?"selected":""%>>OTHER</option>
                            </select> </td>
                    </tr>
                </tbody>
            </table>
                    <center><input type="button" value="Update" name="update" onclick="UpdateStaff('<%=request.getParameter("staff_id")%>')"/></center>
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