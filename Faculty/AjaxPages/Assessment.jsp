<%--
    Document   : Assessment
    Created on : Aug 6, 2009, 10:28:46 AM
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
    if(session.getAttribute("semester")==null){
        out.print("<h3><center>No Subjects Assigned!</center></h3>");
        return;
    }
 %>
<%@page import="java.sql.*"  %>

<%@ include file="../../common/DBConfig.jsp" %>

 
<div id="tabs">
		<ul>
                    <li><a href="#tabs-1" onclick="Assessment()">Assessment Plan</a></li>
                        <li><a href="#tabs-2" onclick="AssessmentMarks()">Assessment Add/Edit</a></li>
                        <li><a href="#tabs-3" onclick="ViewAssessment()">View</a></li>
                      
		</ul>
                <div id="tabs-1">
                <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
                <center><h3><%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h3></center><br>
                <div id="addForm">
                    <%if(request.getParameter("action").equals("none")){%>
            <table class="clienttable" cellspacing="0">
            <thead>
            <tr   cellpadding="1">
                <th>Assessment Type</th>
                <th>Date</th>
                <th>Weightage</th>
                <th>Maximum Marks</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input size="15" class="required" type="text"  id="type" name="type" value="" /></td>
                <td><input size="15" type="text"  id="date" name="type" value="" /></td>
                <td><input class="required" type="text"  id="weightage" name="type" maxlength="3" size="5" onKeyUp="res(this,number)"/></td>
                <td><input size="5" class="required" type="text"  id="marks" name="type" value="" maxlength="3" onKeyUp="res(this,number)"/></td>
                <td><ul class="action">
                    <li onclick="AddAssessmentPlan()" class="save"><a href="#">Add</a></li>
                    </ul>
                </td>
            </tr>
            </tbody>
       </table><%}%>
<% 
 try{
        Connection connection =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
          if(request.getParameter("action").toString().equals("add")){
                int rec = st.executeUpdate("insert into assessment_master(subject_id,examname,examdate,section,weightage,max_marks,staff_id) values('"+session.getAttribute("subject_id")+"','"+request.getParameter("type")+"',STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y'),'"+session.getAttribute("section")+"',"+request.getParameter("weightage")+",'"+request.getParameter("marks")+"','"+session.getAttribute("userid")+"')");
                 if(rec>0)
                    out.print("<span>Updated...</span>");
                 else
                     out.print("<span>No Change...</span>");
                // connection.close();
              //  pool.free(connection);

            }else if(request.getParameter("action").toString().equals("update")){
            String sql="update assessment_master set examname='"+request.getParameter("type")+"',examdate=STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y'),weightage="+request.getParameter("weightage")+",max_marks="+request.getParameter("marks")+" where examid="+request.getParameter("sno");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span >"+sql+"No Change...</span>");
           }else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from assessment_master where examid="+request.getParameter("sno");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span>No Change...</span>");
            }else if(request.getParameter("action").toString().equals("editview")){
            String sql="select *,DATE_FORMAT(`examdate`,'%d/%m/%Y') day from assessment_master where examid="+request.getParameter("sno");
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){%>
<table class="clienttable" cellspacing="0">
            <thead>
            <tr  cellpadding="1">
                <th>Assessment Type</th>
                <th>Date</th>
                <th>Weightage</th>
                <th>Maximum Marks</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input size="15" type="text" class="required" id="edittype" name="type" value="<%=rs.getString(3)%>" /></td>
                <td><input size="15" type="text" class="required" id="editdate" name="type" value="<%=rs.getString("day")%>" /></td>
                <td><input size="5" type="text" class="required"  id="editweightage" name="type" value="<%=rs.getString(6)%>" onKeyUp="res(this,number)"/></td>
                <td><input size="5" type="text" class="required" id="editmarks" name="type" value="<%=rs.getString(7)%>" onKeyUp="res(this,number)"/></td>
                <td><ul class="action">
                    <li onclick="UpdateAssessmentPlan('<%=rs.getString(1)%>')" class="save"><a href="#">Update</a></li>
                    </ul>
                </td>
            </tr>
            </tbody>
       </table>


<%}
            else
                out.print("<span class=success>No Record Found!</span>");
}%>
                   
                    </div>

            <div id="report">
            <table class="clienttable" cellspacing="0">
            <thead>
            <tr   cellpadding="1">
                <th>Assessment Type</th>
                <th>Date</th>
                <th>Weightage</th>
                <th>Maximum Marks</th>
            </tr>
            </thead>
            <tbody>
            <%
            String sql="select *,DATE_FORMAT(`examdate`,'%d/%m/%Y') day from assessment_master where subject_id='"+session.getAttribute("subject_id")+"' and section="+session.getAttribute("section")+"";
            ResultSet rs=st.executeQuery(sql);
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString("day")%></td>
                <td><%=rs.getString(6)%>&nbsp;%</td>
                <td><%=rs.getString(7)%></td>
                <td>
                    <ul class="action">
                    
                        <li  onclick="EditAssessmentPlan('<%=rs.getString(1)%>')" class="edit"><a href="#">Edit</a></li>&nbsp;&nbsp;&nbsp;
                <li onclick="DeleteAssessmentPlan('<%=rs.getString(1)%>')" class="delete"><a href="#">Trash</a></li>
                </ul>
                </td>
            </tr>

            </tbody>

        <%}%>
        </table>
            </div>

       
                </div>

                <div id="tabs-2">
                    <div id="Select"> </div>
                    <div id="studentsDispaly"> </div>
                </div>

                 <div id="tabs-3">

                </div>
 <%

            connection.close();
     }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
  }%>
</div>