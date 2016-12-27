<%-- 
    Document   : CourseDelivery
    Created on : Oct 26, 2009, 10:05:37 AM
    Author     : Dinesh Kumar
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
<%@page import="java.sql.*"  />
<%@page import="Garc.ConnectionManager.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>
 <%
            try {
//		out.print("Saved ...");
                Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                if(request.getParameter("action").toString().equals("update")){
		String sql="update course_planner set actual_hrs='"+request.getParameter("ac_hr")+"',actual_date='"+request.getParameter("ac_date")+"' where sno="+request.getParameter("sno");
                out.println(sql);
                int rec=statement.executeUpdate(sql);
                if(rec>0)
                    out.print("<span>Updated...</span>");
                else
                    out.print("<span >"+sql+"No Change...</span>");
                }
		%>
<%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
<center><h3><%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h3></center><br>
<div id="courseDelivery">
    <table class="clienttable" cellspacing="0">
            <thead>
            <tr   cellpadding="1">
                <th>Category</th>
                <th>Topic</th>
                <th>Pln Hrs</th>
                <th>Act Hrs</th>
                <th>Finished Date</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
            String sql="select * from course_planner where subject_id='"+session.getAttribute("subject_id").toString()+"' and section='"+session.getAttribute("section")+"'  order by category,sno asc";
            ResultSet rs=statement.executeQuery(sql);
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><input type="text" id="ac_hr<%=rs.getString(9)%>" name="ac_hr" size="5" value="<%=(rs.getString(7)==null)?"-":rs.getString(7)%>"  onKeyUp="res(this,number)"/></td>
                <td><input type="text" class="dates" id="date<%=rs.getString(9)%>" name="ac_date" size="12" value="<%=(rs.getString(8)==null)?"-":rs.getString(8)%>"/></td>
                <td>
                    <ul class="action">
                    <li  onclick="UpdateCourseDelivery('<%=rs.getString(9)%>')" class="edit"><a href="#">Update</a></li>
                </ul>
                </td>
            </tr>

            </tbody>

        <%}%>
        </table>

</div>

<%connection.close();
                }
                catch(Exception e){
                    out.print(e.toString());
                }
         %>


                                   
                              