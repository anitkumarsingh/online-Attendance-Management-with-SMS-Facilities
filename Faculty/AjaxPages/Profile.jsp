<%-- 
    Document   : Profile
    Created on : Sep 18, 2009, 11:32:59 AM
    Author     : Administrator
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
<%@ include file="../../common/pageConfig.jsp" %>
<%try{
                        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                        Statement st=connection.createStatement();
                        String userid=session.getAttribute("userid").toString();
                         if(request.getParameter("action").toString().equals("changePass")){
                            String old_password="",new_pass="",pass="";
                            ResultSet rs=st.executeQuery("select * from staff where staff_id like '"+userid+"'");
                            if(rs.next())
                                old_password=rs.getString(4);
                            pass=request.getParameter("oldpass");
                            if(pass.equalsIgnoreCase(old_password))
                            {
                                new_pass=request.getParameter("newpass");
                                st.executeUpdate("update staff set pass='"+new_pass+"' where staff_id='"+userid+"'");

                                out.print("<span class=error> New Password Set</span>");
                            }
                            else
                                out.print("<span class=error> Wrong Password</span>");
                            connection.close();
                            return;
                            }

                        %>
<div id="tabs">
		<ul>
                    <li><a href="#tabs-1" >Change Profile</a></li>
                    <li><a href="#tabs-2" >Change Password</a></li>
               </ul>
                <div id="tabs-1">
                <div id="addForm">
                    <%ResultSet rs= st.executeQuery("select staff_name,qualification,designation,subjects_handled,specialization,mailid,phone_number,about_u,title from staff where staff_id = '"+userid+"'");
                        if(rs.next())%>
            <table style="margin:auto" cellspacing="2" cellpadding="1" width="75%" >
                 <tr align="left">
                     <th>Staff Name</th>
                     <td><input name="staffname" id="staffname" class="required" value="<%=rs.getString(1)%>" size="35"/></td>
                 </tr>
                  <tr>
                                     <td>Title</td>
                                     <td><select id="title" name="title" class="required" title="Choose the title">
                                         <option value="selectone">Please Select...</option>
                                         <option value="Mr."  <%=(rs.getString(9)!=null && rs.getString(9).equals("Mr."))?"selected":""%>>Mr.</option>
                                         <option value="Mrs." <%=(rs.getString(9)!=null && rs.getString(9).equals("Mrs."))?"selected":""%>>Mrs.</option>
                                         <option value="Ms."  <%=(rs.getString(9)!=null && rs.getString(9).equals("Ms."))?"selected":""%>>Ms.</option>
                                         <option value="Dr."  <%=(rs.getString(9)!=null && rs.getString(9).equals("Dr."))?"selected":""%>>Dr.</option>
                                    </select></td>
                    </tr>
                 <tr align="left">
                    <th>Qualification</th>
                    <td><input name="qualification" id="qualification" value="<%=rs.getString(2)%>" class="required" size="35" /></td>
                 </tr>
                 <tr align="left">
                         <th>Designation</th>
                         <td>
                             <select id="designation" name="designation" class="required" title="Choose the title">
                                 <option value="selectone">Please Select...</option>
                                 <%
                                 for(int i=0;i<STAFF_DESIGNATION.length;i++)
                                 {                            %>
                                 <option value="<%=STAFF_DESIGNATION[i]%>" <%=(rs.getString(3)!=null && rs.getString(3).equals(STAFF_DESIGNATION[i]))?"selected":""%>><%=STAFF_DESIGNATION[i]%></option>
                                 <%}%>
                             </select>
                         </td>
                  </tr>
                  <tr align="left">
                      <th>Subjects Handled</th>
                      <td><textarea name="subj_handeled" id="subj_handeled" class="required"  rows="2" cols="50" ><%=(rs.getString(4)==null || rs.getString(4).equals("null"))?"":rs.getString(4)%></textarea></td>
                  </tr>
                  <tr align="left">
                      <th>Area of Specialization</th>
                      <td><textarea name="area_specialization" id="area_specialization" class="required"  rows="2" cols="50"><%=(rs.getString(5)==null || rs.getString(5).equals("null"))?"":rs.getString(5)%></textarea></td>
                  </tr>
                  <tr align="left">
                      <th>Email Id</th>
                      <td><input name="email" id="email" value="<%=(rs.getString(6)==null || rs.getString(6).equals("null"))?"":rs.getString(6)%>" class="required" size="35"  /></td>
                  </tr>
                  <tr align="left">
                      <th>Phone Number</th>
                      <td><input name="ph_no" id="ph_no" value="<%=(rs.getString(7)==null || rs.getString(7).equals("null"))?"":rs.getString(7)%>" size="15" /></td>
                  </tr>
                  <tr align="left">
                      <th>About U</th>
                      <td><textarea name="aboutu" id="aboutu"  rows="2" cols="50"><%=(rs.getString(8)==null || rs.getString(8).equals("null"))?"":rs.getString(8)%></textarea></td>
                  </tr>
               </table>
               <center><input type="button" value="Submit" onclick="addInfoStaff();"/></center>
<%       if(request.getParameter("action").toString().equals("addInfoStaff")){
            int i=0,priority=0;
            String designation=request.getParameter("desig");
            for(i=0;i<STAFF_DESIGNATION.length;i++)
                    {
                        if(STAFF_DESIGNATION[i].equals(designation))
                            break;
                    }
            priority=STAFF_PRIORITY[i];
             String sql="update staff set staff_name='"+request.getParameter("name")+"',qualification='"+request.getParameter("qual")+"',designation='"+request.getParameter("desig")+"',subjects_handled='"+request.getParameter("subj_handled")+"',specialization='"+request.getParameter("aos")+"',mailid='"+request.getParameter("email")+"',phone_number='"+request.getParameter("phone")+"',about_u='"+request.getParameter("aboutu")+"',priority="+priority+",title='"+request.getParameter("title")+"' where staff_id='"+userid+"'";
                int rec = st.executeUpdate(sql);
                 if(rec>0)
                    out.print("<span>Updated...</span>");
                 else
                     out.print("<span>No Change...</span>");
                // connection.close();
              //  pool.free(connection);

            }
            %>
                    </div>

              </div>

                <div id="tabs-2">
                    <table id="hor-minimalist-b">
                                    <thead>
                                        <tr>
                                             <th>Properties</th><th>Entries</th>
                                        </tr>
                                    </thead>

                                    <tbody id="form">
                                        <tr>
                                            <td>Old Password</td> <td><input class="required" type=password name=oldpass id="oldpass"/></td>
                                        </tr>
                                        <tr>
                                            <td>New Password</td> <td><input class="required"type=password name=password id="password" /></td>
                                        </tr>
                                        <tr>
                                            <td>Confirm Password</td> <td><input class="required"type=password name=confirmpassword id="confirmpassword" /></td>
                                        </tr>
                                   </tbody>
                    </table>
                    <center><input type="Submit" value="Change Password" onclick="changePass()" /></center>
                </div>

                 <div id="tabs-3">

                </div>
 <%

            connection.close();
     }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
  }%>
</div>