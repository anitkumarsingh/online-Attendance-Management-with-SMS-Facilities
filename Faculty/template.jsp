<%--
    Document   : template
    Created on : Augest 3, 2009, 11:02:04 AM
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
<%@ include file="../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>

<%
 Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
 Statement statement = connection.createStatement();
 String sql="select count(*) from mail where `to`='"+session.getAttribute("userid")+"' and status='UNREAD'";
 //out.print(sql);
 ResultSet rs=statement.executeQuery(sql);
 int unread=0;
 if(rs.next())
     unread=rs.getInt(1);
 sql="select group_concat(s.report),count(c.staff_id) from staff_permissions s left join "+
     "classincharge c on s.staff_id=c.staff_id where s.staff_id='"+session.getAttribute("userid")+"'  group by s.staff_id";
 //out.print(sql);
 rs=statement.executeQuery(sql);
 String restrict="";
 int ODAdmin=0;
 if(rs.next()){
     restrict=rs.getString(1);
     ODAdmin=rs.getInt(2);
     }
%>

<body>
      <div class="options" align="right">
          <a href='#' onclick="getMyDocument()">MyDocument</a> | <a href="#" onclick="Profile()">Settings</a> | <a href="../common/logoutvalidation.jsp">Logout</a> |
      </div>
<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
			<div class="logo1"><img src="../images/garc.png" height="80px" width="150px;"/></div>
                   
		</div>
	<div id="Search_box"><%=college%></div>
          <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right"></div>
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                        <li><a href="#" onclick="welcome()">Home</a></li>
                        <li><a href="#" onClick="CoursePlan()">Course Work</a></li>
                        <li><a href="#" onClick="attendance()">Attendance </a></li>
                        <li><a href="#" onClick="Assessment()">Assessment </a></li>
                        <li><a href="#" onClick="SubjectResources()">Resources</a></li>			
                        <li><a href="#" onclick="gettimetable()">Time Table</a></li>
                        
                        <li><a href="#" id="inboxmnu" onclick="loadInBox()">Inbox[ <%=unread%> ]</a></li>
                        <%if(!restrict.contains("4")){%>
                            <li><a href="../Hod"  onclick="$('#floatmnu').fadeOut()">HOD Desk</a></li>
                         <%}%>


                        <li><a href="#" onmouseover="showmymenu(this)" >More >></a></li>
                        </ul>
                        <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>         
			<div style="clear:both"></div>
		</div>
</div>
                        <div id="floatmnu" >
                     <ul>
                        <%if(ODAdmin>0){%>
                            <li><a href="#"  onclick="showODForm(),$('#floatmnu').fadeOut()">OnDuty Desk</a></li>
                            
                            <%}if(!restrict.contains("6")){%>
                            <li><a href="#"  onclick="getTimetableSetup(),$('#floatmnu').fadeOut()">TimeTable Desk</a></li>
                            <%}%>
                            <%if(!restrict.contains("5")){%>
                        <li><a href="#" onclick="Report()">Reports</a></li>
                        <%}%> 
                         <%for(int i=1;i<=NO_OF_YEARS;i++){%>
                         <li><a href="#" onclick="window.open('../uploadedFiles/SemesterPlanner/<%=i%>.htm')"><%=i%> Year Planner</a></li>
                         <%}%>
                        
                     </ul>
                 </div>
    <div id="status" class="status">Loading</div>
       
<div id="content_wrapper">
     <%@include file="AjaxPages/AssignedSubjects.jsp" %>
     <div id="top_div">
         <div id="left">
         <div id="Batch1"></div>
         <div id="subSection"></div>
         </div>
	<div id="right">
		
       </div>
		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer"><a href="#" onclick="welcome()">Home</a> |
    <a href="#" onClick="attendance()">Attendance</a> |
    <a href="#" onClick="SubjectResources()">Resources</a> |
    <a href="#" onClick="Assessment()">Assesment</a> |
    <a href="#"  onclick="gettimetable()">Time Table</a> |
     <a href="#" onclick="getMyDocument()">My Documents</a> <br />
    <br />
  <span class="copyright">Visitor Number: <%@ include file="../common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright  </span></div>
<div id="dialog" title="Warning" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete?
         </p>
</div>
<div id="tooltip" style="display:none;">Loading ...</div>
</body>
</html>

