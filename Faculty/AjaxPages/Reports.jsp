 <%--
    Document   : Reports
    Created on : Aug 20, 2009, 11:49:46 PM
    Author     : Ramkumar
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

<%@page import="java.sql.*,java.util.*,java.text.*,org.joda.time.*"  %>
<%@ include file="../../common/pageConfig.jsp" %>
<%
Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Connection connection1 = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement statement = connection.createStatement();
Statement statement1 = connection1.createStatement();
String semester=request.getParameter("semester");
String section=request.getParameter("section");
if(request.getParameter("action").equals("mark")){
    java.util.ArrayList tot_sub=new java.util.ArrayList();

/*
    String sql="select s.subject_id,s.subject_name,count(distinct(examid)),group_concat(distinct(examname)) from assign_staff a,subject s "+
            "left join assessment_master m on s.subject_id=m.subject_id "+
            "where a.subject_id=s.subject_id and a.semester="+semester+" and a.section="+section+" group by subject_id order by subject_id";
*/
String sql="select s.subject_id,s.subject_name,count(distinct(examname)),group_concat(distinct(examname) order by examid),group_concat( DATE_FORMAT(examdate,'%d-%m-%Y') order by examid) from assign_staff a,subject s "+
            "left join assessment_master m on s.subject_id=m.subject_id "+
            "where a.subject_id=s.subject_id and a.semester="+semester+" and a.section="+section+" and m.section=a.section group by subject_id order by subject_id,examid asc";
 //out.print(sql);
ResultSet rs=statement.executeQuery(sql);
%>
<p align="right"><button onclick="exportXL('tabs-3')">Export</button></p>
<%out.print("<h1 align='center'>Internal Assessment Report</h1><br/> <h3>Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(char)(Integer.parseInt(section)+'A'-1)+"</h3><br/>");%>

 <div class="scrollTableContainer">
        <table class="dataTable" cellspacing="0" >
        <thead>
        <tr>

            <th>Name</th>  <!--  ToDo: Add Register Number Here  -->


<%
int i=0;
while(rs.next()){
    out.print("<th colspan= "+rs.getString(3)+">"+rs.getString(1)+"</th>");
    tot_sub.add(rs.getString(1));
        i++;
    }
out.print("</tr><tr><th></th>");

if(!rs.first()){
    connection.close();
    connection1.close();
    return;

}

do{
    if(rs.getString(4)==null){
        out.print("<th></th>");
        continue;
    }
    String[] arr=rs.getString(4).split(",");
    String[] arr_day=rs.getString(5).split(",");
    int index=0;
    while(index!=arr.length){
        String temp=arr[index];
        if(temp.length()>5){
            temp=temp.substring(0,3)+".."+temp.substring(temp.length()-1,temp.length());
        }
%>
<th><%=temp%><br><%=(arr_day[index++].equals("00-00-0000")) ? "" : arr_day[index-1]%></th>
<%
    }
}while(rs.next());
out.print("</tr></thead><tbody>");
sql="select student_id,student_name from students where semester="+semester +" and section ="+section;
rs=statement.executeQuery(sql);
ResultSet rs1=null;
while(rs.next()){
    %>
    <tr>
          <td title="<%=rs.getString(1)%>" class="popup"><%=rs.getString(2)%></td>
        <%
            for(i=0;i<tot_sub.size();i++){
                sql="select m.mark,a.examid from assign_staff f,assessment_master a "+
                "left join marks m on m.examid=a.examid and m.student_id='"+rs.getString(1)+"' "+
                "where a.subject_id=f.subject_id and a.section="+section+" and a.subject_id='"+tot_sub.get(i)+"' group by a.examid order by a.examid";
/*
                sql="select m.mark from assign_staff f,assessment_master a "+
                "left join marks m on m.examid=a.examid and m.student_id='"+rs.getString(1)+"' "+
                "where a.subject_id=f.subject_id and a.section=f.section and a.subject_id='"+tot_sub.get(i)+"' group by a.examid order by a.examid";
*/
               // out.print("---"+sql);
                rs1=statement1.executeQuery(sql);
                if(!rs1.next()){
                    out.print("<td>-</td>");
                    continue;
                }
                do{
                    if(rs1.getString(1)==null)
                        out.print("<td>-</td>");
                    else
                        out.print("<td>"+rs1.getString(1)+"</td>");
                }while(rs1.next());
            }
        %>
    </tr>

<%
}
//Code for Total Starts

    %>
    <tr>
          <td title="Average" class="popup">Average</td>  <!-- Average is temporarily diabled -->
   <%
        sql="select round(sum(mrk.mark)/count(m.examid),2) from assign_staff a,";
        sql+=" subject s left join assessment_master m on s.subject_id=m.subject_id and m.section="+section;
        sql+=" left join marks mrk on mrk.examid=m.examid ";
        sql+=" where a.subject_id=s.subject_id and a.semester="+semester +" and a.section ="+section+" group by s.subject_id,m.examid order by s.subject_id";

        //out.print(sql);
        rs=statement.executeQuery(sql);
        while(rs.next()) {%>
            <td> <%=rs.getString(1)==null?"-":rs.getString(1) %></td>
        <%}
        %>
    </tr>

<%

//Code for Total Ends
out.print("</tbody></table></div>");
%>
 <table>  <!--  Legend  -->
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section="+section+" and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
<%
connection.close();
connection1.close();
return;

}

else if(request.getParameter("action").equals("day")){
    int [] tot_ab =new int[MAX_NO_OF_PERIODS*6];
    String sql="select student_id,student_name from students where semester="+semester +" and section ="+section;
    ResultSet rs=statement.executeQuery(sql);
    java.util.Calendar date=java.util.Calendar.getInstance();
    //DateFormat df=DateFormat.getDateInstance(DateFormat.,Locale.UK);
    SimpleDateFormat df=new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat dbf=new SimpleDateFormat("yyyy-MM-dd");

    if(!request.getParameter("date").equals("none")){
    String tmp=request.getParameter("date");
    String[] day=tmp.split("/");
    //java.util.Date date=new java.util.Date(Integer.parseInt(day[2]),Integer.parseInt(day[1]),Integer.parseInt(day[0]));
    date.set(Integer.parseInt(day[2]),Integer.parseInt(day[1])-1,Integer.parseInt(day[0]));
    }
    else
    //out.print(date.getTime());
    date.add(java.util.Calendar.DAY_OF_YEAR, -6);
    %>

    <p align="right">
        Date: <button onclick="nav_dayAttendance('prev')"><<</button> |
         <input type="text" id="date1" value="<%=df.format(date.getTime())%>" onchange="dayAttendance()">
         | <button onclick="nav_dayAttendance('next')">>></button> 
    <button onclick="exportXL('tabs-2')">Export</button>
    </p>
    <%out.print("<h1 align='center'>Daywise Attendance Report</h1><br/> <h3>Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(char)(Integer.parseInt(section)+'A'-1)+"</h3><br/>");%>
     <div class="scrollTableContainer">
        <table class="dataTable" cellspacing="0" style="font-size:11px" >
            <thead>
        <tr>

            <th>Date</th>

            <%for(int j=0;j<7;j++){

                if(date.get(date.DAY_OF_WEEK)==1){
                    date.add(java.util.Calendar.DAY_OF_YEAR, 1);
                    continue;
                }
                %>
                <th colspan="<%=MAX_NO_OF_PERIODS%>"><%=df.format(date.getTime())%></th>
            <%date.add(java.util.Calendar.DAY_OF_YEAR, 1);}date.add(java.util.Calendar.DAY_OF_YEAR, -7);%>
            <th> &nbsp;&nbsp;</th>
        </tr>
        <tr>
 <th>Name \ Period</th>
    <%
    for(int j=0;j<6;j++)

    for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
        %>
        <th><%=i%></th>
        <%
    }

    %>
    <th> </th>
        </tr>
    </thead>
    <tbody>
            <%
                ResultSet rs1=null;
                while(rs.next()){
                        int listindex=0;
                    %>
                    <tr>

                        <td title="<%=rs.getString(1)%>"  class="popup"><%=rs.getString(2)%></td>
                        <%

                       // out.print(dbf.format(date.getTime()));
                            for(int j=0;j<7;j++){
                                 if(date.get(date.DAY_OF_WEEK)==1){
                                    date.add(java.util.Calendar.DAY_OF_YEAR, 1);
                                    continue;
                                }
                            for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
                               sql="select ab_type,subject_id from attendance where date='"+dbf.format(date.getTime()) +"' and student_id='"+rs.getString(1)+"' and hour="+i;
                               //out.print(sql);
                               rs1=statement1.executeQuery(sql);

                               if(rs1.next()){%>
                                   <td title='<%=rs1.getString("subject_id")%>' <%=rs1.getString(1).equalsIgnoreCase("A")?"bgcolor='#ffeedd'":rs1.getString(1).equalsIgnoreCase("O")?"bgcolor='#eeffdd'":""%>><%=rs1.getString(1)%></td>
                                   <%
                                   if(rs1.getString(1).equalsIgnoreCase("A"))
                                       ++ tot_ab[listindex] ;


                               }
                               else
                                   out.print("<td>-</td>");
                               listindex++;
                            }
                            date.add(java.util.Calendar.DAY_OF_YEAR, 1);
                            }
                            date.add(java.util.Calendar.DAY_OF_YEAR, -7);

                        %>
                        <td> </td>
                    </tr>
                    <%
                }
                %>
                <tr>
                        <th>Absentees</th>
                    <%
                    for(int i=0;i<MAX_NO_OF_PERIODS*6;i++)
                                out.print("<td>"+tot_ab[i]+"</td>");

            %>
                    </tr>

        </tbody>
    </table>

</div>
     <table>
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section="+section+" and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
    <%
connection.close();
connection1.close();
return;

}

