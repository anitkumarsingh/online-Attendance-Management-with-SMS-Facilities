<%-- 
    Document   : timetable
    Created on : Sep 1, 2009, 2:52:12 PM
    Author     : Ramkumar
--%>
<%@ include file="../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>

<%
 Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
 Statement statement = connection.createStatement();
 if(request.getParameter("action").equals("getalldates")){
     String sql="SELECT DATE_FORMAT(`date`, '%d/%m/%Y'),section,semester FROM timetable_data where section="+request.getParameter("section")+" and semester="+request.getParameter("semester")+
                " union "+
                " select DATE_FORMAT(`date`, '%d/%m/%Y'),section,semester from timetable_header where section="+request.getParameter("section")+" and semester="+request.getParameter("semester");
     ResultSet rs=statement.executeQuery(sql);
     while(rs.next())
         out.print("<a href='#' onclick=\"$('#date').val('"+rs.getString(1)+"'),periods()\"  >"+rs.getString(1)+"</a>");
     connection.close();
     return;

 }
  else if(request.getParameter("action").equals("getsemesterinfo")){
        String sql="SELECT year,semester FROM section;";
        ResultSet rs=statement.executeQuery(sql);
        %>
        <table width="80%">
    <tr>
        <td><input type="text" id="date" size="8"/> <a href="#" onclick="loadAllDates()">Show All</a></td>
    <td>Year
        <select id="semester" onchange="periods()">
            <%while(rs.next()){%>
            <option value="<%=rs.getString(2)%>"><%=rs.getString(1)%></option>
            <%}%>
        </select>
    </td>
    <td align="right" >Section
        <select id="section" onchange="periods()">
            <%for(int i=0;i<NO_OF_SECTIONS;i++){%>
            <option value="<%=i+1%>"><%=(char)( i+'A') %></option>
            <%}%>
        </select>
    </td>
    </tr>
</table>
<%
     connection.close();
return;
      }
 else if(request.getParameter("action").equals("period")){
     String sql="select * from timetable_header where semester='"+request.getParameter("semester")+"' and section='"+request.getParameter("section")+"' and `date`=STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')";
    // out.print(sql);
     ResultSet rs=statement.executeQuery(sql);
     %>
     <table cellpadding="2" cellspacing="2" id="timeheader">
         <tr>
     <%
     for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
         %>
         <td align="center"><%=i%></td>
      
        <%
     }
     %></tr><tr><%
     for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
         %>
         <td><input type="text" id="<%=i%>" size="3" maxlength="3" value="<%=(rs.next())?rs.getString("header"):""%>"></td>
        <%
     }
     %>
         <td><input type="button" value="Next>>" onclick="submitheader()"></td>
         </tr></table><%
              connection.close();
         return;
 }
 else if(request.getParameter("action").equals("showtable")){
     String [] days={ "MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"};
     String sql="select * from timetable_header where semester='"+request.getParameter("semester")+"' and section='"+request.getParameter("section")+"' and `date` = STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')";
     ResultSet rs=statement.executeQuery(sql);
     out.print("<table id='timetable'><tr><td>Day/Period</td>");
     int count=0;
  
     while(rs.next()){
         out.print("<td>"+rs.getString("header")+"</td>");
         count++;
         }
     out.print("</tr>");
     sql="select * from timetable_data where semester='"+request.getParameter("semester")+"' and section='"+request.getParameter("section")+"' and `date` = STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')";
     rs = statement.executeQuery(sql);
     
     for(int i=0;i<6;i++){
         out.print("<tr><th>"+days[i]+"</th>");
         for(int j=0;j<count;j++){
            String temp="";
            if(rs.first()){
                do{
                   if(rs.getInt(1)==i && rs.getInt(2)==j){
                        temp=rs.getString(3);
                        break;
                        }
                }while(rs.next());
            }
            out.print("<td><input type='text' class='list' id='"+i+"-"+j+"' value='"+temp+"'  size='8'/></td>");
        }
         out.print("</tr>");
    }
     out.print("</table>");
     out.print("<input type='button' onclick='submittable()' value='save'/>");
     connection.close();
     return;
 }
 else if(request.getParameter("action").equals("savetable")){

     int count=Integer.parseInt(request.getParameter("count"));
     String[] data=request.getParameter("data").split(",");
     String sql="delete from timetable_data where section='"+request.getParameter("section")+"' and semester='"+request.getParameter("semester")+"' and `date`=STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')";
     statement.executeUpdate(sql);
     for(int i=0;i<count;i++){
         String [] temp=data[i].split("-");
         sql="insert into timetable_data values('"+temp[0]+"','"+temp[1]+"','"+temp[2]+"','"+request.getParameter("section")+"','"+request.getParameter("semester")+"',STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y'))";
         statement.executeUpdate(sql);
         
     }

     
    /* for(int i=0;i<Integer.parseInt(count);i++){
         sql="insert into timetable_header values('"+request.getParameter("semester")+"','"+request.getParameter("section")+"','"+header[i]+"','"+(i+1)+"','"+count+"')";
         statement.executeUpdate(sql);
     }*/

     connection.close();
     out.print("true");
     return;
 }
 else if(request.getParameter("action").equals("addheader")){
     String[] header=request.getParameter("header").split(",");
     String count=request.getParameter("count");
     String sql="delete from timetable_header where section='"+request.getParameter("section")+"' and semester='"+request.getParameter("semester")+"' and `date`=STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')";
     statement.executeUpdate(sql);
     for(int i=0;i<Integer.parseInt(count);i++){
         sql="insert into timetable_header values('"+request.getParameter("semester")+"','"+request.getParameter("section")+"','"+header[i]+"','"+(i+1)+"','"+count+"',STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y'))";
         statement.executeUpdate(sql);
     }

     connection.close();
     out.print("true");
     return;
 }
 connection.close();
 %>