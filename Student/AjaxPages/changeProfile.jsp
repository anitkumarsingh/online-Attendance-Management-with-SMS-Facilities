<%-- 
    Document   : changeProfile
    Created on : Sep 24, 2009, 2:21:11 PM
    Author     : Dinesh Kumar D
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
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
<%@ include file="../../common/DBConfig.jsp" %>

<%try{
                        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                        Statement st=connection.createStatement();
                        String studentid=session.getAttribute("userid").toString();
                        if(request.getParameter("action").toString().equals("changePass")){
                            String old_password="",new_pass="",pass="";
                            ResultSet rs=st.executeQuery("select pass from students where student_id like '"+studentid+"'");
                            if(rs.next())
                                old_password=rs.getString(1);
                            pass=request.getParameter("oldpass");
                            if(pass.equalsIgnoreCase(old_password))
                            {
                                new_pass=request.getParameter("newpass");
                                st.executeUpdate("update students set pass='"+new_pass+"' where student_id='"+studentid+"'");

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
                    <li><a href="#tabs-2">Change Password</a></li>
               </ul>
              <div id="tabs-1">
                  <div id="addForm">
                    <%ResultSet rs= st.executeQuery("select * from students where student_id = '"+studentid+"'");
                        if(rs.next()){%>
                                <table id="hor-minimalist-b">
                                    <thead>
                                        <tr>
                                          <td style="font-weight:bolder">Reg No  :</td><td><%=studentid%>&nbsp;&nbsp;&nbsp; </td>
                                          <td style="font-weight:bolder">Name :</td> <td><%=rs.getString(2)%>&nbsp;&nbsp;&nbsp;</td>
                                          <td style="font-weight:bolder">Batch :</td> <td><%=rs.getString(6)%>&nbsp;&nbsp;&nbsp; </td>
                                        </tr>
                                        <tr>
                                          
                                          <td style="font-weight:bolder">Semester :</td> <td><%=rs.getString(3)%>&nbsp;&nbsp;&nbsp;</td>
                                          <td style="font-weight:bolder">Section :</td> <td><%=(char)(rs.getInt(4)+'A'-1)%>&nbsp;&nbsp;&nbsp;</td>
                                       </tr>
                                    </thead>
                                </table>
                                <table style="margin:auto" cellspacing="2" cellpadding="1" width="75%"  >
                                     <tr align="left">
                                         <th>SSLC Percentage</th>
                                         <td><input name="sslc" id="sslc" class="required" value="<%=(rs.getString(7)==null || rs.getString(7).equals("null"))?"":rs.getString(7)%>" size="4"/></td>
                                     </tr>
                                     <tr align="left">
                                        <th>HSC Percentage</th>
                                        <td><input name="hsc" id="hsc" value="<%=(rs.getString(8)==null || rs.getString(8).equals("null"))?"":rs.getString(8)%>" class="required" size="4" /></td>
                                     </tr>
                                      <tr align="left">
                                          <th>UG University</th>
                                          <td><input name="uguniv" id="uguniv" value="<%=(rs.getString(14)==null || rs.getString(14).equals("null"))?"":rs.getString(14)%>" class="required" size="35" /></td>
                                      </tr>
                                      <tr align="left">
                                          <th>UG Department</th>
                                          <td><input name="ugdept" id="ugdept" value="<%=(rs.getString(15)==null || rs.getString(15).equals("null"))?"":rs.getString(15)%>" class="required" size="35" /></td>
                                      </tr>
                                      <tr align="left">
                                          <th>UG Percentage</th>
                                          <td><input name="ug" id="ug" value="<%=(rs.getString(9)==null || rs.getString(9).equals("null"))?"":rs.getString(9)%>" class="required" size="4"  /></td>
                                      </tr>
                                      <tr align="left">
                                          <th>Phone</th>
                                          <td><input name="ph_no" id="ph_no" value="<%=(rs.getString(10)==null || rs.getString(10).equals("null"))?"":rs.getString(10)%>" class="required"  size="15" /></td>
                                      </tr>
                                      <tr align="left">
                                          <th>Email-ID</th>
                                          <td><input name="email" id="email" value="<%=(rs.getString(11)==null || rs.getString(11).equals("null"))?"":rs.getString(11)%>" class="required"  size="35" /></td>
                                      </tr>
                                      <tr align="left">
                                          <th>Permanent Address</th>
                                          <td><textarea name="address" id="address" class="required"  rows="4" cols="35"><%=(rs.getString(12)==null || rs.getString(12).equals("null"))?"":rs.getString(12)%></textarea></td>
                                      </tr>
                                   </table>
                                   <center><input type="button" value="Submit" onclick="addInfo();"/></center>
                    <% }      if(request.getParameter("action").toString().equals("addInfo")){
                                 String sql="update students set sslc='"+request.getParameter("sslc")+"',hsc='"+request.getParameter("hsc")+"',uguniversity='"+request.getParameter("uguniv")+"',ugcourse='"+request.getParameter("ugdept")+"',ug='"+request.getParameter("ug_perct")+"',email='"+request.getParameter("email")+"',phone='"+request.getParameter("phone")+"',address='"+request.getParameter("address")+"' where student_id='"+studentid+"'";
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

                                    <tbody id='form'>
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
                    <center><input type="Submit" value="Change Password" onclick="changePassword()" /></center>
                  
              </div>
           </div>

 
<%

            connection.close();
     }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
  }%>
  