else if(request.getParameter("action").equals("courseprogress")){
    String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subject_id").equals("none"))
        subj_id = request.getParameter("subject_id");
    else
        subj_id= rs.getString(2);
    rs.beforeFirst();
    %>

    <div align="right">
    <label for="subject">Subject:</label>
        <select id="subject" onchange="CourseProgressReport()">
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
        </select> &nbsp;&nbsp;
       
   
    <button onclick="exportXL('tabs-5')">Export</button>
    <br/>
    </div>
 <div class="scrollTableContainer">
     <%out.print("<h1 align='center'>Course Progress Report</h1><br/> <h3>Subject Id : "+subj_id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(char)(Integer.parseInt(section)+'A'-1)+"</h3><br/>");%>

 <table class="dataTable" cellspacing="0">
            <thead>
            <tr>
                <th>Category</th>
                <th>Topic</th>
                <th>Pln Hrs</th>
                <th>Act Hrs</th>
		    <th>Classes Taken</th>
                <th>Finished Date</th>

            </tr>
            </thead>
            <tbody>
            <%
            sql="select c.category,c.topic,c.planned_hrs,count(distinct(concat(a.date,a.hour))),DATE_FORMAT(max(date),'%d/%m/%Y'),group_concat(distinct(DATE_FORMAT(date,'%d/%m/%Y'))) from course_planner c left join attendance a on c.sno=a.topic where c.subject_id='"+subj_id+"' and c.section='"+section+"' group by c.topic order by c.category,c.sno asc ";
           // sql="select * from course_planner where subject_id='"+subj_id+"' and section='"+section+"' order by category,sno asc";
            rs=statement.executeQuery(sql);
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=(rs.getString(4)==null)?"-":rs.getString(4)%></td>
		    <td><%=(rs.getString(5)==null)?"-":rs.getString(6).replace(",","<br>")%></td>
                <td><%=(rs.getString(5)==null)?"-":rs.getString(5)%></td>

            </tr>
 <%}%>
            </tbody>


        </table>
 </div>

    <%
