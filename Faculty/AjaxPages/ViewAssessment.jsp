<%-- 
    Document   : ViewAssessment
    Created on : Aug 10, 2009, 2:38:17 PM
    Author     : Dinesh Kumar D
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
                Connection connection =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                String elective=session.getAttribute("elective").toString();
                String subject_id=session.getAttribute("subject_id").toString();
                String semester=session.getAttribute("semester").toString();
                int section= Integer.parseInt(session.getAttribute("section").toString());
                if(request.getParameter("action").toString().equals("list"))
                {
                  String sql="";
                  String examid=request.getParameter("examid");
                  %>
                  <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
                  <h1>Internal Assessment Report for <%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h1>
                    <table class="Table" cellspacing="0" >
                   <thead>
                        <tr>
                            <th>Reg. No.</th>
                            <th>Student Name</th>
                            <%  ResultSet rs=null;
                                sql="select examname from assessment_master where subject_id='"+subject_id+"' and section="+section;
                                rs=statement.executeQuery(sql);
                                while(rs.next()){
                            %>
                            <th><%=rs.getString(1)%></th>
                            <%}%>
                        </tr>
                    </thead>
                    <tbody>
                <%                
                Connection con =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement st=con.createStatement();
                ResultSet rset1=null;
                if(elective.equals("yes"))
                    sql="select s.* from students s,elective_students e where e.student_id=s.student_id and e.subject_id='"+subject_id+"' order by s.student_id";
                else
                    sql="select * from students where semester="+semester+" and section="+section +" order by student_id";
                rs=statement.executeQuery(sql);
                Connection conn =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement stmt=con.createStatement();
                ResultSet rset=null;
                while(rs.next()){%>
                <tr>
                    <td><%=rs.getString(1).substring(rs.getString(1).length()-2)%></td>
                    <td><%=rs.getString(2)%></td>
                    <% rset=stmt.executeQuery("select examid from assessment_master where subject_id='"+subject_id+"' and section="+section+"");
                    while(rset.next())
                    {
                    rset1=st.executeQuery("select mark from marks where examid='"+rset.getString(1)+"' and student_id='"+rs.getString(1)+"'");
                    if(rset1.next()){%>
                     <td><%=rset1.getString(1)%></td>
                    <%}
                    %>

                <%}%>
                </tr>
                <%}%>
                <tr><td></td><td>Class Average: </td></tr>
                </tbody>
                </table>
            
                <%
                conn.close();
                connection.close();
                con.close();
                return;
                }
                connection.close();
            }catch(Exception e){
                  out.print(e.toString());
                }%>




