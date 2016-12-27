 
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("admin"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@ include file="../../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>

<%
  try{
       
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();

        if(request.getParameter("action").toString().equals("view")){
            String sql="select * from subject where semester='"+request.getParameter("semester")+"'";
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            
            <table id="hor-minimalist-b">
                <tr>
                    <th>Subject ID</th>
                    <th>Subject Name</th>
                    <th>Semester</th>
                    <th>Elective</th>
                    <th>LAB</th>
                    <th>Action</th>
                </tr>
            <%
            while(rs.next()){
            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=(rs.getString(4).equals("YES"))?"Yes":"No"%></td>
                <td><%=(rs.getString(5).equals("YES"))?"Yes":"No"%></td>
                <td>
                    <ul class="action">
                        <li onclick="DeleteSubject('<%=rs.getString(1)%>','<%=rs.getString(3)%>')" class="delete"><a >Trash</a></li>
                <li  onclick="EditSubject('<%=rs.getString(1)%>')" class="edit"><a href="#">Edit</a></li>
                </ul>
                </td>
            </tr>
            <%
            }
            %>
            </table>
       
            <%
        }
        else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from subject where subject_id='"+request.getParameter("subject_id")+"'";
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span>No Change...</span>");
        }

           else if(request.getParameter("action").toString().equals("update")){
            String semester=request.getParameter("semester");
            if(request.getParameter("elective")!=null && request.getParameter("elective").equals("YES"))
                semester="-";
            String sql="update subject set subject_name='"+request.getParameter("subject_name")+"', elective='"+request.getParameter("elective")+"', lab='"+request.getParameter("lab")+"', semester='"+semester+"' where subject_id='"+request.getParameter("subject_id")+"'";
            //out.print(sql);
            
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span>No Change...</span>");

        }else if(request.getParameter("action").toString().equals("editview")){
            String sql="select subject_name,semester,elective,lab from subject where subject_id='"+request.getParameter("subject_id")+"'";
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){

            %>
            <form id="updateForm">
           <table style="margin:auto" cellspacing="2" cellpadding="1" width="75%">
                <thead>
                    <tr>
                        <th>Subject ID</th>
                        <th><%=request.getParameter("subject_id")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Subject Name</td>
                        <td><input type="text" name="subj_name" id="subj_name" class="required"  value="<%=rs.getString(1)%>" /></td>
                    </tr>

                     <tr>
                                        <td>Semester</td>
                                        <td colspan="3">
                                            <select name="semester" id="semester" class="required" >
                                                <option value="selectone" selected>Please Select...</option>
                                                <%for(int i=1;i<NO_OF_YEARS*2;i++){%>
                                                <option value="<%=i%>"  <%=(rs.getString(2).equals(i+""))?"selected":""%>><%=i%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Elective</td>
                                        <td colspan="3">
                                            <input name="electiveupdate" <%=(rs.getString(3).equals("YES"))?"checked":""%> id="electiveupdate" type="checkbox" value="YES"/>YES
                                        </td>
                                    </tr>
                                     <tr>
                                        <td>LAB</td>
                                        <td colspan="3">
                                            <input name="labupdate" <%=(rs.getString(4).equals("YES"))?"checked":""%> id="labupdate" type="checkbox" value="YES"/>YES
                                                <%}%>
                                        </td>
                                    </tr>

                </tbody>
            </table>
        </form>
                    <center><input type="button" value="Update" name="update" onclick="UpdateSubject('<%=request.getParameter("subject_id")%>',$('#semester').val())"/></center>
            <%
           }else
                out.print("<span class=success>No Record Found!</span>");
                connection.close();
    }catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }%>