connection.close();
connection1.close();
return;

}else if(request.getParameter("action").equals("coursecoverage")){
    String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subjectid").equals("none"))
        subj_id = request.getParameter("subjectid");
    else
        subj_id= rs.getString(2);
    rs.beforeFirst();
    %>
    <p align="right">Subject:
        <select id="subjid" onchange="CourseCoverageReport()">
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
    </select>

    </p>
 <div class="scrollTableContainer">
 <%out.print("<h1 align='center'>Course Coverage Report</h1><br/> <h3>Code : "+subj_id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(char)(Integer.parseInt(section)+'A'-1)+"</h3><br/>");%>
     <%
            sql="select data from coursecoverage where subject_id='"+subj_id+"' and sec="+section;
            rs=statement.executeQuery(sql);
            if(rs.next()){
            %>
            <%=rs.getString(1)%>
            <%}%>
 </div>

    <%
connection.close();
connection1.close();
return;

}else if(request.getParameter("action").equals("courseoutline")){
String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subjectid").equals("none"))
        subj_id = request.getParameter("subjectid");
    else
        subj_id= rs.getString(2);
    rs.beforeFirst();
    %>
    <p align="right">Subject:
        <select id="subjectid" onchange="CourseOutlineReport()">
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
    </select>

    </p>
 <div class="scrollTableContainer">
      <%out.print("<h1 align='center'>Course Outline Report</h1><br/> <h3>Subject Id : "+subj_id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(char)(Integer.parseInt(section)+'A'-1)+"</h3><br/>");%>
            <%
            sql="select data from courseoutline where subject_id='"+subj_id+"' and sec="+section;
            rs=statement.executeQuery(sql);
            if(rs.next()){
            %>
            <%=rs.getString(1)%>
            <%}%>
 </div>

    <%
connection.close();
connection1.close();
return;
}

