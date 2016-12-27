<%-- 
    Document   : legend
    Created on : Oct 12, 2008, 2:54:11 PM
    Author     : Ramkumar
--%>


<%
if(request.getAttribute("action")!=null){%>
    <table>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section="+section+" and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
out.print(sql);
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(2)%></td>
        <td><%=rs.getString(3)%></td>
    </tr>
    <%
}
%>
            </table><%
}%>