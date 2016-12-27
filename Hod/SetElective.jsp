<%--
    Document   : Set Electives
    Created on : July 20, 2009, 10:12:04 PM
    Author     : Dinesh Kumar
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/table-style.css" />
<link rel="stylesheet" href="../js/transform/jqtransformplugin/jqtransform.css" type="text/css" media="all" />
<script src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/transform/jqtransformplugin/jquery.jqtransform.js" ></script>
<script src="./js/HOD.js"></script>
<!-- jQuery UI -->
<link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui.js"></script>

<script src="js/SetElectives.js"></script>

<title>Set Electives</title>
</head>

<body>
<div id="status" class="status"> Status</div>
<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
             <div class="logo1"><img src="../images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center><%=college%></center></div>
    <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>
	</div>
	<div id="menu">
	<div id="hovermenu" class="hovermenu">
	<ul>
	    <li><a href="index.jsp">Home</a></li>
	    <li><a href="AssignStaff.jsp">Assign Staff</a></li>
            <li><a href="#">Set Elective</a></li>
            <li><a href="#" onclick="getTimetableReport()">Time Table</a></li>
	   <li><a href="../Faculty">Faculty Desk</a></li>
            <li><a href="../common/logoutvalidation.jsp">SignOut</a></li>
        </ul>
        <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %> &beta;eta testing</div>   
	<div style="clear:both"></div>
	</div>
	</div>
	<div style="clear:both"></div>
</div><%
try {
                Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                ResultSet rset;
                if(request.getParameter("sem")!=null) // For add Entry
                        {
                            String sem,elective1,elective2,elective3,e_id1=" ",e_id2=" ",e_id3=" ";
                            sem = request.getParameter("sem");
                            elective1 = request.getParameter("elective1");
                            rset=statement.executeQuery("select subject_id from subject where subject_name like '"+elective1+"'");
                            if(rset.next())
                                e_id1=rset.getString(1);
                            elective2 = request.getParameter("elective2");
                            rset=statement.executeQuery("select subject_id from subject where subject_name like '"+elective2+"'");
                            if(rset.next())
                                e_id2=rset.getString(1);
                            elective3 = request.getParameter("elective3");
                            rset=statement.executeQuery("select subject_id from subject where subject_name like '"+elective3+"'");
                            if(rset.next())
                                e_id3=rset.getString(1);
                            if(e_id1!=" ")
                            statement.executeUpdate("insert into electives(subject_id,semester,subject_name)values('"+e_id1+"','"+sem+"','"+elective1+"')");
                            if(e_id2!=" ")
                            statement.executeUpdate("insert into electives(subject_id,semester,subject_name)values('"+e_id2+"','"+sem+"','"+elective2+"')");
                            if(e_id3!=" ")
                            statement.executeUpdate("insert into electives(subject_id,semester,subject_name)values('"+e_id3+"','"+sem+"','"+elective3+"')");
                            }%>
<div id="content_wrapper">
     	<div id="top_div">
        	<div id="right">
			<h3>Set Elective Papers</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
			<div id="tabs">
			<ul>
				<li><a href="#tabs-1">Assign Elective</a></li>
				<li><a href="#tabs-2">View/Delete</a></li>

			</ul>
			<div id="tabs-1">
                            <form id="addForm">
                            <table border="0" cellspacing="2" cellpadding="1">
                                    <tr>
                                        <th>Semester</th>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <select name="sem" class="selectNone" >
                                                <option value="Please Select...">Please Select...</option>
                                                <%for(int i=1;i<=NO_OF_YEARS*2;i++){%>
                                                <option><%=i%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Elective Papers</th>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                        <select id="elective1" name="elective1" title="Choose any Elective">
                                                <option>Select Elective</option>
                                                <%
                                                rset=statement.executeQuery("select subject_name from subject where elective='YES' order by subject_name");
                                                while(rset.next())
                                                    out.print("<option>"+rset.getString(1)+"</option>");
                                                %>
                                            </select>
                                        </td>
                                     </tr>
                                     <tr>
                                         <td><select id="elective2" name="elective2" title="Choose any Elective">
                                                <option>Select Elective</option>
                                                <%
                                                rset=statement.executeQuery("select subject_name from subject where elective='YES' order by subject_name");
                                                while(rset.next())
                                                    out.print("<option >"+rset.getString(1)+"</option>");
                                                %>
                                        </select>
                                         </td>
                                    </tr>
                                    <tr>
                                         <td><select id="elective3" name="elective3" title="Choose any Elective">
                                                <option>Select Elective</option>
                                                <%
                                                rset=statement.executeQuery("select subject_name from subject where elective='YES' order by subject_name");
                                                while(rset.next())
                                                    out.print("<option >"+rset.getString(1)+"</option>");
                                                %>
                                        </select>
                                         </td>
                                    </tr>
                                  </table>

                            <center><input type="submit" value="Submit" name="addelective"/></center>
                          </form>
                        </div>
			<div id="tabs-2">
                             <div id="ElectiveDetail"></div>
                        </div>

		</div>
                        </div>
			<div align="right" class="read">[ <a href="#"></a> ]</div>



		</div>

		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>
<% connection.close();

   }catch(Exception e){
%>
       <script>
            alert("Operation Failed....\nplease inform administrator");
            alert("Error: <%=e.toString()%>");
        </script>
<%}%>

<div id="footer_div" class="footer">
     <a href="index.jsp">Home</a>
			 <a href="AssignStaff.jsp">Assign Staff</a> |
                         <a href="SetElective.jsp">Set Electives</a> |
                         <a href="#" onclick="getTimetableReport()">Time Table</a> |
                         <a onclick="Report()">Reports</a>
    <br />
  <span class="copyright">Visitor Count:<%@ include file="../common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright  </span></div>
<div id="dialog" title="Warning">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the record ?
         </p>
</div>
</body>
</html>

