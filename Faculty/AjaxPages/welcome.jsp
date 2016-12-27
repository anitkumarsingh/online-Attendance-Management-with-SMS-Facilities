<%-- 
    Document   : welcome
    Created on : Aug 18, 2009, 11:03:53 AM
    Author     : Ramkumar
--%>
<%

    if(session.getAttribute("userid")==null){
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
<%@page import="java.io.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>
<%
 Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
 Statement statement = connection.createStatement();
 String sql="select staff_name,qualification, DATE_FORMAT(day, '%W %d,%M %Y') ,DATE_FORMAT(day, '%r') from staff where `staff_id`='"+session.getAttribute("userid")+"'";
 ResultSet rs=statement.executeQuery(sql);
 %>
 <%
 if(rs.next()){
%>

<h3>Welcome <%=rs.getString(1)%> <%=rs.getString(2)%></h3>
      <ul class="column">
          <li>
              <div class="block">
                  <% File file=new File("../images/student/"+session.getAttribute("semester")+"/"+session.getAttribute("userid")+".jpg");%>
                  <%if(file.exists()){%>
            <img src="../images/student/<%=session.getAttribute("semester")+"/"+session.getAttribute("userid")%>.jpg"/>
            <%}else{%>
            <img src="../images/unknown.png"/>
            <br>
            <%}  if(session.getAttribute("logintime").equals("null at null"))
                     out.print("You are first time in use");
                   else
                     out.print("you last visted the site on "+session.getAttribute("logintime"));
                  %>
              </div>
         <li>
              <div class="block">
                  <%
                   sql="select count(*),sum(if(status='unread',1,0)) from mail where `to`='"+session.getAttribute("userid")+"'";
                    rs=statement.executeQuery(sql);
                    %>
                    <img src="../images/mail.png"/>
                    <br>
                    <ul>
                         <%
                    if(rs.next()){
                        %>
                        <li>Unread Message:<%=(rs.getString(2)==null)?"0":rs.getString(2)%></li>
                        <li>Total Message :<%=rs.getString(1)%></li>
                        <%
                    }
                    %></ul><%
                   
                  %>
              </div>
        </li>
        <li>
              <div class="block">
                  <img src="../images/updates.png"/>
                  <br>
                  <ul>
                      <li>Updates</li>
                      <%
                      sql="select data,DATE_FORMAT(date,'%e/%m') from newsupdate where date > now() - INTERVAL 7 DAY";
                      rs=statement.executeQuery(sql);
                      boolean flag=false;
                      while(rs.next()){flag=true;
                      %>
                      <li><%=rs.getString(1)%> [<%=rs.getString(2)%>]</li>
                      <%}
                      if(!flag)
                        out.print("<li>No Updates</li>");
                      %>
                  </ul>

              </div>
        </li>
        <li>
              <div class="block">
                  <img src="../images/recreation.png"/>
                  <br>
                  <ul>
                      <li>Recreation</li>
                      <li><a href="/js/sudoku/index.html" onclick="$(this).modal({width:433, height:553}).open(); return false;">Sudoku</a></li>
                  </ul>
                  
              </div>
        </li>
</ul>
              SOFTWARES
<div class="block">
    <input type="hidden" id="file"/>
    <div ><span id="span_file"></span> <span class="download" onclick="window.open('../common/fileDownload.jsp?type=MYDOCUMENT&filename='+$('#file').val())"> &nbsp; &nbsp; &nbsp;</span></div>
    <div id="list"></div>
</div>


<%
 }    
 %>
<%
    connection.close();
%>