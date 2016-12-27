 

<%@page import="java.sql.*,java.io.*"  %>
<%@ include file="../common/DBConfig.jsp" %>    
<%@ include file="../common/FlashPaperConfig.jsp" %>
<%
 if((session.getAttribute("DB_Name")==null)){
        %>
        <script>
            
            window.location="./";
        </script>
        <%
        return;
    }
try{
           Connection con =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
           Statement st = con.createStatement();
           String sql = "";
           ResultSet rs = null;
           if (request.getParameter("action").equals("showstudent")) {
               if (request.getParameter("section").equals("undefined")) {
                  con.close();
                   return;
               }
               sql = "select student_name,student_id,batch,uguniversity,ugcourse,email,batch from students where semester='" + request.getParameter("semester") + "' and section='" + request.getParameter("section") + "'";
               //out.print(sql);
               rs = st.executeQuery(sql);
%>
     <TABLE cellSpacing=0 cellPadding=5px width=800 border=0>
                            <TBODY valign="top">
                                <% int i = 0;
                                    while (rs.next()) {
                                        
                                    String path = "./images/students/"+rs.getString("batch")+"/" + rs.getString("student_id") + ".jpg";
                                    File file = new File(getServletContext().getRealPath("/")+ path);
                                    if (!file.exists()) {
                                        path = "./images/unknown.png";
                                    }
                                    if (i % 2 == 0) {
                                        out.print("<tr>");
                                    }
                                    i++;
                                 %>
                            <td width="120">
                                <img width="100px" height="120px" src="<%=path%>"/>
                            </td>
                            <td>

                                <ul style="list-style-type:none">
                                    <li style="color:brown;font-weight:bolder;"><%=rs.getString(1)%></li>
                                    <li><%=rs.getString(2)%></li>
                                    <li><%=rs.getString(3)%></li>
                                    <li><%=(rs.getString(4) == null) ? "" : rs.getString(4)%></li>
                                    <li><%=(rs.getString(5) == null) ? "" : rs.getString(5)%></li>
                                    <li><%=(rs.getString(6) == null) ? "" : rs.getString(6)%></li>
                                </ul>
                            </td>

                            <%
                        if (i % 2 == 0) {
                        out.print("</tr>");
                        }

                        }
                        con.close();
                            %>
                        </TBODY>
       </TABLE>
<%
               con.close();
             return;
            }
%>
<div id="top_div">
    <h1>Student Profile</h1>
    <div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">
        Semester:<select id="semester" onchange="StudentProfile()">
            <option value="select">Please Select</option>
            <% sql = "select semester from section";
                rs = st.executeQuery(sql);
                while (rs.next()) {
            %>
                   <option value="<%=rs.getString(1)%>" <%=(request.getParameter("semester").equals(rs.getString(1)))?"selected":""%>><%=rs.getString(1)%></option>
            <%
       }
       out.print("</select>");
       if (!request.getParameter("section").equals("undefined")) {
           int count = 0;
           sql = "select sectioncount from section where semester='" + request.getParameter("semester") + "' ";
           //out.print(sql);
           rs = st.executeQuery(sql);
            %>
            Section <select id="section" onchange="OnchangeStudentProfile()">
                <option value="please Select">Please Select</option>
                <%if (rs.next()) {
                          count = rs.getInt(1);
                      }
                      for (int i = 1; i <= count; i++) {%>
                <option value="<%=i%>"><%=(char) ('A' - 1 + i)%></option>
                <%}%>
            </select>
            <%} else {
            %>
            Section
            <select id="section" disabled>
                <option>Please Select ...</option>
            </select>
            <%            }
            %>
            <div id="studentDisplay">

            </div>
    </div>

</div>

<div style="clear:both"></div>
<%
    con.close();
    }catch(Exception e)
            {out.print(e);}
%>
