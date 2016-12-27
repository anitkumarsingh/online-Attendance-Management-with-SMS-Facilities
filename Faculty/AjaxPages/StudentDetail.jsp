<%-- 
    Document   : StudentDetail
    Created on : Oct 31, 2009, 3:21:54 PM
    Author     : Ramkumar
--%>
<%@page import="java.sql.*,java.io.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>
<%
 Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
 Statement st=con.createStatement();
 String sql="select * from students where student_id='"+request.getParameter("student_id")+"'";
 ResultSet rs=st.executeQuery(sql);
 if(!rs.next()){
     con.close();
     out.print("No Details Found!");
     return;
 }
String path = "/images/students/"+rs.getString("batch")+"/" + rs.getString("student_id") + ".jpg";
//out.print(path);
File file = new File(getServletContext().getRealPath("/")+ path);
if (!file.exists()) {
    path = "/images/unknown.png";
}

%>
<table>
    <tr>
        <td colspan="2"><%=rs.getString("student_name")%></td>
    </tr>
    <tr>
        <td rowspan="3"><img src="<%=path%>" height="80" width="64" /></td>
        <td>SSLC</td>
        <td><%=rs.getString("sslc")==null?"-":rs.getString("sslc")%></td>
    </tr>
    <tr><td>HSC</td><td><%=rs.getString("hsc")==null?"-":rs.getString("hsc")%></td></tr>
    <tr><td>UG</td><td><%=rs.getString("ug")==null?"-":rs.getString("ug")%></td></tr>
    <tr><td>Email Id</td><td colspan="2"><%=rs.getString("email")==null?"-":rs.getString("email")%></td></tr>
    <tr><td>Phone</td><td colspan="2"><%=rs.getString("phone")==null?"-":rs.getString("phone")%></td></tr>
    <tr><th colspan='3' onclick="$('#tooltip').hide()" bgcolor="lightblue" >Close X</th></tr>
</table>
<%
con.close();
%>