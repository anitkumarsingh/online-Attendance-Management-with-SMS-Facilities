<%-- 
    Document   : ODForm
    Created on : Sep 18, 2009, 10:44:01 AM
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
<h3>On Duty Form</h3>
<%@page import="java.sql.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>

<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select section,semester from classincharge where staff_id="+session.getAttribute("userid");
    ResultSet rs=statement.executeQuery(sql);
    %>
    <p align="right" style="padding-right:10px">
Class: <select id="incharge" onchange="getODForm()">
    <%
    while(rs.next()){
        %>
        <option <%=(request.getParameter("semester")!=null && request.getParameter("section")!=null && request.getParameter("semester").equals(rs.getString(2)) && request.getParameter("section").equals(rs.getString(1)))?"selected" :""%>   value="<%=rs.getString(2)%>-<%=rs.getString(1)%>"><%=(rs.getInt(2)+1)/2%> Year - <%=(char)(rs.getInt(1)+'A'-1)%></option>
        <%}
    %>
</select>
     Date: <input type="text" size="8" id="date" value="<%=request.getParameter("date")%>"  onchange="getODForm()"/>
</p>
        <%
    if(request.getParameter("action").equals("showList")){
     sql="select a.student_id,s.student_name,group_concat(hour order by hour)," +
             "group_concat(ab_type order by hour) from attendance a,students s " +
             "where a.student_id=s.student_id and a.semester='"+request.getParameter("semester")+"' and a.section='"+request.getParameter("section")+"' and date like  STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')  group by student_id";
     //out.print(sql);
     rs=statement.executeQuery(sql);
     if(!rs.first())
     {
         out.print("Attendance Not Taken!");
         connection.close();
         return;
     }
     out.print("<table>");
     out.print("<tr><td>ID</td><td>NAME</td>");
     String hrs[]=rs.getString(3).split(",");
     for(int i=0;i<hrs.length;i++)
        out.print("<td>"+hrs[i]+"</td>");
     out.print("</tr>");
     do{
         out.print("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td>");
         String hour[]=rs.getString(3).split(",");
         String ab_type[]=rs.getString(4).split(",");
         for(int i=0;i<hour.length;i++){
             %>
            <td><input type="checkbox" id="<%=rs.getString(1)+"-"+hour[i]%>" <%=(ab_type[i].equals("P"))?"disabled":""%> <%=(ab_type[i].equals("O"))?"checked":""%>></td>
            <%
         }
         out.print("</tr>");
     }while(rs.next());
     out.print("</table>");
     %>
            <input type="button" value="Mark OD" onclick="markOD()" />
            <%
  }
    else if(request.getParameter("action").equals("add")){

        String studentlist[]=request.getParameter("student").toString().split("~");
        String []token=new String[3];
        for(int i=0;i<studentlist.length;i++){
            token=studentlist[i].split("-");
            //out.print(studentlist[i]);
            sql="update attendance set ab_type='"+token[2]+"' where date like  STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') and student_id='"+token[0]+"' and hour='"+token[1]+"'";
            statement.executeUpdate(sql);
        }
        out.print("updated...");
    }
%>
<%
connection.close();
%>