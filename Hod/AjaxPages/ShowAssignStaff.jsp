<%--
    Document   : ShowAssignStaff
    Created on : July 20, 2009, 5:53:04 PM
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
<%@ include file="../../common/DBConfig.jsp" %>

<%@page import="java.sql.*"  %>

<%
  try{
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
         int section=0;
            ResultSet rs=null;
        if(request.getParameter("action").toString().equals("view")){
            String sql="select sectioncount from section where semester="+request.getParameter("semester");            
            rs=st.executeQuery(sql);
            while(rs.next())
                section=rs.getInt(1);
       %>
       
            
                            <select name="section" onchange="ShowStaff('<%=request.getParameter("semester")%>')" id="section" class="selectNone" >
                                <option value="Please Select...">Please Select...</option>
                                <%for(int i=1;i<=section;i++){%>
                                <option value="<%=i%>"><%=(char)('A'-1+i)%></option>
                                <%}%>
                            </select>
                     
            <%}else if(request.getParameter("action").toString().equals("show")){
               String[] subjects=new String[15];
               int total_subj=0;
               String sql="select subject_name from subject where semester="+request.getParameter("semester")+" and elective not like 'YES'";
               rs=st.executeQuery(sql);
               while(rs.next()){
               subjects[total_subj]=rs.getString(1);
               total_subj++;
               }
               sql="select subject_name from electives where semester='"+request.getParameter("semester")+"'";
               rs=st.executeQuery(sql);
               while(rs.next()){
               subjects[total_subj]=rs.getString(1);
               total_subj++;
               }
            %>
            <table id="hor-minimalist-b">
            <thead>
            <tr  cellspacing="2" cellpadding="1">
                <th>Subject</th>
                <th>Staff 1</th>
                <th>Staff 2</th>
                
            </tr>
            </thead>
            <tbody>
            <%
            Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement statement=con.createStatement();
            ResultSet rset1=null;
            rs=st.executeQuery("select staff_name from staff order by staff_name");
            for(int i=0;i<total_subj;i++){
                rset1=statement.executeQuery("SELECT z.staff_name FROM assign_staff x,subject y,staff z where x.subject_id = y.subject_id and x.staff_id=z.staff_id and y.subject_name like '"+subjects[i]+"'and x.section="+request.getParameter("section")+"" );
              //  out.print("SELECT z.staff_name,x.class_incharge FROM assign_staff x,subject y,staff z where x.subject_id = y.subject_id and x.staff_id=z.staff_id and y.subject_name like '"+subjects[i]+"' and x.section="+request.getParameter("section")+"");
                rs.first();
            %>
            <tr>
                <td> <%=subjects[i]%> </td>
                <td>                          
                     <select id="fac1<%=i%>" name="year" title="Choose the Faculty">
                              <%
                                  String fac1="",fac2="";
                                  if(rset1.next()){fac1=rset1.getString(1);}
                                  if(rset1.next())fac2=rset1.getString(1);
                              %>
                           <option>Please Select...</option>
                           <%do{%>
                            <option <%=(fac1.equals(rs.getString(1)))?"selected":""%> ><%=rs.getString(1)%></option>
                           <%}while(rs.next());%>
                     </select>
                </td>
                <td>
                     <select id="fac2<%=i%>" name="year" title="Choose the Faculty">
                      <option>Please Select...</option>
                      <% rs.first();
                        do{%>
                              <option <%=(fac2.equals(rs.getString(1)))?"selected":""%> ><%=rs.getString(1)%></option>
                       <%}while(rs.next());%>
                            </select>
                </td>
               
            </tr>
            <%
            }
            con.close();
            %>
            </tbody>
        </table>
            <center><input type="button" value="Assign Staff" name="Submit" onclick="getAssignedStaff('<%=request.getParameter("semester")%>')"></center>
            <%
        }else if(request.getParameter("action").toString().equals("Assign")){

               String[] subject_id=new String[15];
               int count=0;
               rs=st.executeQuery("select subject_id from subject where semester="+request.getParameter("semester")+" and elective not like 'YES'");
               while(rs.next())
               {
                   subject_id[count]=rs.getString(1);
                   count++;
               }
               rs=st.executeQuery("select subject_id from electives where semester="+request.getParameter("semester")+"");
               while(rs.next())
               {
                   subject_id[count]=rs.getString(1);
                   count++;
               }
               st.executeUpdate("delete from assign_staff where semester="+request.getParameter("semester")+" and section = "+request.getParameter("section")+"");
               Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
               Statement statement=con.createStatement();
               for(int i=0;i<count;i++)
               {
                   rs=st.executeQuery("select staff_id from staff where staff_name ='"+request.getParameter("fac1"+i)+"'");
                   if(rs.next())
                       {
                            
                            statement.executeUpdate("insert into assign_staff(staff_id,subject_id,semester,section) values('"+rs.getString(1)+"','"+subject_id[i]+"','"+request.getParameter("semester")+"','"+request.getParameter("section")+"')");
                       }
               }
               for(int i=0;i<count;i++)
               {
                   rs=st.executeQuery("select staff_id from staff where staff_name ='"+request.getParameter("fac2"+i)+"'");
                   if(rs.next())
                       {
                             statement.executeUpdate("insert into assign_staff(staff_id,subject_id,semester,section) values('"+rs.getString(1)+"','"+subject_id[i]+"','"+request.getParameter("semester")+"','"+request.getParameter("section")+"')");
                       }
               }
               out.print("Updated");
               con.close();
        }else
                out.print("<span class=success>No Record Found!</span>");
         connection.close();

  } catch(Exception e){
    out.print("<span class=error>"+e.toString()+"</span>");
}

%>
