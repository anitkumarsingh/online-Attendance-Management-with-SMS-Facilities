<%-- 
    Document   : curriculam
    Created on : Sep 25, 2009, 10:35:42 AM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
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
<%@ include file="../../common/pageConfig.jsp" %>

<%
   
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Connection connection1 = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement st=connection.createStatement();
    Statement st1=connection1.createStatement();

    ResultSet rs=null;
    String sql="";
    if(!request.getParameter("action").equals("none")){
        sql="select subject_name from subject where subject_id='"+request.getParameter("subject_id")+"'";
         rs=st.executeQuery(sql);
         if(!rs.next()){
             connection.close();
             connection1.close();
             return;
         }
         out.print("<h2><center>"+rs.getString(1)+"</center></h2>");
    }
    if(request.getParameter("action").equals("none")){
       // sql="select a.subject_id,s.subject_name from assign_staff a,subject s where s.subject_id=a.subject_id and s.semester="+session.getAttribute("semester")+" and section = "+session.getAttribute("section");
        sql="select a.subject_id,s.subject_name,sum(if(at.subject_id=a.subject_id and at.ab_type='P',1,0)),sum(if(at.subject_id=a.subject_id and at.ab_type='O',1,0)),sum(if(at.subject_id=a.subject_id,1,0)) ,"+
            " round((sum(if(at.subject_id=a.subject_id and at.ab_type='P',1,0))+sum(if(at.subject_id=a.subject_id and at.ab_type='O',1,0)))/sum(if(at.subject_id=a.subject_id,1,0))*100,2) "+
            "from assign_staff a left join attendance at "+
            " on at.subject_id=a.subject_id and at.staff_id=a.staff_id and a.section=at.section  and at.student_id='"+session.getAttribute("userid")+"' , "+
            " subject s where s.subject_id=a.subject_id  and a.semester="+session.getAttribute("semester")+" and a.section = "+session.getAttribute("section")+" group by a.subject_id";
        //out.print(sql);
        rs=st.executeQuery(sql);

%>


<h1>Curriculum</h1>
<div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">

<div id="centerwrapper">
    <ul class="column">
    <%while(rs.next()){
        sql="select count(distinct(a.examid)) from marks m,assessment_master a where a.examid=m.examid and a.section='"+session.getAttribute("section")+"' and a.subject_id='"+rs.getString(1)+"'  group by a.examid;";
       // out.print(sql);
        ResultSet rs1=st1.executeQuery(sql);
        %>
    <li>
        <div class="block" >
            <ul>
                <li style="font-weight:bolder;color:brown"><%=rs.getString(2)%></li>
                <li>Attendance :<%=rs.getString(3)%>+<%=rs.getString(4)%>/<%=rs.getString(5)%>=<%=(rs.getString(6) != null) ? rs.getString(6) : "0"%>  <a href="#" onclick="getAdvanceAttendance('<%=java.util.Calendar.getInstance().get(java.util.Calendar.MONTH) + 1%>','<%=rs.getString(1)%>')"><sup>more</sup></a></li>
                <li>Marks: <%= (rs1.next())? rs1.getString(1) : "0" %> Exam(s)  <a href="#" onclick="getStudentmarks('<%=rs.getString(1)%>')"><sup>more</sup></a></li>
                <li>Course <a href="#" onclick="getCourseOutline('<%=rs.getString(1)%>','<%=session.getAttribute("section")%>')">Coverage</a>,<a href="#" onclick="getCourseCoverage('<%=rs.getString(1)%>','<%=session.getAttribute("section")%>')">Outline</a>,<a href="#" onclick="getCourseProgress('<%=rs.getString(1)%>','<%=session.getAttribute("section")%>')">Progress</a></li>
            </ul>
        
        </div>
    </li>
             <%}%>
    </ul>
</div>
    </div>

     <div style="clear:both"></div>

<%
connection1.close();
connection.close();
return;
    }
