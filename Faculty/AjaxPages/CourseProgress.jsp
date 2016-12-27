<%-- 
    Document   : CourseProgress
    Created on : Oct 27, 2009, 10:38:28 AM
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
<%@page import="java.sql.*"  %>
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
    <table class="Table" >
            <thead>
            <tr>
                <th>Category</th>
                <th>Topic</th>
                <th>Pln Hrs</th>
                
                <th>Act Hrs</th>
		    <th>Classes Taken</th>
                <th>Finished Date&nbsp;&nbsp;&nbsp;&nbsp;</th>
                
            </tr>
            </thead>
            <tbody>
            <%
            String sql="select c.category,c.topic,c.planned_hrs,count(distinct(concat(a.date,a.hour))),DATE_FORMAT(max(date),'%d/%m/%Y'),group_concat(distinct(DATE_FORMAT(date,'%d/%m/%Y'))) from course_planner c left join attendance a on c.sno=a.topic where c.subject_id='"+session.getAttribute("subject_id").toString()+"' and c.section='"+session.getAttribute("section")+"' group by c.topic order by c.category,c.sno asc ";
	
            //out.print(sql);
            ResultSet rs=statement.executeQuery(sql);
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                
                <td><%=(rs.getString(4)==null)?"-":rs.getString(4)%></td>

		    <td><%=(rs.getString(5)==null)?"-":rs.getString(6).replace(",","<br>")%></td>
                <td><%=(rs.getString(5)==null)?"-":rs.getString(5)%></td>
                
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





