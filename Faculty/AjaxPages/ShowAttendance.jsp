<%--
    Document   : ShowAttendance
    Created on : Aug 1, 2009, 10:28:46 AM
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
    if(session.getAttribute("semester")==null){
        out.print("<h3><center>No Subjects Assigned!</center></h3>");
        return;
    }
    
 %>
 
<%@page import="java.sql.*"  %>
<%@page import="java.util.*"  %>
<%@ include file="../../common/DBConfig.jsp" %>

<%


    Connection con=DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement st=con.createStatement();
    String elective=session.getAttribute("elective").toString();
    String subject_id=session.getAttribute("subject_id").toString();
    String semester=session.getAttribute("semester").toString();
    int section= Integer.parseInt(session.getAttribute("section").toString());
    String sql="";
    if(request.getParameter("action").equals("loadtopic")){
        sql="select topic,sno from course_planner where section="+section+"  and subject_id='"+session.getAttribute("subject_id")+"' and category="+request.getParameter("unit");
        ResultSet rs=st.executeQuery(sql);
        if(!rs.next()){
            %>
            <select id="topic" class="required" disabled> 
            <option value="selectone">please Select</option>
            </select>
            <%
            con.close();
            return;
        }
        %>
        <select id="topic" class="required">
        <%
        do{
            %>
            <option value="<%=rs.getInt(2)%>"><%=rs.getString(1)%></option>
            <%
        }while(rs.next());
        %></select><%
        con.close();
        return;

    }
    if(request.getParameter("action").equals("delete")){
        boolean flag=false;
        sql="select hour,staff_id from attendance where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+subject_id+"' and section='"+section+"' and date like STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')";
        ResultSet rs=st.executeQuery(sql);
        if(rs.next())
            flag=true;
        if(flag){
            sql="delete from attendance where subject_id='"+subject_id+"' and semester='"+semester +"' and section='"+section+"' and date like STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') ";
            //out.print(sql);
            st.executeUpdate(sql);
        }
        else
            out.print("You have not taken the class");
        con.close();

        return;
     }
    if(request.getParameter("action").equals("add")||request.getParameter("action").equals("edit")){
        if(request.getParameter("action").equals("edit")){

            sql="delete from attendance where subject_id='"+subject_id+"' and semester='"+semester +"' and section='"+section+"' and date like STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') and (hour = "+request.getParameter("hour").replace(","," or ")+")"; 
            //out.print(sql);
            st.executeUpdate(sql);

        }

//pls add date validation here


        java.util.StringTokenizer token = new java.util.StringTokenizer(request.getParameter("student"),"~");
        while(token.hasMoreElements()){
            java.util.StringTokenizer time = new java.util.StringTokenizer(token.nextElement().toString(),"-");
            if(time.hasMoreElements()){
                sql="insert into attendance(student_id,subject_id,staff_id,hour,`date`,ab_type,semester,section,topic) values('"+time.nextElement()+"','"+subject_id+"','"+session.getAttribute("userid")+"','"+time.nextElement()+"',STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y'),'"+time.nextElement()+"','"+semester+"','"+section+"','"+request.getParameter("topic")+"') ";
                st.executeUpdate(sql);
            }

        }
        out.print("added successfully");
        con.close();
        return;
    }
