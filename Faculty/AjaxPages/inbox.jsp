<%--
    Document   : inbox
    Created on : Aug 21, 2009, 4:02:44 PM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("userid")==null)){
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
<%@ include file="../../common/DBConfig.jsp" %>
<%
    Connection connection =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
     String sql="select count(*) from mail where `to`='"+session.getAttribute("userid")+"' and status='UNREAD'";
     ResultSet rs=statement.executeQuery(sql);
     int unread=0;
     if(rs.next())
         unread=rs.getInt(1);
%>
<script>
    $('#inboxmnu').html("Inbox [ <%=unread%> ]");
</script>
<ul class="action" style="text-align:right;padding-right:40px;">
     <li><a href="#" onclick="compose()">Compose Mail</a></li>
     <li><a href="#" onclick="loadInBox()">Inbox [ <%=unread%> ]</a></li>
</ul>
<%
    if(request.getParameter("action").contains("viewmail")){
        sql="select subject,msg,attachment from mail where `to`='"+session.getAttribute("userid")+"' and id="+request.getParameter("id");
        //out.print(sql);
        rs=statement.executeQuery(sql);
        if(rs.next()){
            String attachement="";
            try{
                float i=Float.parseFloat(rs.getString("attachment"));
            }
            catch(Exception e){
                attachement=rs.getString("attachment");
            }
            %>
            <center><h3><%=rs.getString("subject")%></h3></center>
            <div align='right'>
                <%if(!attachement.equals("")){%>
                <a href='../common/fileDownload.jsp?type=EMAIL&filename=<%=attachement%>' target="_new" >Attachment</a>
                <%}%>
            </div>
            <div> <%= rs.getString("msg")%> </div>
            <%
           
        }
        sql="update mail set status='READ' where id="+request.getParameter("id") ;
        statement.executeUpdate(sql);
    }


if(request.getParameter("action").equals("inbox")){
     sql="select m.id, s.staff_name `from`,timestamp,attachment,status,subject,status from mail m , staff s where `to` = "+session.getAttribute("userid")+" and m.sender_id=s.staff_id "+
                "union "+
                " select m.id, s.student_name `from`,timestamp,attachment,status,subject,status from mail m , students s where `to` = "+session.getAttribute("userid")+" and m.sender_id=s.student_id";
    // out.print(sql);
     rs=statement.executeQuery(sql);
     %>
     <table id="grid" width="750px">
	<thead>
            <tr>
            	<th>From</th>
            	<th>Subject</th>
            	<th>Date</th>
            	<th>Action</th>
            </tr>
    </thead>
    <tbody>

    <%
     while(rs.next()){
    %>

    		<tr <%=(rs.getString("status").equals("READ"))?"":"style='font-weight:bolder'"%>>
            	<td><%=rs.getString("from")%></td>
                <td><%=rs.getString("subject")%></td>
                <td><%=rs.getString("timestamp")%></td>
                <td><a href="#" onclick="viewMail('<%=rs.getString("id")%>')">View</a>|<a href="#" onclick="deleteMail('<%=rs.getString("id")%>')">Delete</a></td>
            	
            </tr>
     <%}%>
    </tbody>
</table>

<%}else if(request.getParameter("action").equals("compose")){%>
<form id="form1" action="../common/sendlocalmail.jsp" method="post" enctype="multipart/form-data" name="form1">
<table width="850px"><tr>
        <td>To: <input type="text" size="60" id="tolist" name="tolist" class="required"/> </td><td>Subject: <input type="text" name="subject" class="required"/></td> 
        <td><input type="submit" value="Send mail" class="required"/></td>
    </tr>
    <tr>
        <td><iframe id="inline" name="inline" src="" style="display:none"></iframe></td>
    </tr>
</table>
    <textarea id="composedata" name="body"  style="width: 850px; height: 250px;" class="required"></textarea>
    <br/><br/>Attachment: <input type="file" name="file">
</form>
<%}
     else if(request.getParameter("action").equals("delete")){
         sql="delete from mail where id="+request.getParameter("id");
         statement.executeUpdate(sql);
     }
     %>
<%
    connection.close();
%>