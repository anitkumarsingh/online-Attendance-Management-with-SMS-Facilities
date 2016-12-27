<%--
    Document   : ShowAttendance
    Created on : Aug 1, 2009, 10:28:46 AM
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
<%@ include file="../../common/DBConfig.jsp" %>
 <%
            try {
//		out.print("Saved ...");
                Connection connection =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                
                if(request.getParameter("action").toString().equals("add")){
		statement.executeUpdate("delete from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
//		out.print("delete from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
		String sql="insert into courseoutline values('"+session.getAttribute("userid")+"','"+request.getParameter("course_outline").trim().replace("'","''").replace("\\","\\\\")+"','"+session.getAttribute("subject_id")+"','"+session.getAttribute("section")+"','"+session.getAttribute("semester")+"')" ;
		//out.print(sql);
                statement.executeUpdate(sql);
                ResultSet rs=statement.executeQuery("select data from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
		if(rs.next())
		out.print(rs.getString(1));
                  connection.close();
                return;
                }else if(request.getParameter("action").toString().equals("view")){
                    %>
                <%
                ResultSet rs=statement.executeQuery("select data from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
		if(rs.next())
		out.print(rs.getString(1));
                connection.close();
                return;
                }
		connection.close();
                }
                catch(Exception e){
                    out.print(e.toString());
                }
         %>

<ul class="action" style="float:right;padding-bottom:10px;"><li onclick="AddCourseOutline()" class="save"><a href="#">Save</a></li></ul>
<div id="viewCourse"><textarea name="area3" id="area3" style="width: 825px; height: 450px;"></textarea>
<center><input type="button" value="Save" onclick="AddCourseOutline()"></center>
</div>