%>
<%
if(request.getParameter("action").equals("showall")){
int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
<center><h3><%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h3></center><br>
<div id="action">
    <table >
        <tr align="left">
    <th>Unit / Category</th>
    <td><select class="required" id="unit" onchange="loadtopic(this.value)">
            <option value="selectone">Please Select</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">Other</option>
        </select></td>

    <th>Topic</th>
    <td id="li_topic"><select disabled  id="topic" class="required"><option value="selectone">Please Select...</option></select></td>
    </tr>
<tr align="left">
    <td>Date</td>
    <td><input type="text" size="10" id="date" value="<%=(request.getParameter("date")==null)?"":request.getParameter("date")%>" class="required" ></td>
    <th>Hour(s)</th><td><input type="text" size="4" id="hrs"  value="<%=(request.getParameter("hour")==null)?"":request.getParameter("hour")%>" class="required" onKeyUp="res(this,attandance)"></td>
</tr>
<tr align="left">
    <td><button onclick="advance()">Mark Attendance</button></td>
    <td><button onclick="DeleteAttendance()">Delete Attendance</button></td>
    <td><button onclick="cumulativeReport()">Report</button></td>
    </tr>
    </table>
<p> &nbsp;* The date should not be a future </p>
    <div id="studentlist"></div>
</div>
<%
}
if(request.getParameter("hour")==null){
    con.close();
    return;
}
if(request.getParameter("action").equals("report")){
    String monthsubstr="";
    if(!(request.getParameter("month").equals("undefined") || request.getParameter("month").equals("0")))
        monthsubstr=" and month(`date`)="+request.getParameter("month");
    %>
    <p align="right" style="padding-right:10px;"> Select Month : <select id="month" onchange="cumulativeReport()">
            <option value="0" <%=request.getParameter("month").equals("0")?"selected":""%>>Overall</option>
            <option value="1" <%=request.getParameter("month").equals("1")?"selected":""%>>January</option>
            <option value="2" <%=request.getParameter("month").equals("2")?"selected":""%>>February</option>
            <option value="3" <%=request.getParameter("month").equals("3")?"selected":""%>>March</option>
            <option value="4" <%=request.getParameter("month").equals("4")?"selected":""%>>April</option>
            <option value="5" <%=request.getParameter("month").equals("5")?"selected":""%>>May</option>
            <option value="6" <%=request.getParameter("month").equals("6")?"selected":""%>>June</option>
            <option value="7" <%=request.getParameter("month").equals("7")?"selected":""%>>July</option>
            <option value="8" <%=request.getParameter("month").equals("8")?"selected":""%>>August</option>
            <option value="9" <%=request.getParameter("month").equals("9")?"selected":""%>>September</option>
            <option value="10" <%=request.getParameter("month").equals("10")?"selected":""%>>October</option>
            <option value="11" <%=request.getParameter("month").equals("11")?"selected":""%>>November</option>
            <option value="12" <%=request.getParameter("month").equals("12")?"selected":""%>>December</option>
            
        </select>
    </p>

    <%
    if(monthsubstr.equals("")){
        %>
          <div align="right">
        <table class="clienttable" cellspacing="0">
            <tr align="center" >
                <th colspan="6"> Legend </th>
            </tr>
            <tr>
                 <th>P</th><td>Number of Hours Present</td>
                 <th>O</th><td>Number of Hours On Duty</td>
                 <th>T</th><td>Number of Hours Taken</td>
             </tr>
         </table>
        </div>
          <br>
         <div class="scrollTableContainer">
               <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
         <h1>Cumulative Attendance Report for <%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%> </h1>
         
        <table class="dataTable" cellspacing="0" >
            <thead>
                <tr>
                    <th rowspan="2">Reg. No.</th>
                    <th rowspan="2">Student Name</th>
                    <th colspan="5">Hours</th>
                    
                </tr>
                <tr>
             
                    <th>P</th>
                    <th>O</th>
                    <th>T</th>
                    <th>%</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
<%
      sql="SELECT x.student_id,y.student_name,round(100-sum(if(x.ab_type='A',1,0))*100/count(*),2) " +
              "`Without OD`,round(sum(if(x.ab_type='A',0,1))*100/count(*),2) `With OD` ,count(*),sum(if(x.ab_type='A',1,0)),sum(if(x.ab_type='A',0,1))" +
              "FROM attendance x,students y where x.student_id=y.student_id and " +
              "x.subject_id='"+subject_id+"' and x.section='"+section+"'  group by student_id;";
     // out.print(sql);
      ResultSet rs=st.executeQuery(sql);
      while(rs.next()){
          %>
          <tr>
              <td><a class="popup" ><%=rs.getString(1).substring(rs.getString(1).length()-3)%></a></td>
          <td><%=rs.getString(2)%></td>
          <td <%=rs.getDouble(4)<75?"bgcolor='#ffeedd'":""%>><%=rs.getInt(5)-rs.getInt(6)%></td>
          <td <%=rs.getDouble(4)<75?"bgcolor='#ffeedd'":""%>><%=rs.getInt(7)-(rs.getInt(5)-rs.getInt(6))%> </td>
          <td <%=rs.getDouble(4)<75?"bgcolor='#ffeedd'":""%>><%=rs.getString(5)%> </td>
          <td <%=rs.getDouble(4)<75?"bgcolor='#ffeedd'":""%>><%=rs.getString(4)%> </td>
          </tr>

          <%
      }
%></tbody></table></div>
          <%
      }
    else{
        int A,P,O;

        sql="select date,group_concat(distinct (hour) order by hour),count(distinct (hour)),subject_id,day(date) day from attendance where section='"+section+"' and  subject_id='"+subject_id+"' "+monthsubstr+" group by date";
        //out.print(sql);

        ResultSet rs=st.executeQuery(sql);
        if(!rs.first())
        {out.print("No Record Found!");con.close();return;}
         %>
         <div align="right">
        <table class="clienttable" cellspacing="0">
            <tr align="center" >
                <th colspan="8"> Legend </th>
            </tr>
            <tr>
                 <th>P</th><td>Number of Hours Present</td>
                 <th>A</th><td>Number of Hours Absent</td>
                 <th>O</th><td>Number of Hours On Duty</td>
                 <th>T</th><td>Number of Hours Taken</td>
             </tr>
         </table>
        </div>
         <br/>
         <div id="monthreportheading">
              <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
             <h1>Attendance Report for <%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%> for the month of
                 <%
                 String mont[]={"January","Febraury","March","April","May","June","July","August","September","October","November","December"};
             out.print(mont[Integer.parseInt(request.getParameter("month"))-1]) ;
                 %></h1>
         </div>
         <div class="scrollTableContainer" >
            <table class="dataTable" cellspacing="0" >
                <thead>
        <%
        out.print("<tr><th rowspan='2'>Reg. No.</th><th >Day</th>");
        do{
            out.print("<th colspan='"+rs.getString(3)+"'>"+rs.getString("day")+"</th>");
        }while(rs.next());
        out.print("<th colspan='4'>Cumulative Hours</th>");
        out.print("<th colspan='5'>Hours Taken</th>");
        

        out.print("</tr>");
        out.print("<tr><th>Student Name \\ Hour</th>") ;
        rs.first();

        int temp_cnt=0;
        do{
            String temp[]=rs.getString(2).split(",");
            for(int i=0;i<temp.length;i++){
                out.print("<th>"+temp[i]+"</th>");
                temp_cnt++; // used for absentees array alloc
            }
        }while(rs.next());
//out.print(temp_cnt);

        out.print("<th>T</th><th>P</th><th>A</th><th>O</th>");
        out.print("<th>T</th><th>P</th><th>A</th><th>O</th><th> &nbsp; &nbsp;</th>");
        out.print("</tr>");
        rs.first();
        String subpart="";
        do{
            subpart+=",TRIM(group_concat(if(a.date = '"+rs.getString("date")+"',a.ab_type,'') " +
                     "order by a.hour SEPARATOR ' ' ) ) '"+rs.getString("date")+"'";
        }while(rs.next());
        sql="select a.student_id,s.student_name "+subpart+",count(*),sum(if(a.ab_type='P',1,0)),sum(if(a.ab_type='A',1,0)),sum(if(a.ab_type='O',1,0)) from attendance a,students s "+
                "where a.student_id=s.student_id and subject_id='"+subject_id+"' and s.section = '"+section+"' group by student_id   order by a.student_id,a.hour;";
        //out.print(sql);
        rs=st.executeQuery(sql);
        ResultSetMetaData rsmd = rs.getMetaData();
        int NumOfCol=rsmd.getColumnCount();
       // out.print(NumOfCol);
        int [] tot_ab=new int[temp_cnt];
    %></thead><tbody><%
        while(rs.next()){
            A=P=O=0;
            temp_cnt=0;
            out.print("<tr>");

            for(int i=1;i<=NumOfCol;i++)
                if(i>2)
                {

                    String temp[]=rs.getString(i).split(" ");
                    for(int temploop=0;temploop<temp.length;temploop++)
                        if(!temp[temploop].trim().equals("")){
                            temp_cnt++;
                        %>    
                        <td <%=temp[temploop].equalsIgnoreCase("A")?"bgcolor='#ffeedd'":temp[temploop].equalsIgnoreCase("O")?"bgcolor='#eeffdd'":""%>><%=temp[temploop]%></td>
                        <%
                        if(temp[temploop].equalsIgnoreCase("A")){
                            A++;
                            tot_ab [temp_cnt-1]++;
                            
                            }
                        else if(temp[temploop].equalsIgnoreCase("O")){
                            O++;
                            tot_ab[temp_cnt-1]++;
                            }
                        else if(temp[temploop].equalsIgnoreCase("P"))
                            P++;
                        }
                    
                    
                }
                else {
                   //-- out.print("<td>"+P+"</td><td>"+A+"</td><td>"+O+"</td><td></td><td>"+(A+O+P)+"</td>") ;
                        out.print("<td>"+rs.getString(i)+"</td>");
                    }
            out.print("<td>"+(A+O+P)+"</td><td>"+P+"</td><td>"+A+"</td><td>"+O+"</td><td></td>");
            //out.print("<td>d1</td><td>d2</td><td>d3</td><td>d4</td>d5</td>") ;
            out.print("</tr>");

        }
        out.print("<tr><td colspan=2>Absentees</td>");
        for(int i=0;i<tot_ab.length;i++)
            out.print("<td>"+tot_ab[i]+"</td>");
        out.print("</tr>");
        %>
    </tbody>
    </table>
</div>
        <%

    }
    con.close();
    return;
}
if(request.getParameter("action").equals("view")){
// date validation

    Calendar today = Calendar.getInstance();

    String day_info[]=request.getParameter("date").split("/");
    Calendar myDate=Calendar.getInstance();

    
     myDate.set(Integer.parseInt(day_info[2]),Integer.parseInt(day_info[1])-1,Integer.parseInt(day_info[0]));

     int difInDays = (int) ((today.getTime().getTime() - myDate.getTime().getTime())/(1000*60*60*24));

//     out.println("<script>alert('Please Check the Date:"+difInDays+"');</script>");
    if(difInDays>150 || difInDays<0){ //It should not be a future date or previous month
         //out.println("<script>Please Check the Date</script>");
         out.println("<script>alert('Please Check the Date');</script>");
         con.close();
         return;

    }



%>
<table class='clienttable'>

<%
int itemcnt=0;
    java.util.StringTokenizer hour=null;
   /* sql="select hour,staff_id from attendance where semeter='"+semester+"' and date='"+request.getParameter("date")+"' and hour=''";
    while(hour.hasMoreElements()){
        sql+="or hour='"+hour.nextElement()+"'";
    }*/
    //out.print(sql);

    String taken_hour=request.getParameter("hour");
    ResultSet rs=null;
    String mode="";
    //out.print(session.getAttribute("elective"));
    sql="select a.hour,a.staff_id,a.subject_id,st.staff_name,s.subject_name,s.elective from attendance a,subject s,staff st where a.subject_id=s.subject_id and a.staff_id=st.staff_id  and a.semester='"+semester+"' and a.section='"+section+"' and a.date like STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') and (a.hour = "+request.getParameter("hour").replace(","," or hour=")+") group by hour,subject_id";
    //out.print(sql);
            rs=st.executeQuery(sql);
            boolean flag=false;
            String input_hour[]=request.getParameter("hour").split(",");
            
            while(rs.next()){
                boolean hrflag=false;
                for(int t=0;t<input_hour.length;t++)
                    //out.print(Integer.parseInt(input_hour[t])+"="+Integer.parseInt(rs.getString("hour"))+" t="+t+"<br>");
                    if(Integer.parseInt(input_hour[t])==Integer.parseInt(rs.getString("hour")))
                        hrflag=true;
                    

                //out.print(rs.getString("subject_id")+"-"+subject_id);
                if((!rs.getString("subject_id").equals(subject_id)) && (rs.getString("elective").equals("null")) && hrflag){
                    out.print("<br> <center><b>Warning!</b> The attendance has been put for "+rs.getString("subject_name")+"  by "+rs.getString("staff_name")+" for the "+rs.getString("hour") +" hour</center>");
			 out.print("<script> alert('The attendance has been put for "+rs.getString("subject_name")+"  by "+rs.getString("staff_name")+" for the "+rs.getString("hour") +" hour')</script>");

                    flag=true;
                }
             }
            if(flag && session.getAttribute("elective").equals("no")){
                    con.close();
                    return;
            }


    if(elective.equals("yes")){
        sql="SELECT s.student_id,s.student_name,s.semester,a.subject_id,s.semester,a.subject_id, "+
            "group_concat(CASE a.ab_type WHEN 'A' THEN 'checked' when 'O' then 'readonly' "+
            "else 'nochecked' end order by hour) ab_type,group_concat(hour order by hour) hour,date FROM students s "+
            "left join attendance a on a.student_id=s.student_id,elective_students e "+
            "where e.student_id=a.student_id and a.subject_id=e.subject_id and a.subject_id='"+subject_id+"' and date=STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') "+
            " and (hour="+request.getParameter("hour").replace(",", " or ")+") group by a.student_id;";
        //out.print(sql);
        rs=st.executeQuery(sql);
        mode="edit";
        if(!rs.next()){
            sql="select s.* from elective_students e,students s where s.student_id=e.student_id and subject_id='"+subject_id+"'";
            rs=st.executeQuery(sql);
            mode="add";
        }

    }
    else{

        sql="SELECT s.student_id,s.student_name,s.semester,a.subject_id,group_concat(CASE a.ab_type WHEN 'A' THEN 'checked' when 'O' then 'readonly' else 'nochecked' end order by hour) ab_type,group_concat(hour order by hour) hour,date FROM students s left join "+
             "attendance a on a.student_id=s.student_id where s.semester='"+semester+"' and s.section='"+section+"' and a.subject_id='"+subject_id+"' and date=STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') and (hour="+request.getParameter("hour").replace(",", " or ")+") group by a.student_id;";
       // out.print(sql);
        mode="edit";
        rs=st.executeQuery(sql);
        if(!rs.next()){
             sql="select * from students where semester="+semester+" and section="+section;
             rs=st.executeQuery(sql);
             //taken_hour=request.getParameter("hrs");
             mode="add";
         }
        /*else
            taken_hour=rs.getString("hour");*/

    }
    if(!rs.first()){
            out.print("no Students Assigned");
            con.close();
            return;
        }

    java.util.StringTokenizer absent=null;
    do{
        hour=new java.util.StringTokenizer(taken_hour,",");
        if(mode.equals("edit"))
             absent=new java.util.StringTokenizer(rs.getString("ab_type"),",");
        int i=1;
	  if(itemcnt%4==0)out.print("</tr>");

        %>
	<th id="<%=rs.getString(1)%>">

            <%while(hour.hasMoreElements()){
                String hr=hour.nextElement().toString(); %>
                <input  type="checkbox" id="<%=rs.getString(1)%>-<%=i++%>" value="<%=rs.getString(1)%>-<%=hr%>" <%=(mode.equals("edit")&&absent.hasMoreElements()&&rs.getString("hour").contains(hr))?absent.nextElement():""%> >
            <%}%>
            <label onclick="selectgroup('<%=rs.getString(1)%>')"> <%=rs.getString(2)%> [ <%=rs.getString(1).substring(rs.getString(1).length()-3)%> ]</label>


	</th>

<%
	itemcnt++;
	if(itemcnt%4==0)out.print("</tr>");

     }while(rs.next());
   con.close();
%>
<caption>Students List</caption>
</table>
<br/>
<center>
<input type="button" value="Save Attendance" onclick="feedAttendance('<%=mode%>')">
<input type="button" value="Invert Selection" onclick="InvertSelect()"/>
</center>
<script>
    $('#hrs').val('<%=taken_hour%>')
</script>
<%return;}
con.close();
%>