else if(request.getParameter("action").equals("cumulative")){
    //removed export button
    %>

    <%

//out.print(sql);
String monthsubstr="";
int t=0;
if(!request.getParameter("month").equals("0"))
    monthsubstr=" and month(`date`)="+request.getParameter("month");

String sql="select a.subject_id,count(distinct(concat(date,hour))) from assign_staff a left join attendance at "+
            "on a.section=at.section and a.semester=at.semester and a.subject_id=at.subject_id "+monthsubstr+
            " where a.section="+section+" and a.semester="+semester+" group by subject_id" ;

ResultSet rs=statement.executeQuery(sql);
if(Integer.parseInt(request.getParameter("month"))>0) {

        out.print("<h1 align='center'>Monthly Attendance Report for ");
        String mont[]={"January","Febraury","March","April","May","June","July","August","September","October","November","December"} ;
        out.print(mont[Integer.parseInt(request.getParameter("month"))-1]) ;
        out.print("</h1><br/><h3>Year: " +((Integer.parseInt(request.getParameter("semester"))+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;Section: "+((char)(Integer.parseInt(request.getParameter("section"))+'A'-1))+"</h3><br/>");
     }
else
        out.print("<h1 align='center'>Cumulative Attendance Report </h1><br/><h3>Year: " +((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;Section: "+((char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");
%>

  <div align="right">
        <table class="clienttable" cellspacing="0">
            <tr align="center" >
                <th colspan="6"> Legend </th>
            </tr>
            <tr>
                 <th>P</th><td>Number of Hours Present</td>
                 <th>O</th><td>Number of Hours On Duty</td>
                 <th>%</th><td>Attendance Percentage</td>
             </tr>
         </table>
        </div><br/>
<div class="scrollTableContainer">
        <table class="dataTable" cellspacing="0" >
            <thead>
            <tr>

                <th rowspan="2">Reg. No.</th> <th rowspan="2">Name</th>

<%
int i=0;
while(rs.next()){
    out.print("<th colspan=3 >"+rs.getString(1)+" ("+rs.getString(2)+") </th>");
    i++;
    t+=rs.getInt(2);
    }

out.print("<th colspan=3>Cumulative</th><th> &nbsp;&nbsp;</th></tr><tr>");
for(int k=0;k<i;k++)
    out.print("<th>P</th><th>O</th><th>%</th>");
out.print("<th>Total</th><th>O</th><th>%</th><th></th></tr></thead><tbody>");
sql="select student_id,student_name from students where semester="+semester +" and section ="+section;
rs=statement.executeQuery(sql);
    int altcss=0;
while(rs.next()){
    int p,o;
    int tot=0;
    p=o=0;
++altcss;
  /*  String innersql="SELECT s.subject_id,sum(if(ab_type='A' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),(if( student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)) WITHOUTOD, " +
                    "sum(if(ab_type<>'A' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),sum(if( student_id='"+rs.getString(1)+"'  "+monthsubstr+",1,0)) WITHOD FROM "+
                    "assign_staff a inner join subject s using(subject_id) left join (attendance at inner join students st using(student_id)) using(subject_id,staff_id)  " +
                    "where  a.semester="+semester+" and a.section="+section+"  group by s.subject_id order by s.subject_id;";
   */
        String innersql="SELECT s.subject_id,sum(if(ab_type='O' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),(if( student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)) WITHOUTOD, " +
                    "sum(if(ab_type='P' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),sum(if( student_id='"+rs.getString(1)+"'  "+monthsubstr+",1,0)) WITHOD FROM "+
                    "assign_staff a inner join subject s using(subject_id) left join (attendance at inner join students st using(student_id)) using(subject_id,staff_id)  " +
                    "where  a.semester="+semester+" and a.section="+section+"  group by s.subject_id order by s.subject_id;";


    //out.print(innersql);
    ResultSet innerrs=statement1.executeQuery(innersql);
    %>
    <tr style="background:<%if (altcss%2==0) out.print("#E8E8E8");%>">
        <td><%=rs.getString(1)%></td>   <!--Reg. Number in Cumulative Report -->
        <td class='popup' title="<%=rs.getString(1)%>"><%=rs.getString(2)%></td>
        <%while(innerrs.next()){
                int sp=0;
		if(innerrs.getInt(5)==0){%>
			<td>-</td>
			<td>-</td>
                        <td>-</td>
                        <%
			continue;
		}
                tot+=innerrs.getInt(5);
                p+=innerrs.getInt(4);
                //sp=innerrs.getInt(5)-innerrs.getInt(2);
                o+=innerrs.getInt(2);

	   %>

        <td><%=(innerrs.getString(2)==null)?"-":innerrs.getInt(4)%></td>
        <td><%=innerrs.getInt(2)%></td>
        <td style="<%=(innerrs.getInt(4)+innerrs.getInt(2))*100/innerrs.getInt(5)<=75?"color:red":"color:green"%>" title="<%=(innerrs.getString(3)==null)?"-":innerrs.getInt(4)+"/"+innerrs.getInt(5)%>"><%=(innerrs.getInt(4)+innerrs.getInt(2))*100/innerrs.getInt(5)%></td>
        <%}%>
        <td><b><%=p+"/"+tot%></b></td>
        <td><b><%=o%></b></td>
        <td  title="<%=(p==0)?"":p+"/"+tot%>"><b><%=(tot!=0)?(p+o)*100/tot:"N/A"%></b></td>
        <td></td>
    </tr>
<%
}
out.print("</tbody></table></div>");
%>
 <table>
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section="+section+" and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
    <%
connection.close();
connection1.close();
return;
}
else if(request.getParameter("action").equals("timetable")){
    /*select t.data,a.subject_id from timetable_data t left join attendance a on t.header_id=a.hour
and t.semester=a.semester and t.section=a.section and t.date=a.date
where day='1'  and t.semester='1' and t.section='1'
and t.date =(select max(date) from timetable_data
where date <= STR_TO_DATE('10/11/2009', '%d/%m/%Y')) order by header_id
 */
    DateTime dt=new DateTime();
    dt=dt.minusDays(6);
    if(!request.getParameter("date").trim().equals("none")){
        String date=request.getParameter("date");
        String[] day=date.split("/");
        dt = new DateTime(Integer.parseInt(day[2]),Integer.parseInt(day[1]),Integer.parseInt(day[0]),0,0,0,0);
    }
   %>
   <p align="right">Date:<input type="text" id="date2" size="8" onchange="timetablereport()" value="<%=dt.toString("dd/MM/yyyy")%>"/>

   </p>

   <%out.print("<h1 align='center'>Time Table Report</h1><br/> <h3>Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(char)(Integer.parseInt(section)+'A'-1)+"</h3><br/>");

    //int weekday=dt.dayOfWeek().get();
    /*select t.data,a.subject_id from timetable_data t left join attendance a on t.header_id=a.hour
and t.semester=a.semester and t.section=a.section and t.date=a.date
where day='1'  and t.semester='1' and t.section='1'
and t.date =(select max(date) from timetable_data
where date <= STR_TO_DATE('10/11/2009', '%d/%m/%Y')) order by header_id*/
//select  * from timetable_data where day='"+weekday+"' and semester='"+semester+"' and section='"+section+"' and date =(select  max(date) from timetable_data where date <= STR_TO_DATE('"+date+"', '%d/%m/%Y')) order by header_id "

    int i=0;
    out.print("<table id='hor-minimalist-b'");
    do
    {
       int weekday=dt.plusDays(i).dayOfWeek().get()-1;
/*    String sql="select distinct t.data,a.subject_id,if(a.date=STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y'),true,false)  from timetable_data t left join attendance a " +
            "on t.header_id=(a.hour-1) and t.semester=a.semester and t.section=a.section  " +
            "where t.day='"+weekday+"' and t.semester='"+semester+"' and t.section='"+section+"' and " +
            "t.date =(select  max(date) from timetable_data where date <= STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y')) order by header_id ";
*/
    String sql="select distinct t.data,group_concat(distinct(a.subject_id) SEPARATOR '/ ') subject_id,t.header_id  from timetable_data t left join attendance a " +
            "on t.header_id=(a.hour-1) and t.semester=a.semester and t.section=a.section  and a.date=STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y')" +
            "where t.day='"+weekday+"' and t.semester='"+semester+"' and t.section='"+section+"' and " +
            "t.date =(select  max(date) from timetable_data where date <= STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y')) group by header_id order by header_id ";

   // out.println(sql);

    ResultSet rs=statement.executeQuery(sql);
    //out.print(sql+"<br>");
    out.print("<tr>");
    //if(i%2==0)
        out.print("<td rowspan='2'>"+ dt.plusDays(i).toString("dd/MM/yyyy")+"<br/>"+dt.plusDays(i).dayOfWeek().getAsText()+"</td>");

    while(rs.next()){
        %>
        <td><%=rs.getString("data")%></td>
        <%

    }
    out.print("</tr><tr>");
    i++;
    if(!rs.first()){
        out.print("<td>HOLIDAY</td>");
        continue;
    }

    do{


        if(rs.getString(2)!=null)
            out.print("<td>"+rs.getString("subject_id")+"</td>");
        else
            out.print("<td>-</td>");
    }while(rs.next());
    out.print("</tr>");

    rs.close();
    }while(i<7);
    out.print("</table>");
    //out.print(sql);
    connection.close();
    connection1.close();
    return;
}
else if(request.getParameter("action").equals("getreportdetail")){

        String sql="SELECT group_concat(report) FROM staff_permissions where staff_id="+session.getAttribute("userid")+" group by staff_id";
        ResultSet rs=statement.executeQuery(sql);
        if(rs.next())
            out.print(rs.getString(1));
        connection.close();
        connection1.close();
        return;
}
String sql="SELECT year,semester FROM section;";
ResultSet rs=statement.executeQuery(sql);
%>
<table width="50%" >
    <tr>
    <td>Year
        <select id="semester" onchange="curreport()">
            <%while(rs.next()){%>
            <option value="<%=rs.getString(2)%>"><%=rs.getString(1)%></option>
            <%}%>
        </select>
    </td>
    <td align="right" >Section
        <select id="section" onchange="curreport()">
            <%for(int i=0;i<NO_OF_SECTIONS;i++){%>
            <option value="<%=i+1%>"><%=(char)( i+'A') %></option>
            <%}%>
        </select>
    </td>
    </tr>
</table>

<div id="tabs">
    <ul>

        <li id="li1"><a href="#tabs-1" onclick="cumulativeAttendance()">Cumulative Attendance</a></li>

            <li id="li2"><a href="#tabs-2" onclick="dayAttendance()">Day Attendance</a></li>

            <li id="li3"><a href="#tabs-3" onclick="internalMarks()">Internal Marks</a></li>

            <li id="li4"><a href="#tabs-4" onclick="timetablereport()">Time Table</a></li>

            <li id="li5"><a href="#tabs-5" onclick="CourseProgressReport()">Progress</a></li>

            <li id="li6"><a href="#tabs-6" onclick="CourseOutlineReport()">Outline</a></li>

            <li id="li7"><a href="#tabs-7" onclick="CourseCoverageReport()">Coverage</a></li>

    </ul>
    <div id="tabs-1">
        <p align="right">Month:
        <select id="month" onchange="cumulativeAttendance()">
            <option value="0">Overall</option>
            <option value="1">January</option>
            <option value="2">February</option>
            <option value="3">March</option>
            <option value="4">April</option>
            <option value="5">May</option>
            <option value="6">June</option>
            <option value="7">July</option>
            <option value="8">August</option>
            <option value="9">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>

        </select>
<button onclick="exportXL('tabs-1')">Export</button> 
    </p>

    <div id="cumulative">
        Please wait this may take long time ...
        </div>
    </div>
    <div id="tabs-2"> Please wait ...</div>
    <div id="tabs-3"> Please wait ...</div>
    <div id="tabs-4"> Please wait ...</div>
    <div id="tabs-5"> Please wait ...</div>
    <div id="tabs-6"> Please wait ...</div>
     <div id="tabs-7"> Please wait ...</div>
</div>

<%
connection.close();
connection1.close();
%>