else if(request.getParameter("action").equals("coursecoverage")){
    sql="select data from coursecoverage where subject_id='"+request.getParameter("subject_id")+"' and sec='"+request.getParameter("section")+"'";
    rs=st.executeQuery(sql);
    out.print("<p align='right'><a onclick='back()'><img src='../images/back.png'/></a></p>");
    if(rs.next())
        out.print(rs.getString(1));
    else
        out.print("No Data!");
    connection.close();
    connection1.close();
    return;
}else if(request.getParameter("action").equals("courseprogress")){
//    sql="select * from course_planner where subject_id='"+request.getParameter("subject_id")+"' and section='"+request.getParameter("section")+"'";
sql="select c.category,c.topic,c.planned_hrs,count(distinct(concat(a.date,a.hour))),DATE_FORMAT(max(date),'%d/%m/%Y') from course_planner c left join attendance a on c.sno=a.topic where c.subject_id='"+request.getParameter("subject_id")+"' and c.section='"+request.getParameter("section")+"' group by c.topic order by c.category,c.sno asc ";

    rs=st.executeQuery(sql);
    out.print("<p align='right'><a  onclick='back()'><img src='../images/back.png'/></a></p>");
    %>
    <table class="Table" >
            <thead>
            <tr>
                <th>Category</th>
                <th>Topic</th>
                <th>Pln Hrs</th>
                <th>Act Hrs</th>
                <th>Finished Date&nbsp;&nbsp;&nbsp;&nbsp;</th>
            </tr>
            </thead>
            <tbody>
       <%while(rs.next()){%>
         <tr >
                <td><%=rs.getString(1).equals("6")?"Others":rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=(rs.getString(4)==null)?"-":rs.getString(4)%></td>
                <td><%=(rs.getString(5)==null)?"-":rs.getString(5)%></td>
        </tr>
        </tbody>
        <%}%>
    </table>
    <%
    connection.close();
    connection1.close();
    return;
}else if(request.getParameter("action").equals("courseoutline")){
    sql="select data from courseoutline where subject_id='"+request.getParameter("subject_id")+"' and sec='"+request.getParameter("section")+"'";
    rs=st.executeQuery(sql);
    out.print("<p align='right'><a  onclick='back()'><img src='../images/back.png'/></a></p>");
    if(rs.next())
        out.print(rs.getString(1));
    else
        out.print("No Data!");
    connection.close();
    connection1.close();
    return;
}
    else if(request.getParameter("action").equals("studentmarks")){
    sql="SELECT examname,examdate,weightage,max_marks,mark FROM assessment_master a left join marks m on a.examid=m.examid and m.student_id='"+session.getAttribute("userid")+"' where section ='"+session.getAttribute("section")+"' and subject_id='"+request.getParameter("subject_id")+"'" ;
    rs=st.executeQuery(sql);
    out.print("<p align='right'><a  onclick='back()'><img src='../images/back.png'/></a></p>");
    //out.print("<table id=hor-minimalist-b>");
    if(!rs.next()){
        out.print("No Data!");
        connection.close();
        connection1.close();
        return;
    }
    %>
    <table id="hor-minimalist-b" >
            <thead>
            <tr  cellspacing="2" cellpadding="1">
                <th>Exam Name</th>
                <th>Date</th>
                <th>Weightage</th>
                <th>Marks/Max Marks</th>
            </tr>
            </thead>
            <tbody>

    <%do{
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getString(3)%></td>
            <td><%=(rs.getString(5)==null)?"-":rs.getString(5)%>/<%=rs.getString(4)%></td>
        </tr>
        <%
    }while(rs.next());
    %>
            </tbody>
    </table>
   <% //   out.print("</table>");
    connection.close();
    connection1.close();
    return;
}
    else if(request.getParameter("action").equals("advanceattendance")){
        String month[]={"January","February","March","April","May","June","July","August","September","October","November","December"};
    %>
   
    <%
    sql="SELECT a.student_id,group_concat(s.subject_name order by hour) " +
        "subject_name,group_concat(st.staff_name order by hour) staff_name," +
        "group_concat(a.hour order by hour) hour,group_concat(a.ab_type order by hour) ab_type, " +
        "group_concat(a.subject_id order by hour) subject_id, date_format(date,'%b%e %Y ,%W') `date` FROM attendance a,staff st,subject s " +
        "where student_id='"+session.getAttribute("userid")+"' and month(date)='"+request.getParameter("month")+"' " +
        "and a.subject_id=s.subject_id and a.staff_id=st.staff_id group by date;";
    rs=st.executeQuery(sql);
    //out.print(sql);
    %><p align='right'><a  onclick='back()'><img src='../images/back.png'/></a></p>
     Month: <select id="month" onchange="getAdvanceAttendance(this.value,'<%=request.getParameter("subject_id")%>')">
        <%for(int i=0;i<12;i++){%>
            <option value="<%=i+1%>" <%=((i+1)==Integer.parseInt(request.getParameter("month")))?"selected":""%>><%=month[i]%></option>
            <%}%>
    </select>

    <%
    if(!rs.next()){
        out.print("No Record!");
        connection.close();
        connection1.close();
        return;
    }
    %>
    
    <table class="clienttable">
        <thead>
        <tr>
            <th></th>
            <% for(int i=0;i<MAX_NO_OF_PERIODS;i++){ %>
            <th><%=i+1%></th>
            <%}%>
        </tr>
    </thead>
    <%
    do{
        String hour[]=rs.getString("hour").split(",");
        String ab_type[]=rs.getString("ab_type").split(",");
        String subject_id[]=rs.getString("subject_id").split(",");
        String subject_name[]=rs.getString("subject_name").split(",");
        out.print("<tr><th width=150px;>"+rs.getString("date")+"</th>");

        for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
           boolean flag=true;
           for(int j=0;j<hour.length;j++)
                if(i==Integer.parseInt(hour[j])){
                    %>
                    <td title="<%=subject_id[j]%>-<%=subject_name[j]%>" <%=subject_id[j].equalsIgnoreCase(request.getParameter("subject_id")) ? "bgcolor='#ffeedd'" : ""%>><span <%=ab_type[j].equals("A")?"class='error'":""%>><%=ab_type[j]%></span></td>
                    <%
                    flag=false;
                 }
            if(flag)
                out.print("<td>-</td>");
        }
        out.print("</tr>");
    }while(rs.next());
    out.print("</table><center>*Note: The Selected Color indicate currently selected subject</center>");
    connection.close();
    connection1.close();
    return;
}
%>