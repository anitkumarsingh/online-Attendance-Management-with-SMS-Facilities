
<%--
    Document   : ShowStaff
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


<%@ include file="../../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>
<%
  try{
        Connection connection =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        if(request.getParameter("action").toString().equals("showBatch")){%>
        <font style="font-weight:bolder" color="red">Subjectwise Report :</font>
            <div id="HistoryReport">
                     <ul style="display:none">
                         <li id="Subjectwise Report" class="folder">Subjectwise Report
                             <ul>
                                <% ResultSet rs=st.executeQuery("SELECT distinct(subject_id),subject_name FROM semesterinfo.semester_subject_info order by semester");
                                while(rs.next()){%>
                                 <li id="<%=rs.getString(1)%>"><a href="#" onclick="HistoryReport('<%=rs.getString(1)%>','<%=rs.getString(2)%>')" ><%=rs.getString(2)+"("+rs.getString(1)+")"%></a>
                                  <%}%>
                             </ul>
                     </ul>
                 </div>
          <font style="font-weight:bolder" color="red">Batchwise Report :</font>
          <div id="Batch">
          <ul style="display:none">
                <%
                int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                year-=NO_OF_YEARS;
                for(int i=year;i<=year+NO_OF_YEARS;i++){%>
                <li id="<%=i%>" class="folder">Batch(<%=i%>)
                    <ul>
                      <%for(int j=1;j<=NO_OF_YEARS*2;j++){%>
                      <li id="<%=j%>"><a href="#" onclick="ReportGetSection('<%=i%>','<%=j%>')" >Semester-<%=j%></a>
                      <%}%>
                    </ul>
               <%}%>
               </ul>
          </div>
           
        <%}else if(request.getParameter("action").toString().equals("showSection")){
            int i=0;
                 ResultSet rs=st.executeQuery("SELECT * FROM semesterinfo.semester_students_info where semester="+request.getParameter("semester")+" and batch="+request.getParameter("batch")+" group by section");  %>
                 <font style="font-weight:bolder" color="red">Section :</font>
                 <div id="Section">
                 <ul>
                  <%while(rs.next()){%>
                  <li id="<%=i%>" ><a href="#" onclick="SelectSection('<%=request.getParameter("semester")%>','<%=request.getParameter("batch")%>','<%=++i%>')">Section-<%=(char)(i+'A'-1)%></a>
                  <%}%>
                 </ul>
                 </div>
                 <font style="font-weight:bolder" color="red">Report :</font>
                 <div id="Report">
                     <ul>
                         <li id="report1"> <a href="#" onclick="SemesterClassReport()">Class Report</a>
                         <li id="report2"> <a href="#" onclick="SemesterSubjectReport()">Subject Report</a>
                         <li id="report3"> <a href="#" onclick="OverallReport()">Overall Report</a>

                     </ul>
                 </div>
                 
<%        }else if(request.getParameter("action").toString().equals("showHistoryReport")){
            String subject_id=request.getParameter("subj_id");
            String subject_name=request.getParameter("subject_name");
            %>

            <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                              <td style="font-weight:bolder">Subject Code  :</td><td><%=subject_id%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Subject Name  :</td><td><%=subject_name%>&nbsp;&nbsp;&nbsp; </td>
                            </tr>
                        </thead>
            </table>
            <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                                <th>Batch</th>
                                <th>Sem</th>
                                <th>Sec</th>
                                <th>#App</th>
                                <th>#Pass</th>
                                <th>#Fail</th>
                                <th>Pass %</th>
                                <th>Faculty</th>
                                <th>Date</th>
                             </tr>
                        </thead>
                        <tbody>
            <%
            ResultSet rs=st.executeQuery("SELECT examid,yoe,moe,faculty_name,batch,section,semester,elective FROM semesterinfo.semester_subject_info where subject_id='"+subject_id+"'");
            Connection con =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();
            while(rs.next())
            {       java.util.Formatter fmt_percent=new java.util.Formatter();
                    int appeared=0,pass=0,fail=0,dist=0,cls_avg=0;
                    double pass_pct=0;
                    if(rs.getString("elective").equals("YES")){
                        ResultSet rset=stmt.executeQuery("SELECT concat(count(student_id),'-1') FROM semesterinfo.semester_elective_students where examid="+rs.getString("examid")+" union SELECT concat(count(student_id),'-2') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Pass' union SELECT concat(count(student_id),'-3') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Fail'");
                        if(rset.next()){
                        appeared=Integer.parseInt(rset.getString(1).split("-")[0]);
                        if(rset.next())
                        pass=Integer.parseInt(rset.getString(1).split("-")[0]);
                        if(rset.next())
                        fail=Integer.parseInt(rset.getString(1).split("-")[0]);
                        pass_pct=((double)pass/appeared)*100;
                        fmt_percent.format("%.2f", pass_pct);}
                    }else{
                        ResultSet rset=stmt.executeQuery("SELECT concat(count(student_id),'-1') FROM semesterinfo.semester_students_info where batch="+rs.getString("batch")+" and semester="+rs.getString("semester")+" and section="+rs.getString("section")+" union SELECT concat(count(student_id),'-2') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Pass' union SELECT concat(count(student_id),'-3') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Fail'");
                        if(rset.next()){
                        appeared=Integer.parseInt(rset.getString(1).split("-")[0]);
                        if(rset.next())
                        pass=Integer.parseInt(rset.getString(1).split("-")[0]);
                        if(rset.next())
                        fail=Integer.parseInt(rset.getString(1).split("-")[0]);
                        pass_pct=((double)pass/appeared)*100;
                        fmt_percent.format("%.2f", pass_pct);}
                    }
                    %>
                                <tr>
                                    <td><%=rs.getString(5)%></td>
                                    <td><%=rs.getString(7)%></td>
                                    <td><%=(char)(rs.getInt(6)+'A'-1)%></td>
                                    <td><%=appeared%></td>
                                    <td><%=pass%></td>
                                    <td><%=fail%></td>
                                    <td><%=fmt_percent%></td>
                                    <td><%=rs.getString(4)%></td>
                                    <td><%=rs.getString("moe")+""+rs.getString("yoe")%></td>
                                </tr>
            <%}%>
                    </tbody>
                    </table>
                    <%
            con.close();
            }else if(request.getParameter("action").toString().equals("showclassreport")){
            int sem = 0,batch = 0,section=0;
            if(request.getParameter("section").equals("undefined")){
                connection.close();
                out.print("<span class=error>Please Select a Section</span>");
                return;
            }else{
            section=Integer.parseInt(request.getParameter("section").toString());
            sem=Integer.parseInt(request.getParameter("semester").toString());
            batch=Integer.parseInt(request.getParameter("batch").toString());
            String Grade="";
            Connection con =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();
            Connection conn =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement statement=conn.createStatement();
            ResultSet rs=st.executeQuery("SELECT subject_id,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+"");
            %>

            <table id="hor-minimalist-b">
                  <tr>
                      <th rowspan="2">ID</th>
                      <th rowspan="2">Name</th>
                        <%while(rs.next()){
                            Grade=rs.getString("grade");%>
                        <th <%=(rs.getString("grade").equals("YES"))?"colspan='3'":"colspan='4'"%>><%=rs.getString(1)%></th>
                         <%}%>
                        <th  rowspan='2'><%=(Grade.equals("YES"))?"GPA":"Total"%></th>
                        <th  rowspan='2'>Percent</th>
                        <th  rowspan="2">Rank</th>
                    </tr>

                    <tr>
                        <%rs.first();
                        do{%>
                        <th><%=(Grade.equals("YES"))?"Cr":"It"%></th>
                        <th><%=(Grade.equals("YES"))?"Gr":"Et"%></th>
                        <%=(Grade.equals("YES"))?"":"<th>Tot</th>"%>
                        <th>P/F</th>
                        <%}while(rs.next());%>
                    </tr>

               <%
               ResultSet rset=stmt.executeQuery("SELECT student_id,student_name FROM semesterinfo.semester_students_info where batch="+batch+" and semester="+sem+" and section="+section+"");
               while(rset.next()){
                int total=0,no_subj=0,credit=0;
               double percent=0,gpa=0;%>
                 <tr>
                    <td><%=rset.getString(1).substring(rset.getString(1).length()-2)%></td>
                    <td><%=rset.getString(2)%></td>
                    <%
                rs=st.executeQuery("SELECT subject_id,examid,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+"");
                 while(rs.next()){
                     no_subj++;
                     ResultSet rset1=statement.executeQuery("SELECT internal,external,result FROM semesterinfo.semester_mark_info where student_id='"+rset.getString("student_id")+"' and examid="+rs.getString("examid")+"");
                    if(rset1.next()){
                    Grade= rs.getString("grade");
                    if(Grade.equals("YES")){
                        credit+=rset1.getInt(2);
                        int i=0;
                        for(i=0;i<=GRADE_LETTER.length;i++)
                            if(GRADE_LETTER[i].equals(rset1.getString(1)))
                                break;
                        total+=rset1.getInt(2)*GRADE_POINT[i];
                        //out.print(i+""+rset1.getString(2)+""+rset.getString(2)+""+total);
                    }else{
                        total+=rset1.getInt(1)+rset1.getInt(2);
                    }
                        %>
                    <td align="center"><%=rset1.getString(1)%></td>
                    <td align="center"><%=rset1.getString(2)%></td>
                    <%=(rs.getString("grade").equals("YES"))?"":"<td align='center'>"+(rset1.getInt(1)+rset1.getInt(2))+"</td>"%>
                    <td align="center"><%=rset1.getString(3).substring(0,1)%></td>
                    <%}else{%>
                    <td>-</td>
                    <td>-</td>
                    <%=(rs.getString("grade").equals("YES"))?"":"<td>-</td>"%>
                    <td>-</td>
                    <%}
                    }java.util.Formatter fmt_gpa=new java.util.Formatter();
                     java.util.Formatter fmt_percent=new java.util.Formatter();
                      if(Grade.equals("YES")){
                      gpa=((double)total/credit);
                      percent=(double)gpa*10;
                      fmt_gpa.format("%.2f", gpa);
                      fmt_percent.format("%.2f", percent);
                     }else{
                      percent=((double)total/no_subj*100)/100;
                      fmt_percent.format("%.2f", percent);
                     }
                    %>
                     <td><%=(Grade.equals("YES"))?fmt_gpa:total%></td>
                     <td><%=fmt_percent%></td>
                   <td>1</td>
                </tr>
             <%}%>

             </table>
                        <%
            con.close();
            conn.close();
            }
        }else if(request.getParameter("action").toString().equals("showsubjectreport")){
            int sem = 0,batch = 0,section=0;
            if(request.getParameter("section").equals("undefined")){
                connection.close();
                out.print("<span class=error>Please Select a Section</span>");
                return;
            }else{
            section=Integer.parseInt(request.getParameter("section").toString());
            sem=Integer.parseInt(request.getParameter("semester").toString());
            batch=Integer.parseInt(request.getParameter("batch").toString());
            Connection con =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();

            %>

            <table id="hor-minimalist-b">
                  <tr>
                      <th>Code</th>
                      <th>Subject</th>
                      <th>Faculty</th>
                      <th>#App</th>
                      <th>#Pass</th>
                      <th>#Fail</th>
                      <th>Pass%</th>
                      <th>#Dist</th>
                      <th>Cls Avg</th>
                    </tr>
              <%ResultSet rs=st.executeQuery("SELECT subject_name,subject_id,faculty_name,examid,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+" and elective ='null'");
              while(rs.next()){
                  int appeared=0,pass=0,fail=0,dist=0,cls_avg=0;
                    double pass_pct=0;%>
                 <tr>
                    <td><%=rs.getString("subject_id")%></td>
                    <td><%=rs.getString("subject_name")%></td>
                    <td><%=rs.getString("faculty_name")%></td>
                    <%java.util.Formatter fmt_percent=new java.util.Formatter();
                    ResultSet rset=stmt.executeQuery("SELECT concat(count(student_id),'-1') FROM semesterinfo.semester_students_info where batch="+batch+" and semester="+sem+" and section="+section+" union SELECT concat(count(student_id),'-2') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Pass' union SELECT concat(count(student_id),'-3') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Fail'");
                    if(rset.next()){
                    appeared=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    pass=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    fail=Integer.parseInt(rset.getString(1).split("-")[0]);
                    pass_pct=((double)pass/appeared)*100;
                    fmt_percent.format("%.2f", pass_pct);}
                    %>
                    <td><%=appeared%></td>
                    <td><%=pass%></td>
                    <td><%=fail%></td>
                    <td><%=fmt_percent%></td>
                    <td><%=dist%></td>
                    <td><%=cls_avg%></td>
                 </tr>
                    <%}%>
                 <%rs=st.executeQuery("SELECT subject_name,subject_id,faculty_name,examid,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+" and elective ='YES'");
              while(rs.next()){
                  int appeared=0,pass=0,fail=0,dist=0,cls_avg=0;
                  double pass_pct=0;  %>
                 <tr>
                    <td><%=rs.getString("subject_id")%></td>
                    <td><%=rs.getString("subject_name")%></td>
                    <td><%=rs.getString("faculty_name")%></td>
                    <%
                    java.util.Formatter fmt_percent=new java.util.Formatter();
                    ResultSet rset=stmt.executeQuery("SELECT concat(count(student_id),'-1') FROM semesterinfo.semester_elective_students where examid="+rs.getString("examid")+" union SELECT concat(count(student_id),'-2') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Pass' union SELECT concat(count(student_id),'-3') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Fail'");
                    if(rset.next()){
                    appeared=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    pass=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    fail=Integer.parseInt(rset.getString(1).split("-")[0]);
                    pass_pct=((double)pass/appeared)*100;
                    fmt_percent.format("%.2f", pass_pct);}
                    %>
                    <td><%=appeared%></td>
                    <td><%=pass%></td>
                    <td><%=fail%></td>
                    <td><%=fmt_percent%></td>
                    <td><%=dist%></td>
                    <td><%=cls_avg%></td>
                 </tr>
                    <%}%>
                     </table>
                     <div id="graph">Loading graph...</div>
                     <script>showGraph();</script>
            <%
            con.close();
            }
        }else if(request.getParameter("action").toString().equals("overallreport")){
            int sem = 0,batch = 0,section=0;
            int total=0,no_subj=0,credit=0,grand_total=0,grand_subj_total=0,grand_credit_total=0,arrears=0;
            double percent=0,gpa=0;
            String Grade="";
            if(request.getParameter("section").equals("undefined")){
                connection.close();
                
                out.print("<span class=error>Please Select a Section</span>");
                return;
            }else{
            section=Integer.parseInt(request.getParameter("section").toString());
            batch=Integer.parseInt(request.getParameter("batch").toString());
            Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();
            Connection conn =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement statement=conn.createStatement();
            ResultSet rs=st.executeQuery("SELECT grade FROM semesterinfo.semester_subject_info where batch="+batch+" group by grade");
             if(rs.next())
                 Grade=rs.getString(1);
            rs=st.executeQuery("SELECT max(semester) FROM semesterinfo.semester_subject_info where batch="+batch+"");
             if(rs.next())
                 sem=rs.getInt(1);
             %>
            <table id="hor-minimalist-b">
                  <tr>
                      <th>ID</th>
                      <th>Name</th>
                        <%for(int i=1;i<=sem;i++){%>
                        <th><%=(Grade.equals("YES"))?"SGPA-"+i+"":"Sem-"+i+"%"%></th>
                        <%}%>
                      <th><%=(Grade.equals("YES"))?"CGPA":"Overall-%"%></th>
                      <th>Arrears</th>
                      <th>Rank</th>
                    </tr>
              <%ResultSet rset=stmt.executeQuery("SELECT DISTINCT student_id,student_name FROM semesterinfo.semester_students_info where batch="+batch+" and section="+section+" order by student_name");
               while(rset.next()){
                grand_total=0;
                grand_subj_total=0;
                grand_credit_total=0;
                arrears=0;%>
                 <tr>
                    <td><%=rset.getString(1).substring(rset.getString(1).length()-2)%></td>
                    <td><%=rset.getString(2)%></td>
                    <%for(int i=1;i<=sem;i++){
                        total=0;no_subj=0;credit=0;percent=0;gpa=0;
                        rs=st.executeQuery("SELECT internal,external FROM semesterinfo.semester_mark_info where student_id="+rset.getString(1)+" and result='Pass' and examid in (SELECT examid FROM semesterinfo.semester_subject_info where semester="+i+" and batch="+batch+")");
                         while(rs.next()){
                             if(Grade.equals("YES"))
                             {credit+=rs.getInt(2);
                                 int j=0;
                                 for(j=0;j<=GRADE_LETTER.length;j++)
                                    if(GRADE_LETTER[j].equals(rs.getString(1)))
                                        break;
                                 total+=rs.getInt(2)*GRADE_POINT[j];
                             }else if(Grade.equals("null")){
                                 no_subj++;
                                 total+=rs.getInt(1)+rs.getInt(2);
                             }
                             //out.print(total+"-"+credit+" -");
                             }
                        rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info WHERE semester ="+i+" and section="+section+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+rset.getString(1)+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+rset.getString(1)+" and result='Pass'))");
                         while(rs.next()){
                           // out.print("SELECT internal,external FROM semesterinfo.semester_mark_info where student_id='"+rset.getString(1)+"' and examid="+rs.getString("examid")+" order by yoe desc,moe desc limit 1");
                             ResultSet rset1=statement.executeQuery("SELECT internal,external FROM semesterinfo.semester_mark_info where student_id='"+rset.getString(1)+"' and examid="+rs.getString("examid")+" order by yoe desc,moe desc limit 1");
                                if(rset1.next()){
                                    arrears++;
                                    if(Grade.equals("YES"))
                                     {
                                         credit+=rset1.getInt(2);
                                         int j=0;
                                         for(j=0;j<=GRADE_LETTER.length;j++)
                                            if(GRADE_LETTER[j].equals(rset1.getString(1)))
                                                break;
                                         //out.print(rset1.getInt(1)*GRADE_POINT[j]+" -"+rset1.getString(2));
                                         total+=rset1.getInt(2)*GRADE_POINT[j];
                                     }else if(Grade.equals("null")){
                                         no_subj++;
                                         total+=rset1.getInt(1)+rset1.getInt(2);
                                     }
                                }
                             //out.print(total+"-f"+credit+" -");
                             }
                             java.util.Formatter fmt_gpa=new java.util.Formatter();
                             java.util.Formatter fmt_percent=new java.util.Formatter();
                               if(Grade.equals("YES")){
                                  if(credit==0)
                                    gpa=0;
                                  else{
                                    grand_total+=total;
                                    grand_credit_total+=credit;
                                    gpa=(double)total/credit;
                                    }
                                 fmt_gpa.format("%.2f", gpa);
                                }else if(Grade.equals("null")){
                                  if(no_subj==0)
                                      percent=0;
                                  else{
                                      grand_total+=total;
                                      grand_subj_total+=no_subj;
                                      percent=((double)total/no_subj);
                                      }
                                  fmt_percent.format("%.2f", percent);
                                }
                                %>
                                <td align="center"><%=Grade.equals("YES")?fmt_gpa:fmt_percent+"-%"%></td>
                                <%}
                             java.util.Formatter fmt_sgpa=new java.util.Formatter();
                             java.util.Formatter fmt_ovr_percent=new java.util.Formatter();
                             double sgpa=0,ovr_percent=0;
                             if(Grade.equals("YES")){
                              if(grand_credit_total==0)
                                sgpa=0;
                              else
                                sgpa=(double)grand_total/grand_credit_total;
                              fmt_sgpa.format("%.2f", sgpa);
                             }else if(Grade.equals("null")){
                               if(grand_subj_total==0)
                                   ovr_percent=0;
                               else
                                   ovr_percent=((double)grand_total/grand_subj_total);
                               fmt_ovr_percent.format("%.2f", ovr_percent);
                            }
                             %>
                                <td><%=Grade.equals("YES")?fmt_sgpa:fmt_ovr_percent+"-%"%></td>
                                <td><%=arrears%></td>
                                <td>to be calculated</td>
                </tr>
             <%}%>

             </table>
                        <%
            con.close();
            conn.close();

            }
        }connection.close();
  }catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }

%>