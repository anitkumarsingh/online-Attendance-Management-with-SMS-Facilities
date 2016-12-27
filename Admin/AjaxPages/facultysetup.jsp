 
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
        if(request.getParameter("action").toString().equals("deleteincharge")){
            String sql="delete from classincharge where staff_id='"+request.getParameter("staff_id")+"' and semester='"+request.getParameter("semeter")+"' and section='"+request.getParameter("section")+"'";
            st.executeUpdate(sql);
        }
        else if(request.getParameter("action").toString().equals("addODForm")){
            String sql="insert into classincharge values('"+request.getParameter("staff_id")+"','"+request.getParameter("section")+"','"+request.getParameter("semester")+"')";
            st.executeUpdate(sql);
        }
        else if(request.getParameter("action").toString().equals("odform")){
            String sql="select sectioncount,semester from section  order by semester";
            ResultSet rs=st.executeQuery(sql);            
            %>
            <table id="hor-minimalist-b">
                <th>
            Year:</th><th><select id="year">
                <%while(rs.next()){%>
                <option value="<%=rs.getString(2)%>"><%=(rs.getInt(2)+1)/2%></option>
                <%}%>
                    </select></th>
                    <th>
                        Section:</th><th><select id="section">
                <%for(int i=1;i<=NO_OF_SECTIONS;i++){%>
                <option value="<%=i%>"><%=(char)('A'-1+i)%></option>
                <%}%>
                        </select></th>
            <%
            sql="select staff_id,staff_name from staff order by staff_name";
            rs=st.executeQuery(sql);
            %>
            <th>Faculty:</th><th><select id="staff_id">
                <%while(rs.next()){ %>
                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                <%}%>
                </select></th>
                
            </table>
                <center>
            <input type="button" value="Add" onclick="addODIncharge()"/>
                </center>
            <table id="hor-minimalist-b">
                <thead>
                <th>Semester</th>
                <th>Section</th>
                <th>Faculty Name</th>
                <th>Action</th>
                </thead>
            <%
                sql="select s.staff_name,c.staff_id,c.semester,c.section from classincharge c,staff s where s.staff_id=c.staff_id";
                rs=st.executeQuery(sql);
                while(rs.next()){
                    %>
                    <tr>
                    <td><%=rs.getString(3)%></td>
                    <td><%=(char)(rs.getInt(4)+'A'-1)%></td>
                    <td><%=rs.getString(1)%></td>
                    <td><ul class="action"><li onclick="deleteIncharge('<%=rs.getString(2)%>','<%=rs.getString(3)%>','<%=rs.getString(4)%>')" class="delete">Trash</li></ul></td>
                    </tr>
                    <%
                }
            %>
        </table>
            <%
          
         }
        else if(request.getParameter("action").toString().equals("view")){
            String sql="select x.staff_id,staff_name,group_concat(report) from staff x left join staff_permissions y on x.staff_id=y.staff_id group by staff_id order by staff_name ";
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
<table id="hor-minimalist-b">
    <tr>
        <th rowspan="2" valign="top">NAME</th>
        <th colspan="3">ENABLE REPORTS</th>
        <th colspan="2">DISABLE LINKS</th>
    </tr>
    <tr>
        <td>ATTENDANCE</td>
        <td>MARKS</td>
        <td>TIME TABLE</td>

        <td>HOD DESK</td>
        <td>REPORT</td>
        <td>TIMETABLE</td>
        <!--td>RESULT DESK</td-->

    </tr>
    <%while(rs.next()){%>
    <tr>
        <td><%=rs.getString(2)%></td>
        <td><input type="checkbox" id="<%=rs.getString(1)%>-1" <%=rs.getString(3)!=null && rs.getString(3).contains("1")?"checked":""%>/></td>
        <td><input type="checkbox" id="<%=rs.getString(1)%>-2" <%=rs.getString(3)!=null && rs.getString(3).contains("2")?"checked":""%>/></td>
        <td><input type="checkbox" id="<%=rs.getString(1)%>-3" <%=rs.getString(3)!=null && rs.getString(3).contains("3")?"checked":""%>/></td>
        <td><input type="checkbox" id="<%=rs.getString(1)%>-4" <%=rs.getString(3)!=null && rs.getString(3).contains("4")?"checked":""%>/></td>
        <td><input type="checkbox" id="<%=rs.getString(1)%>-5" <%=rs.getString(3)!=null && rs.getString(3).contains("5")?"checked":""%>/></td>
        <td><input type="checkbox" id="<%=rs.getString(1)%>-6" <%=rs.getString(3)!=null && rs.getString(3).contains("6")?"checked":""%>/></td>
        
    </tr>
    <%}%>
</table>
    <input type="button" onclick="setpermission()" value="Set Permission">
<%}
  else if(request.getParameter("action").toString().equals("add")){
      String sql="delete from staff_permissions";
      st.executeUpdate(sql);
      
      String item[]=request.getParameter("items").split("~");
     // out.print(request.getParameter("items"));
      for(int i=0;i<item.length;i++){
          //out.print(item[i]);
          String field[]=item[i].split("-");
          sql="insert into staff_permissions values("+field[0]+","+field[1]+")";         
          st.executeUpdate(sql);
      }

  }
connection.close();
}catch(Exception e){out.print(e.toString());}
  %>