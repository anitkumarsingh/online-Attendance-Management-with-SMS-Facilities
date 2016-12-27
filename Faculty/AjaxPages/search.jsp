<%-- 
    Document   : search
    Created on : Aug 24, 2009, 3:58:12 PM
    Author     : Ramkumar
--%>

<%@page import="java.sql.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>
<%
    Connection connection =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select * from (select LOWER(student_name) name,Lower(concat(student_id,':student')) id from students "+
                " union "+
                " select LOWER(staff_name) name,LOWER(concat(user_name,':staff')) id from staff " +
                "union " +
                "select concat('semester ',semester) name,concat(semester,':semester') id from students group by semester " +
                "union "+
                "select concat_ws(' ',LOWER(x.subject_name),if(z.sectioncount>1,CHAR(y.section+ASCII('A')-1),'')) name,concat(concat_ws('-',x.subject_id,y.section),':subject') id from assign_staff y,subject x ,section z where staff_id="+session.getAttribute("userid")+" and x.subject_id=y.subject_id  and x.semester=z.semester "+
                ") myQuery where name like '"+request.getParameter("q").toLowerCase()+"%'";
    ResultSet rs=statement.executeQuery(sql);
    while(rs.next())
        out.print(rs.getString(2)+"|"+rs.getString(1)+"\n");
    out.print("all:staff|all faculty\n");
    out.print("all:student|all students\n");
    out.print("all:all|every user\n");
%>

<%
    connection.close();
%>