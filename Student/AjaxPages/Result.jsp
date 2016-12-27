<%--
    Document   : Assessment
    Created on : Aug 6, 2009, 10:28:46 AM
    Author     : Dinesh Kumar
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
               try{
                Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement st=connection.createStatement();
                String student_id=session.getAttribute("userid").toString();

                if(request.getParameter("action").toString().equals("find")){
                    int sem=Integer.parseInt(request.getParameter("semester").toString());
                    String moe=exam_months[sem%2];
                    int section=0,batch=0,yoe;
                    //out.print(sql);
                    ResultSet rs=st.executeQuery("select batch,section from semesterinfo.semester_students_info where student_id='"+student_id+"' and semester="+sem+"");
                    if(rs.next())
                        {
                        batch=rs.getInt(1);
                        section=rs.getInt(2);
                        }
                    yoe=batch+(sem/2);
                    //rs=st.executeQuery("select s.faculty_name,s.subject_name,s.subject_id,s.yoe,s.moe,s.grade,m.internal,m.external,m.result,t.student_name from semesterinfo.semester_subject_info s,semesterinfo.semester_mark_info m,semesterinfo.semester_students_info t where s.section and s.semester="+sem+" and s.batch and s.examid=m.examid and t.student_id and t.student_id=m.student_id and s.section=t.section and s.semester=t.semester and s.batch=t.batch");
                    Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                    Statement stmt=con.createStatement();
                    ResultSet rset=stmt.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+"");
                    //out.print("select s.faculty_name,s.subject_name,s.subject_id,s.yoe,s.moe,s.grade,m.internal,m.external,m.result,t.student_name,m.moe,m.yoe,s.examid,s.semester from semesterinfo.semester_subject_info s,semesterinfo.semester_mark_info m,semesterinfo.semester_students_info  t where s.batch="+batch+" and s.examid=m.examid and t.student_id  ='"+student_id+"' and t.student_id=m.student_id and s.section=t.section and s.semester=t.semester and s.batch=t.batch and m.yoe ='"+yoe+"' and m.moe ='"+moe+"'");
                    rs=st.executeQuery("select s.faculty_name,s.subject_name,s.subject_id,s.yoe,s.moe,s.grade,m.internal,m.external,m.result,t.student_name,m.moe,m.yoe,s.examid,s.semester from semesterinfo.semester_subject_info s,semesterinfo.semester_mark_info m,semesterinfo.semester_students_info  t where s.batch="+batch+" and s.examid=m.examid and t.student_id  ='"+student_id+"' and t.student_id=m.student_id and s.section=t.section and s.semester=t.semester and s.batch=t.batch and m.yoe ='"+yoe+"' and m.moe ='"+moe+"'");
                    if(rs.next())
                    {
                   String Grade=rs.getString("grade");
                   double percent=0,gpa=0;
                   int total=0,credit=0,no_subj=0;
                     %>

                    <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                              <td style="font-weight:bolder">Reg No  :</td><td><%=student_id%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Name :</td> <td><%=rs.getString(10)%>&nbsp;&nbsp;&nbsp; </td>
                            </tr>
                            <tr>
                              <td style="font-weight:bolder">Date :</td><td><%=rs.getString(5)+"-"+rs.getString(4)%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Batch :</td> <td><%=batch%>&nbsp;&nbsp;&nbsp; </td>
                           </tr>
                        </thead>
                    </table>
                    <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                                <th>Sem</th>
                                <th>Code</th>
                                <th>Name</th>
                                <th><%=(Grade.equals("YES"))?"Credit":"Int"%></th>
                                <th><%=(Grade.equals("YES"))?"Grade":"Ext"%></th>
                                <%=(Grade.equals("YES"))?"":"<th>Total</th>"%>
                                <th>Result</th>
                                <th>Staff Incharge</th>
                           </tr>
                        </thead>
                        <tbody>
                            <%
                            do{
                                while(rset.next()){
                                   if(Grade.equals("YES")&& rset.getString("examid").equals(rs.getString("examid"))){
                                        credit+=rs.getInt(7);
                                        int i=0;
                                        for(i=0;i<=GRADE_LETTER.length;i++)
                                            if(GRADE_LETTER[i].equals(rs.getString(8)))
                                            break;
                                        total+=rs.getInt(7)*GRADE_POINT[i];
                                        //out.print(""+total+""+credit);
                                   }else if(Grade.equals("null")&& rset.getString("examid").equals(rs.getString("examid"))){
                                            total+=rs.getInt(7)+rs.getInt(8);
                                            no_subj++;
                    }}%>
                            <tr>
                                <td><%=rs.getString("semester")%></td>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(7)%></td>
                                <td><%=rs.getString(8)%></td>
                                 <%=(Grade.equals("YES"))?"":"<td>"+(rs.getInt(7)+rs.getInt(8))+"</td>"%>
                                <td><%=rs.getString(9)%></td>
                                 <td><%=rs.getString(1)%></td>
                            </tr>
                            <%  rset.first();}while(rs.next());
                             java.util.Formatter fmt_gpa=new java.util.Formatter();
                             java.util.Formatter fmt_percent=new java.util.Formatter();
                            if(Grade.equals("YES")){
                              gpa=(double)total/credit;
                              percent=(double)gpa*10;
                              fmt_gpa.format("%.2f", gpa);
                              fmt_percent.format("%.2f", percent);
                            }else if(Grade.equals("null")){
                              percent=((double)total/no_subj);
                              fmt_percent.format("%.2f", percent);
                            }

                  %>
                        </tbody>
                    </table>
                        
                     <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                              <td style="font-weight:bolder"><%=(Grade.equals("YES"))?"GPA":"Total"%> :</td><td><%=(Grade.equals("YES"))?fmt_gpa:total%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Percent :</td> <td><%=fmt_percent%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Rank :</td> <td>Soon to be calculated</td>
                            </tr>

                        </thead>
                    </table>
                              <center><span class=success>Note:  The Total / GPA, Percent, Rank are calculated with the scores of '<%=sem%>' semester papers</span></center>
                    <%
                        con.close();
                        connection.close();
                        return;
                    }else
                        {
                        con.close();
                        connection.close();
                        out.print("0");
                        return;
                        }
                    }else if(request.getParameter("action").toString().equals("overall")){
                     int cur_sem=0,batch=0;
                     String name="",Grade="";
                     ResultSet rs=st.executeQuery("select batch,semester,student_name from students where student_id='"+student_id+"'");
                     if(rs.next())
                     {       batch=rs.getInt(1); cur_sem=rs.getInt(2); name=rs.getString(3);
                     }
                     rs=st.executeQuery("select grade from semesterinfo.semester_subject_info where batch='"+batch+"'");
                     if(rs.next())
                      Grade=rs.getString(1);%>

                     <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                              <td style="font-weight:bolder">Reg No  :</td><td><%=student_id%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Name :</td> <td><%=name%>&nbsp;&nbsp;&nbsp; </td>
                            </tr>
                        </thead>
                    </table>

                     <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                                <th>Sem</th>
                                <th>Code</th>
                                <th>Name</th>
                                <th><%=(Grade.equals("YES"))?"Credit":"Int"%></th>
                                <th><%=(Grade.equals("YES"))?"Grade":"Ext"%></th>
                                <%=(Grade.equals("YES"))?"":"<th>Total</th>"%>
                                <th>Result</th>
                                <th>Staff Incharge</th>
                                <th>DOE</th>
                           </tr>
                        </thead>
                        <tbody>

                     <%Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                       Statement stmt=con.createStatement();
                     int total=0,no_subj=0,credit=0,arrears=0;
                     double percent=0,gpa=0;
                     for(int i=1;i<=cur_sem;i++)
                         {
                            rs=st.executeQuery("SELECT m.internal,m.external,m.result,s.subject_id,s.subject_name,s.faculty_name,m.moe,m.yoe FROM semesterinfo.semester_mark_info m, semesterinfo.semester_subject_info s where s.examid=m.examid and  m.student_id="+student_id+" and m.result='Pass' and m.examid in (SELECT examid FROM semesterinfo.semester_subject_info where semester="+i+" and batch="+batch+")");
                            while(rs.next())
                                {
                                if(Grade.equals("YES"))
                                     {credit+=rs.getInt(1);
                                         int j=0;
                                         for(j=0;j<=GRADE_LETTER.length;j++)
                                            if(GRADE_LETTER[j].equals(rs.getString(2)))
                                                break;
                                         total+=rs.getInt(1)*GRADE_POINT[j];
                                     }else if(Grade.equals("null")){
                                         no_subj++;
                                         total+=rs.getInt(1)+rs.getInt(2);
                                     }%>
                                    <tr>
                                        <td><%=i%></td>
                                        <td><%=rs.getString(4)%></td>
                                        <td><%=rs.getString(5)%></td>
                                        <td><%=rs.getString(1)%></td>
                                        <td><%=rs.getString(2)%></td>
                                        <%=(Grade.equals("YES"))?"":"<td>"+(rs.getInt(1)+rs.getInt(2))+"</td>"%>
                                        <td><%=rs.getString(3)%></td>
                                        <td><%=rs.getString(6)%></td>
                                        <td><%=rs.getString(7)+" "+rs.getString(8)%></td>
                                    </tr>
                                <%}
                            rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info WHERE semester ="+i+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Pass'))");
                            while(rs.next())
                            {
                            ResultSet rset1=stmt.executeQuery("SELECT m.internal,m.external,m.result,s.subject_id,s.subject_name,s.faculty_name,m.moe,m.yoe FROM semesterinfo.semester_mark_info m, semesterinfo.semester_subject_info s where s.examid=m.examid and m.student_id='"+student_id+"' and m.examid="+rs.getString("examid")+" order by m.yoe desc,m.moe desc limit 1");
                                if(rset1.next()){
                                    arrears++;
                                    if(Grade.equals("YES"))
                                     {
                                         credit+=rset1.getInt(1);
                                         int j=0;
                                         for(j=0;j<=GRADE_LETTER.length;j++)
                                            if(GRADE_LETTER[j].equals(rset1.getString(2)))
                                                break;
                                         //out.print(rset1.getInt(1)*GRADE_POINT[j]+" -"+rset1.getString(2));
                                         total+=rset1.getInt(1)*GRADE_POINT[j];
                                     }else if(Grade.equals("null")){
                                         no_subj++;
                                         total+=rset1.getInt(1)+rset1.getInt(2);
                                     }
                                %>
                                    <tr>
                                        <td><%=i%></td>
                                        <td><%=rset1.getString(4)%></td>
                                        <td><%=rset1.getString(5)%></td>
                                        <td><%=rset1.getString(1)%></td>
                                        <td><%=rset1.getString(2)%></td>
                                        <%=(Grade.equals("YES"))?"":"<td>"+(rset1.getInt(1)+rset1.getInt(2))+"</td>"%>
                                        <td><%=rset1.getString(3)%></td>
                                        <td><%=rset1.getString(6)%></td>
                                        <td><%=rset1.getString(7)+" "+rset1.getString(8)%></td>
                                    </tr>
                                 <%}
                            }
                         }

                     %>
                        </tbody>
                     </table>

                   <%java.util.Formatter fmt_gpa=new java.util.Formatter();
                     java.util.Formatter fmt_percent=new java.util.Formatter();
                       if(Grade.equals("YES")){
                          if(credit==0)
                            gpa=0;
                          else
                            gpa=(double)total/credit;
                        fmt_gpa.format("%.2f", gpa);
                        }else if(Grade.equals("null")){
                          if(no_subj==0)
                              percent=0;
                          else
                               percent=((double)total/no_subj);
                        fmt_percent.format("%.2f", percent);
                        }
                      %>
                    <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                              <%=(Grade.equals("YES"))?"":"<td 'style=font-weight:bolder'>Total :</td> <td>"+total+"/"+no_subj*100+"</td>"%>
                              <td style="font-weight:bolder"><%=(Grade.equals("YES"))?"CGPA":"Overall-%"%></td><td><%=Grade.equals("YES")?fmt_gpa:fmt_percent+"-%"%> </td>
                              <td style="font-weight:bolder">Arrears Left  :</td><td><%=(arrears==0)?"Nill":arrears%> </td>
                           </tr>
                        </thead>
                    </table>

                      <%connection.close();
                        con.close();
                        return;
                    }else if(request.getParameter("action").toString().equals("show"))
                    {
                        int sem=Integer.parseInt(request.getParameter("semester").toString());
                        int section=0,batch=0;
                        ResultSet rs=st.executeQuery("select batch,section from semesterinfo.semester_students_info where student_id='"+student_id+"' and semester="+sem+"");
                        if(rs.next())
                            {
                            batch=rs.getInt(1);
                            section=rs.getInt(2);
                            }
                   // out.print("SELECT subject_name,subject_id,yoe,moe,examid,grade FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='null'");    
                    rs=st.executeQuery("SELECT subject_name,subject_id,yoe,moe,examid,grade FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='null'");
                    if(rs.next())
                    {%>

                    <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                              <td style="font-weight:bolder">Reg No  :</td><td><%=student_id%>&nbsp;&nbsp;&nbsp; </td></td>
                              <td style="font-weight:bolder">Date of Exam :</td><td><%=rs.getString(4)+"-"+rs.getString(3)%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Batch :</td> <td><%=batch%>&nbsp;&nbsp;&nbsp;</td>
                           </tr>
                        </thead>
                    </table>
                    <table id="hor-minimalist-b">
                        <thead>
                            <tr>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th><%=(rs.getString("grade").equals("YES"))?"Credit":"Int"%></th>
                                <th><%=(rs.getString("grade").equals("YES"))?"Grade":"Ext"%></th>
                                <th>Result</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%do{%>
                            <tr>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(1)%></td>
                                <td><input type="text" id="int<%=rs.getString(5)%>" size="3"></td>
                                <td><input type="text" id="ext<%=rs.getString(5)%>" size="3"></td>
                                <td><select id="res<%=rs.getString(5)%>" name="result" title="Choose the Result">
                                        <option value="Pass">Pass</option>
                                        <option value="Fail">Fail</option>
                                    </select>
                                </td>
                            </tr>
                            <%  }while(rs.next());
                            }
                            rs = st.executeQuery("SELECT s.examid,s.subject_name,s.subject_id FROM semesterinfo.semester_subject_info s where semester="+sem+" and section="+section+" and batch="+batch+" and elective='YES' and examid IN (Select examid from semesterinfo.semester_elective_students where student_id='"+student_id+"')");
                             while(rs.next())
                             {%>
                             <tr>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(2)%></td>
                                <td><input type="text" id="int<%=rs.getString(1)%>" size="3" </td>
                                <td><input type="text" id="ext<%=rs.getString(1)%>" size="3"></td>
                                <td><select id="res<%=rs.getString(1)%>" name="result" title="Choose the Result">
                                        <option value="Pass">Pass</option>
                                        <option value="Fail">Fail</option>
                                    </select>
                                </td>
                            </tr>
                            <%}
                             rs = st.executeQuery("SELECT examid,subject_name,subject_id FROM semesterinfo.semester_subject_info WHERE semester < "+sem+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Pass'))");
                             while(rs.next())
                             {%>
                             <tr>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(2)%></td>
                                <td><input type="text" id="int<%=rs.getString(1)%>" size="3"</td>
                                <td><input type="text" id="ext<%=rs.getString(1)%>" size="3"></td>
                                <td><select id="res<%=rs.getString(1)%>" name="result" title="Choose the Result">
                                        <option value="Pass">Pass</option>
                                        <option value="Fail">Fail</option>
                                    </select>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                        <center><input type="button" onclick="AddResult('<%=sem%>')" value="Submit"></center>


                   <%
                        connection.close();
                        return;
                }else if(request.getParameter("action").toString().equals("add"))
                {
                int sem=Integer.parseInt(request.getParameter("semester").toString());
                int section=0,batch=0;
                ResultSet rs=st.executeQuery("select batch,section from semesterinfo.semester_students_info where student_id='"+student_id+"' and semester="+sem+"");
                if(rs.next())
                    {
                    batch=rs.getInt(1);
                    section=rs.getInt(2);
                    }
                String yoe="",moe="";
                rs=st.executeQuery("SELECT yoe,moe,examid FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='null'");
                Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement stmt=con.createStatement();
                if(rs.next())
                {
                yoe=rs.getString(1);
                moe=rs.getString(2);
                do{
                     //out.print("<br>1.)insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
                     stmt.executeUpdate("insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
                }while(rs.next());
                }
                rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info WHERE semester < "+sem+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Pass'))");
                while(rs.next()){
                    //out.print("<br>2.insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
                     stmt.executeUpdate("insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
                }
               //out.println("SELECT examid FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='YES' and examid IN (Select examid from semesterinfo.semester_elective_students where student_id='"+student_id+"')");
                rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='YES' and examid IN (Select examid from semesterinfo.semester_elective_students where student_id='"+student_id+"')");
                while(rs.next()){
                    //out.print("<br>3.insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
                     stmt.executeUpdate("insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
                }
                


		//out.print(sql);
                con.close();
                connection.close();
                return;
                }%>
                    
    <p align="right"> <input type="checkbox" onclick=" $('#left').toggle();"/>SHOW/HIDE SIDEBAR</p>
 	
            <div id="left">
                <ul>
              <%
              int semester=Integer.parseInt(session.getAttribute("semester").toString());
              for(int i=1;i<=semester;i++)
                  {%>
                  <li><a onclick="FindResult('<%=i%>')">Semester - <%=i%></a> </li>
                 <% }%>
                 <li><a onclick="OverallResult()">Overall</a> </li>
                </ul>
            </div>

		<div id="right">
		</div>

		<div style="clear:both"></div>
	
	

<%        connection.close();

  }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }

%>