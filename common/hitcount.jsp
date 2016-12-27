 

<%@page import="java.sql.*"  %>


<%

Connection connection_count = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement statement1 = connection_count.createStatement();
if(session.isNew())
     statement1.executeUpdate("update misc set value = value + 1 where type like 'hit_count'");
ResultSet rs1 = statement1.executeQuery("select value from misc where type like 'hit_count'");
rs1.next();
out.print(rs1.getInt(1));
connection_count.close();

%>