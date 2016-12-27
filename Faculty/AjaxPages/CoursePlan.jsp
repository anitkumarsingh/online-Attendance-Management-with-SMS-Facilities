<%--
    Document   : CoursePlan
    Created on : Aug 1, 2009, 10:28:46 AM
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
<%@ include file="../../common/pageConfig.jsp" %>
<%
 try{
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        %>
<div id="tabs">
		<ul>
                    <li><a href="#tabs-1" onclick="CoursePlan()">Course Planner</a></li>
                    <li><a href="#tabs-2" onclick="CourseOutline()">Course Outline</a></li>
                    <li><a href="#tabs-3" onclick="CourseCoverage()">Course Coverage</a></li>
                    <!--li><a href="#tabs-4" onclick="CourseDelivery()">Course Delivery</a></li-->
                    <li><a href="#tabs-5" onclick="CourseProgress()">Course Progress</a></li>
		</ul>
                <div id="tabs-1">
                    <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
                    <center><h3><%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h3></center>
                    <div id="addForm">
                     <%if(request.getParameter("action").equals("none")){
                         %>
                    <table id="hor-minimalist-b">
                                   <%
                        for (int ind=1;ind<=5;ind++) {
                        %>
                            <tr>
                                   <td>Category</td>
                                   <td>
                                        <select name=<%="category"+ind%> id=<%="category"+ind%> class="required" >
                                            <option value="selectone">Please Select...</option>
                                            <%for(int i=1;i<=NO_OF_UNITS;i++){%>
                                            <option value="<%=i%>"><%=i%></option>
                                            <%}%>
                                            <option value="6">Other</option>
                                        </select>
                                   </td>
                                  <td>Topic</td>
                                  <td colspan="3"><input size="30" type="text"  id=<%="topic"+ind%> name=<%="topic"+ind%> value="" class="required"  /></td>
                                  <td>Planned Hrs</td>
                                  <td><input type="text" id=<%="pl_hr"+ind%> name=<%="pl_hr"+ind%> size="3" value="" class="required" alt="number" onKeyUp="res(this,number)"/></td>

                               </tr>
                         <%
                         }
                         %>
                            
                               
                               </tbody>
                    </table>
                    <CENTER><input type="button" value="Add" name="Add" onclick="AddCoursePlan()" /> </CENTER>
                                   <%}%>
                    </div>
 <%

        if(request.getParameter("action").toString().equals("view")){
                 String subj_id,sec,category[],topic[],pl_hr[];
                 subj_id=session.getAttribute("subject_id").toString();
                 sec=session.getAttribute("section").toString();
                 category=request.getParameter("category").toString().trim().split("#");
                 topic = request.getParameter("topic").toString().trim().split("#");
                 pl_hr=request.getParameter("pl_hr").toString().trim().split("#");
                 
                 //ac_hr=(request.getParameter("ac_hr").equals("")?null:request.getParameter("ac_hr"));
                 //ac_date=(request.getParameter("ac_date").equals("")?null:request.getParameter("ac_date"));
                 //out.print("insert into course_planner(section,subject_id,category,topic,planned_hrs,actual_hrs,actual_date) values('"+sec+"','"+subj_id+"','"+category+"','"+topic+"','"+pl_hr+"',"+ac_hr+",'"+ac_date+"')");
               for (int ind=0;ind<pl_hr.length;ind++) {
                   if(category[ind].contains("Please")){
                       out.print("<script>alert('Please Select the Category/Topic')</script>");
                       continue;
                    }
                 int rec = st.executeUpdate("insert into course_planner(section,subject_id,category,topic,planned_hrs) values('"+sec+"','"+subj_id+"','"+category[ind]+"','"+topic[ind]+"','"+pl_hr[ind]+"')");
                 if(rec>0)
                    out.print("<span>Updated...</span>");
                 else
                    out.print("<span>No Change...</span>");                // connection.close();
              //  pool.free(connection);
               }
            }else if(request.getParameter("action").toString().equals("update")){
            //String ac_hr=(request.getParameter("ac_hr").equals("-"))?null:request.getParameter("ac_hr");
            String sql="update course_planner set category='"+request.getParameter("category")+"',topic='"+request.getParameter("topic")+"',planned_hrs="+request.getParameter("pl_hr")+" where sno="+request.getParameter("sno");
            out.println(sql);
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span >"+sql+"No Change...</span>");
           }else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from course_planner where sno="+request.getParameter("sno");
            //out.print(sql);
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span>Updated...</span>");
            else
                out.print("<span>No Change...</span>");
            }else if(request.getParameter("action").toString().equals("editview")){
            String sql="select * from course_planner where sno="+request.getParameter("sno");
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){%>
            <table id="hor-minimalist-b">
                <tr>
                         <td>Category</td>
                             <td><select name="category" id="edit_category" class="selectNone" >
                                  <option value="Please Select...">Please Select...</option>
                                  <%for(int i=1;i<=NO_OF_UNITS;i++){%>
                                  <option value="<%=i%>"  <%=(rs.getInt(2)!=i)?"":"selected"%>><%=i%></option>
                                  <%}%>
                                  <option value="6" <%=(rs.getInt(2)!=6)?"":"selected"%>>Other</option>
                               </select>
                               </td>
                          <td>Topic</td>
                          <td><input size="30" type="text"  id="edit_topic" name="topic" value="<%=rs.getString(3)%>" class="required" /></td>
                         <td>Pln Hrs</td>
                         <td><input type="text" id="edit_pl_hr" name="pl_hr" size="5" value="<%=rs.getString(4)%>" class="required"  onKeyUp="res(this,number)"/></td>
                         
               </tr>
            </table>
                         <center><input type="button" value="Update" name="update" onclick="UpdateCoursePlan('<%=request.getParameter("sno")%>')"/></center>
<%
         }else
           out.print("<span class=success>No Record Found!</span>");
}%>


            <div id="report">
            <table class='clienttable' cellspacing="0">
            <thead>
            <tr   cellpadding="1">
                <th>Category</th>
                <th>Topic</th>
                <th>Pln Hrs</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
            String sql="select * from course_planner where subject_id='"+session.getAttribute("subject_id").toString()+"' and section='"+session.getAttribute("section")+"'  order by category,sno asc";
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td>
                    <ul class="action">
                    
                        <li  onclick="EditCoursePlan('<%=rs.getString(6)%>')" class="edit"><a href="#">Edit</a></li>&nbsp;&nbsp;
                <li onclick="DeleteCoursePlan('<%=rs.getString(6)%>')" class="delete"><a >Trash</a></li>
                </ul>
                </td>
            </tr>
           
            </tbody>
        
        <%}%>
        </table>
            </div>
        
                                                
                </div>

                <div id="tabs-2">

                </div>

                <div id="tabs-3">
                </div>
                 <div id="tabs-4">
                </div>
                <div id="tabs-5">
                </div>
 <%

            connection.close();
     }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
  }%>
</div>










