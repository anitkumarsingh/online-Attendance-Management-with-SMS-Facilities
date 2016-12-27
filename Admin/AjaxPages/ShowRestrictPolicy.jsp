 
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
        if(request.getParameter("action").toString().equals("showallstudent")){
            

           String sql="SELECT *,(CASE WHEN b.user_id is null THEN ' ' ELSE 'checked' END) valid FROM students a left join restricted_user b on a.student_id=b.user_id where a.semester="+request.getParameter("semester")+" or a.semester="+(Integer.parseInt(request.getParameter("semester").toString())-1);
           // String sql="select student_id,student_name,section from students where semester="+request.getParameter("semester")+" or semester="+(Integer.parseInt(request.getParameter("semester").toString())-1);
           // out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            int i=0;
                while(rs.next()){
                    i++;
                %>
                    <li class="ui-widget-content">
                     <img src="../images/accept.png" alt="Accept" onclick="accept('<%=i%>','student')" id="<%=rs.getString("student_id")%>" />
                     <input type="checkbox" name="<%=i%>" id="<%=i%>" value="<%=rs.getString("student_id")%>" <%=rs.getString("valid")%>  />
                     <label for="<%=i%>"><%=rs.getString("student_name")%> [ <%=(char)(Integer.parseInt(rs.getString("section"))+'A'-1)%> ]</label>

                    </li>
                <%
                }
            }
       else if(request.getParameter("action").toString().equals("showallfaculty")){
          
           String sql="SELECT *,(CASE WHEN b.user_id is null THEN ' ' ELSE 'checked' END) valid FROM staff a left join restricted_user b on a.staff_id=b.user_id ";
           // String sql="select student_id,student_name,section from students where semester="+request.getParameter("semester")+" or semester="+(Integer.parseInt(request.getParameter("semester").toString())-1);
           //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            int i=0;
                while(rs.next()){
                    i++;
                %>
                    <li class="ui-widget-content">
                     <img src="../images/accept.png" alt="Accept" onclick="accept('<%=i%>','faculty')" id="<%=rs.getString("staff_id")%>" />
                     <input type="checkbox" name="<%=i%>" id="<%=i%>" value="<%=rs.getString("staff_id")%>" <%=rs.getString("valid")%>  />
                     <label for="<%=i%>"><%=rs.getString("staff_name")%></label>

                    </li>
                <%
                }
            }
       else if(request.getParameter("action").toString().equals("UpdateSelected")){          
            String sql;
            if(request.getParameter("type").toString().equals("student")){
                sql="delete from restricted_user where semester="+request.getParameter("semester")+" or semester="+(Integer.parseInt(request.getParameter("semester").toString())-1);              
                st.executeUpdate(sql);
             }
            else if(request.getParameter("type").toString().equals("faculty")){
                 sql="delete from restricted_user ";
                 st.executeUpdate(sql);
            }
            java.util.StringTokenizer token=new java.util.StringTokenizer(request.getParameter("selected").toLowerCase(),"#");
            while(token.hasMoreElements()){
                sql="insert into restricted_user (user_id,semester) values ('"+token.nextElement().toString()+"','"+request.getParameter("semester")+"')";
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span class=success>Updated</span>");
            else
                out.print("<span class=success>No Change</span>");
            }
        }
    connection.close();
   }
catch(Exception e){
    out.print("<span style='error'>"+e.toString()+"</span>");
}


%>
