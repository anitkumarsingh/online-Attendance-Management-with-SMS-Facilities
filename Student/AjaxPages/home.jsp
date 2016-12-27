<%-- 
    Document   : home
    Created on : Sep 24, 2009, 12:21:18 PM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@page  import="java.sql.*"  %>
<%@page import="java.io.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>

<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement st=connection.createStatement();
    ResultSet rs=null;
    String sql="";
   //out.print(getServletContext().getRealPath("/")+"/images/student/"+session.getAttribute("semester")+"/"+session.getAttribute("userid")+".jpg");
    if(request.getParameter("action").equals("profile")){
        
        
        sql="select student_name,semester,section, DATE_FORMAT(day, '%d,%M %y') ,DATE_FORMAT(day, '%r'),batch from students where `student_id`='"+session.getAttribute("userid")+"'";
        rs=st.executeQuery(sql);
        if(rs.next()){
        File file=new File(getServletContext().getRealPath("/")+"/images/students/"+rs.getString("batch")+"/"+session.getAttribute("userid")+".jpg");
        %>
        
        <ul>
            <%if(file.exists()){%>
            <img src="../images/students/<%=rs.getString("batch")+"/"+session.getAttribute("userid")%>.jpg"/>
            <%}else{%>
            <img src="../images/unknown.png"/>
             <%}
       
           
            %>
            <li><%=rs.getString("student_name")%></li>
            <li><%=rs.getString(2)%> Semester <%=(char)('A'+rs.getInt(3)-1)%>
            <li>Last Login: <%=rs.getString(4)%></li>
            <%
        }
        %></ul><%
        connection.close();
        return;
    }
    else if(request.getParameter("action").equals("inboxcount")){
        sql="select count(*),sum(if(status='unread',1,0)) from mail where `to`='"+session.getAttribute("userid")+"'";
        rs=st.executeQuery(sql);
        %>
        <img src="../images/mail.png"/>
        <ul>
             <%
        if(rs.next()){
            %>
            <li>Unread Message:<%=(rs.getString(2)==null)?"0":rs.getString(2)%></li>
            <li>Total Message :<%=rs.getString(1)%></li>
            <%
        }
        %></ul><script>$('#inboxmnu').html('<%=(rs.getString(2)==null)?"Inbox [ 0 ]":"Inbox [ "+rs.getString(2)+" ]"%>');</script><%
        connection.close();
        return;
    }

    else if(request.getParameter("action").equals("attendance")){
        sql="select sum(if(ab_type='A',0,1)),count(*),round(sum(if(ab_type='A',0,1))*100/count(*),2) from attendance where student_id='"+session.getAttribute("userid")+"'";
        rs=st.executeQuery(sql);
        %>
        <img src="../images/attendance.png"/>
        <ul>
            <%
        if(rs.next()){
            %>
            <li>Overall Attendance</li>
            <li><%=(rs.getString(1)==null)?"0":rs.getInt(1)%>/<%=(rs.getString(2)==null)?"0":rs.getString(2)%>=<%=(rs.getString(3)==null)?"0":rs.getString(3)%></li>
            <%
        }
        %></ul>
        
        <%
        connection.close();
        return;
    }
    else if(request.getParameter("action").equals("updates")){

        %>
        <img src="../images/updates.png"/>
        <ul>
        <%
          sql="select data,DATE_FORMAT(date,'%e/%m') from newsupdate where date > now() - INTERVAL 7 DAY";
          rs=st.executeQuery(sql);
          boolean flag=false;
          while(rs.next()){flag=true;
          %>
          <li><%=rs.getString(1)%> [<%=rs.getString(2)%>]</li>
          <%}
          if(!flag)
            out.print("<li>No Updates</li>");
          %>
          </ul>

        <%
        connection.close();
        return;
    }

%>

<h1>Welcome to SUWEGA</h1>
		

                         <ul class="column">
                                <!--Repeating list item-->
                                <li>
                                    <div class="block" id="welcome">
                                         Loading Personal Info...
                                    </div>
                                </li>
                                <li>
                                    <div class="block" id="inbox_count">
                                         Loading Inbox Count...
                                    </div>
                                </li>
                               
                                <li>
                                    <div class="block" id="news">
                                        Loading Updates...
                                    </div>
                                </li>
                                <li>
                                    <div class="block" id="attendance">
                                         Loading Attendance Details ...
                                    </div>
                                </li>
                                
                               <!--end repeating list item-->
                        </ul>

                        SOFTWARES

                        <input type="hidden" id="file"/>
                        <div class="block"  ><span id="span_file"></span> <span class="download" onclick="window.open('../common/fileDownload.jsp?type=MYDOCUMENT&filename='+$('#file').val())"> &nbsp; &nbsp; &nbsp;</span>
                        <br><div id="list"></div>
                   </div>
                               
     <div style="clear:both"></div>
<%
connection.close();
%>