<%--
    Document   : AssignStaff
    Created on : July 20, 2009, 3:12:04 PM
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
<script src="js/AssignStaff.js"></script>
<title>Assign Staff</title>
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
			<li><a href="#">Assign Staff</a></li>
                        <li><a href="SetElective.jsp">Set Elective</a></li>
                         <li><a href="#" onclick="getTimetableReport()">Time Table</a></li>
			<li><a href="../Faculty">Faculty Desk</a></li>
            
            <li><a href="../common/logoutvalidation.jsp">SignOut</a></li>
            </ul>
            <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %> &beta;eta testing</div>   
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">

 	<div id="top_div">

 

		<div id="right">

                    <h3>Assign Staff</h3>

			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
                         <div id="tabs">
			<ul>
				<li><a href="#tabs-1">Assign</a></li>
				
			</ul>
			<div id="tabs-1">
                            <div id="Form">
                                <table>
                                    <tr>
                                        <th>Year</th>
                                        <td>
                                          <select onchange="ShowDetails(this.value)">
                                                <option>Please Select</option>
                                                <%
                                                Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                                                Statement st=connection.createStatement();
                                                ResultSet rs=st.executeQuery("select semester from section");
                                                while(rs.next()){%>
                                                <option value="<%=rs.getInt(1)%>"><%=(rs.getInt(1)+1)/2%></option>
                                               <%}%>
                                          </select>
                                        </td>
                                        <th>Section</th>
                                        <td><div id="SectionDiv"><select disabled><option>Please Select</option></select></div></td>
                                    </tr>
                                </table>
                                 <%
                                  connection.close();
                                      %>
                                </ul>
                                <div id="Showfaculty"></div>
                           
                            </div>
                        </div>
                        

			</div>


		</div>


		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>
</div>
<div id="footer_div" class="footer">
     <a href="index.jsp">Home</a>
			 <a href="AssignStaff.jsp">Assign Staff</a> |
                         <a href="SetElective.jsp">Set Electives</a> |
                         <a href="#" onclick="getTimetableReport()">Time Table</a> |
                         <a onclick="Report()">Reports</a>
    <br />
  <span class="copyright">Visitor Count:<%@ include file="../common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright  </span></div>

</body>
</html>

