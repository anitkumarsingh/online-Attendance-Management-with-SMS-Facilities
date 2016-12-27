<%-- 
    Document   : getassignedsubject
    Created on : July 19, 2009, 9:29:22 AM
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
<%@page import="java.sql.*" %>
 <div id="left">
			<h2>SUBJECTS</h2>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
<%

if(request.getParameter("subjectid")!=null && request.getParameter("elective")!=null && request.getParameter("semester")!=null){
    session.setAttribute("subjectid", request.getParameter("subjectid"));
    session.setAttribute("elective", request.getParameter("elective"));
    session.setAttribute("semester", request.getParameter("semester"));
    session.setAttribute("section", request.getParameter("section"));
    
}
%>
<%
Class.forName("org.gjt.mm.mysql.Driver");
Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement sub_statement = connection.createStatement();
ResultSet sub_rs = sub_statement.executeQuery("select x.subject_id,y.subject_name,y.elective,x.semester,x.section  from assign_staff x,subjects y where x.staff_id like '"+session.getAttribute("userid")+"' and x.subject_id=y.subject_id ");
while(sub_rs.next()){
    if(session.getAttribute("subjectid")==null){
         session.setAttribute("subjectid",sub_rs.getString(1));
         session.setAttribute("elective",sub_rs.getString(3));
         session.setAttribute("semester",sub_rs.getString(4));
         session.setAttribute("section",sub_rs.getString(5));
         
    }
    if(session.getAttribute("subjectid").toString().equals(sub_rs.getString(1))){
    %>
    <p class="sub_mnu"><%=sub_rs.getString(2)%></p>
    <%
    }
    else{
        %>
        <p class="sub_mnu"><a href=".<%=request.getServletPath().replace("faculty/","")%>?subjectid=<%=sub_rs.getString(1)%>&semester=<%=sub_rs.getString(4)%>&section=<%=sub_rs.getString(5)%>&elective=<%=sub_rs.getString(3)%>"><%=sub_rs.getString(2)%></a></p>
        <%
        }
    }
connection.close();
%>
</div>
<h2>COURSE WORK</h2>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
                  <p class="sub_mnu"><a href="#">Course Outline</a></p>
                  <p class="sub_mnu"><a href="#">Course Plan</a></p>
                  <p class="sub_mnu"><a href="#">Course Coverage</a></p>
                  <p class="sub_mnu"><a href="#">Class Report</a></p>
                  <p class="sub_mnu"><a href="#">On Duty</a></p>
                  <p class="sub_mnu"><a href="#">Full Report</a></p>
            </div>
	  </div>

