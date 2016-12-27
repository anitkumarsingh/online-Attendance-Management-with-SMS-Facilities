<%--
    Document   : AssessmentMarks
    Created on : Aug 5, 2009, 10:28:46 AM
    Author     : Dinesh Kumar.D
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
<%@page import="java.sql.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>

 <%
            try {
//		out.print("Saved ...");
                Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                String elective=session.getAttribute("elective").toString();
                String subject_id=session.getAttribute("subject_id").toString();
                String semester=session.getAttribute("semester").toString();
                int section= Integer.parseInt(session.getAttribute("section").toString());
                
                if(request.getParameter("action").toString().equals("list"))
                {
                String sql="select examid,examname from assessment_master where subject_id='"+subject_id+"' and section="+section;
                ResultSet rs=statement.executeQuery(sql);                
                %>
                <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
                <center><h3><%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h3></center><br>
                <p style="font-weight:bolder">Select Assessment Name  :&nbsp;&nbsp;&nbsp;<select id="examtype" onchange="getStudents(this.value)">
                         <option>Please Select</option>
                         <%while(rs.next()){%>
                         <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                         <%}%>
                </select></p>

                <%
                connection.close();
                
                return;
                }else if(request.getParameter("action").toString().equals("none")){
                  String sql="";
                  String examid=request.getParameter("examid");
                  ResultSet rs=statement.executeQuery("select *,DATE_FORMAT(`examdate`,'%d/%m/%Y') day from assessment_master where examid='"+examid+"'");
                  if(rs.next())
                      {%>
                      <table class="clienttable" cellspacing="0">
                          <tr>
                              <td style="font-weight:bolder">Assessment Name :</td>&nbsp;<%=rs.getString(3)%>&nbsp;&nbsp;&nbsp;&nbsp; <td style="font-weight:bolder">Date :</td>&nbsp;<%=rs.getString("day")%>&nbsp;&nbsp;&nbsp;&nbsp;
                              <td style="font-weight:bolder">Weightage :</td>&nbsp;<%=rs.getString(6)%>&nbsp; % &nbsp;&nbsp;&nbsp;&nbsp;<td style="font-weight:bolder">Maximum Marks :</td>&nbsp;<%=rs.getString(7)%>                          </tr>
                      </table><br/>
                      <%}
                if(elective.equals("yes"))
                    sql="select s.* from students s,elective_students e where e.student_id=s.student_id and e.subject_id='"+subject_id+"' order by s.student_id";
                else
                    sql="select * from students where semester="+semester+" and section="+section +" order by student_id";
                rs=statement.executeQuery(sql);
                %>
                <table class="clienttable" cellspacing="0">
                 <thead>
                    <tr>
                        <th>Reg#</th>
                        <th>Student Name</th>
                        <th>Mark</th>
                        <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                        <th>Reg#</th>
                        <th>Student Name</th>
                        <th>Mark</th>
                        <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                        <th>Reg#</th>
                        <th>Student Name</th>
                        <th>Mark</th>
                    </tr>
                </thead>
                <tbody>
                <%
                Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement st=con.createStatement();
                ResultSet rset1=null;
                sql="select mark from marks where examid='"+examid+"' order by student_id";
                rset1=st.executeQuery(sql);
                while(rs.next()){%>
                <tr>
                    <td><%=rs.getString(1).substring(rs.getString(1).length()-3)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><input  value="<%=(rset1.next())?rset1.getString(1):""%>" type="text" id="<%=rs.getString(1)%>" size="3" onKeyUp="res(this,marks)" maxlength="3"></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>

                    <%if(rs.next()){%> 
                        <td><%=rs.getString(1).substring(rs.getString(1).length()-3)%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><input maxlength="3" value="<%=(rset1.next())?rset1.getString(1):""%>" type="text" id="<%=rs.getString(1)%>" size="3"  onKeyUp="res(this,marks)" maxlength="3"></td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <%}%>
                   
                    <%if(rs.next()){%>
                        <td><%=rs.getString(1).substring(rs.getString(1).length()-3)%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><input value="<%=(rset1.next())?rset1.getString(1):""%>" type="text" id="<%=rs.getString(1)%>" size="3" onKeyUp="res(this,marks)" maxlength="3"></td>
                    <%}%>
                </tr>
              <%}%>
                </tbody>
                </table>
                <center><input type="button" value="Save" onclick="AddMarks('<%=examid%>')"></center>
               <%
                connection.close();
               
                con.close();
                
                return;
                }else if(request.getParameter("action").toString().equals("add")){
                String sql="";
                String examid=request.getParameter("examid");
		statement.executeUpdate("delete from marks where examid='"+examid+"'");
                //out.print("delete from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
                if(elective.equals("yes"))
                    sql="select student_id from elective_students where subject_id='"+subject_id+"' order by student_id";
                else
                    sql="select student_id from students where semester="+semester+" and section="+section +" order by student_id";
                ResultSet rs=statement.executeQuery(sql);
                Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement st=con.createStatement();
                while(rs.next()){
                sql="insert into marks values('"+rs.getString("student_id")+"','"+examid+"','"+request.getParameter(rs.getString("student_id"))+"')" ;
                //out.print(sql);
                st.executeUpdate(sql);
                }
		//out.print(sql);
                con.close();
                
                connection.close();
                
                return;
                }
		connection.close();
                
                }catch(Exception e){
                    out.print(e.toString());
                }
         %>













