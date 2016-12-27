<%-- 
    Document   : search
    Created on : Sep 2, 2009, 5:10:12 PM
    Author     : Ramkumar
--%>
<%@page import="java.sql.*"  %>
<%@ include file="../common/DBConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select subject_id,subject_name from subject";
    ResultSet rs=statement.executeQuery(sql);
    while(rs.next())
        out.print(rs.getString(1)+"|"+rs.getString(2)+"\n");

%>

<%
    connection.close();
%>
