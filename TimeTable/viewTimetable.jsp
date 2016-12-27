<%-- 
    Document   : viewTimetable
    Created on : Sep 3, 2009, 9:56:36 AM
    Author     : Ramkumar
--%>
<%@page import="java.sql.*"  %>
<%@ include file="../common/DBConfig.jsp" %>
<h1><center>Time Table </center></h1>
<%
 Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
 Statement statement = connection.createStatement();
    String semester="0",section="0";
     if(request.getParameter("semester")==null)
         if(session.getAttribute("semester")!=null)
            semester=session.getAttribute("semester").toString();
          else{
            out.print("<h3><center>No Subject(s) Assigned!</center></h3>");
            return;
        }
              
     else if(request.getParameter("semester")!=null)
        semester=request.getParameter("semester");
     
    
     if(request.getParameter("section")==null)
         section=session.getAttribute("section").toString();
     else 
        section=request.getParameter("section");
     
    
  String [] days={ "MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"};
     String sql="select * from timetable_header where semester='"+semester+"' and section='"+section+"' and date= (select max(date) from timetable_header where semester='"+semester+"' and section='"+section+"')";

     ResultSet rs=statement.executeQuery(sql);
     if(!rs.next()){
        out.print("Time Table Not Assigned!");
        connection.close();
        return;
     }
     out.print("<table id='timetable' class='clienttable'><tr><th width=100px>Day/Period</th>");
     int count=0;
     
     do{
         out.print("<th>"+rs.getString("header")+"</th>");
         count++;
     }while(rs.next());
     out.print("</tr>");
     sql="select * from timetable_data where semester='"+semester+"' and section='"+section+"' and date= (select max(date) from timetable_header where semester='"+semester+"' and section='"+section+"')";
     rs = statement.executeQuery(sql);

     for(int i=0;i<6;i++){
         out.print("<tr><th>"+days[i]+"</th>");
         for(int j=0;j<count;j++){
            String temp="-";
            if(rs.first()){
                do{
                   if(rs.getInt(1)==i && rs.getInt(2)==j){
                        temp=rs.getString(3);
                        break;
                        }
                }while(rs.next());
            }
            
            out.print("<td>"+temp+"</td>");
        }
         out.print("</tr>");
    }
     out.print("</table>");

     connection.close();
     return;
 %>