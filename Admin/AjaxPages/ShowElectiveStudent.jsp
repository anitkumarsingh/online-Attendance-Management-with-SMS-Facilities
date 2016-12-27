 
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
<%@ include file="../../common/DBConfig.jsp" %>
<%@page import="java.sql.*"  %>

<%
  try{
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        if(request.getParameter("action").toString().equals("showallstudent")){

            String sql="select x.student_id,x.student_name,x.section,GROUP_CONCAT(IF(subject_id='"+request.getParameter("subject_id")+"','checked','') SEPARATOR ' ') from students x left join elective_students y on x.student_id=y.student_id where semester="+request.getParameter("semester")+" or semester="+(Integer.parseInt(request.getParameter("semester").toString())-1)+" group by x.student_id";
            ResultSet rs=st.executeQuery(sql);
            int i=0;
                while(rs.next()){
                    i++;
                %>
                    <li class="ui-widget-content">
                        <img src="../images/accept.png" alt="Accept" onclick="acceptStudent('<%=i%>')" id="<%=rs.getString(1)%>" />
                     <input type="checkbox" name="<%=i%>" id="<%=i%>" value="<%=rs.getString(1)%>" <%=rs.getString(4)%> />
                     <label for="<%=i%>"><%=rs.getString(2)%> [ <%=(char)(Integer.parseInt(rs.getString(3))+'A'-1)%> ]</label>
                   
                    </li>
                <%
                }
            }
        else if(request.getParameter("action").toString().equals("showelectivesubject")){
             String sql="select subject_id,subject_name from electives where semester="+request.getParameter("semester")+" or semester="+(Integer.parseInt(request.getParameter("semester").toString())-1);
            // out.print(sql);
             ResultSet rs=st.executeQuery(sql);
             %>
             <select id="subject_id" onchange="loadElectiveStudents(this.value)" style="width:80%">
                 <option value="Please Select ...">Please Select ...</option>
             <%
             while(rs.next()){
                 %>
                 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                 <%
             }
             %></select>
                 <%
        }
        else if(request.getParameter("action").toString().equals("showelectivestudent")){
            String sql="select x.student_id,x.student_name,x.section,IF(x.student_id=y.student_id,'checked','') from students x,elective_students y where y.subject_id like  '"+request.getParameter("subject_id")+"'";
            ResultSet rs=st.executeQuery(sql);
            int i=0;
                while(rs.next()){
                    i++;
                %>
                    <li class="ui-widget-content">
                        <img src="../images/delete.png" alt="delete" onclick="deleteStudent('<%=i%>')" id="<%=rs.getString(1)%>" />
                     <input type="checkbox" name="<%=i%>" id="<%=i%>" value="<%=rs.getString(1)%>" <%=rs.getString(4)%>/>
                     <label for="<%=i%>"><%=rs.getString(2)%> [ <%=(char)(Integer.parseInt(rs.getString(3))+'A'-1)%> ] </label>

                    </li>
                <%
                }
        }
        else if(request.getParameter("action").toString().equals("addelectivestudent")){
            String sql="delete from elective_students where subject_id='"+request.getParameter("subject_id")+"'";
            //out.print(sql);
            st.executeUpdate(sql);
            java.util.StringTokenizer token=new java.util.StringTokenizer (request.getParameter("student_id"),"#");
            while(token.hasMoreElements()){
                sql="insert into elective_students values('"+token.nextElement()+"','"+request.getParameter("subject_id")+"')";
                st.executeUpdate(sql);
            }
            out.print("Inserted");
        }
        connection.close();
        }
            catch(Exception e){
                
                out.print(e.toString());
            }
%>