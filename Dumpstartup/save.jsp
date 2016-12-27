<%-- 
    Document   : save
    Created on : Nov 8, 2009, 7:30:26 PM
    Author     : Ramkumar
--%>
<%@page import="java.sql.*,java.io.*" %>

<%
try{
    String CollegeName=request.getParameter("college");
    String Dept=request.getParameter("dept");
    String alias=request.getParameter("alias");
    String DURATION=request.getParameter("course");
    String SECTION=request.getParameter("section");
    String UNIT=request.getParameter("unit");
    String PERIOD=request.getParameter("period");
    String YEAR=request.getParameter("year");
    String SEMESTER=request.getParameter("semester");
    
    String username=request.getParameter("username");
    String password=request.getParameter("password");
    
    String adminuser=request.getParameter("adminusername");
    String adminpass=request.getParameter("adminpassword");
    
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/",username,password);
    Statement st=connection.createStatement();
    try{
    String sql="create database garc"+YEAR+SEMESTER;
    st.executeUpdate(sql);
    
    sql="use garc"+YEAR+SEMESTER;
    st.executeUpdate(sql);
    
   
    
    sql="CREATE TABLE  `article` (  `staff_id` int(10) unsigned NOT NULL,  `filename` varchar(45) NOT NULL,  `date` varchar(45) NOT NULL,  `title` varchar(45) NOT NULL, `desc` varchar(45) NOT NULL,  PRIMARY KEY (`staff_id`,`filename`));";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `assessment_master` (  `examid` int(10) unsigned NOT NULL AUTO_INCREMENT,  `subject_id` varchar(8) NOT NULL,  `examname` varchar(75) NOT NULL,  `examdate` varchar(12) NOT NULL DEFAULT '1111-11-11',  `section` int(2) unsigned NOT NULL,  `weightage` int(3) unsigned NOT NULL,  `max_marks` int(3) unsigned NOT NULL,  `staff_id` int(10) unsigned DEFAULT NULL,  PRIMARY KEY (`examid`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE IF NOT EXISTS `assign_staff` (  `staff_id` int(10) unsigned NOT NULL,  `semester` varchar(1) NOT NULL,  `section` varchar(1) NOT NULL DEFAULT '',  `subject_id` varchar(8) NOT NULL) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `attendance` (  `student_id` varchar(15) NOT NULL,  `subject_id` varchar(8) NOT NULL,  `staff_id` int(10) unsigned NOT NULL,  `hour` varchar(15) NOT NULL DEFAULT '',  `date` date NOT NULL,  `ab_type` varchar(1) NOT NULL,  `semester` varchar(3) DEFAULT NULL,  `section` varchar(1) DEFAULT NULL,  `topic` int(10) unsigned NOT NULL,  PRIMARY KEY (`hour`,`date`,`student_id`,`subject_id`) USING BTREE,  KEY `FK_attendance_1` (`staff_id`),  KEY `FK_attendance_3` (`subject_id`),  KEY `FK_attendance_2` (`student_id`) USING BTREE) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `classincharge` (  `staff_id` int(10) unsigned NOT NULL,  `section` int(10) unsigned NOT NULL,  `semester` int(10) unsigned NOT NULL,  PRIMARY KEY (`staff_id`,`section`,`semester`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE `coursecoverage` (  `staff_id` varchar(10) NOT NULL,  `data` blob NOT NULL,  `subject_id` varchar(10) NOT NULL,  `sec` varchar(1) NOT NULL,  `sem` varchar(3) NOT NULL,  PRIMARY KEY (`staff_id`,`subject_id`,`sec`)) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `courseoutline` (  `staff_id` varchar(10) NOT NULL,  `data` blob NOT NULL,  `subject_id` varchar(10) NOT NULL,  `sec` varchar(1) NOT NULL,  `sem` varchar(3) NOT NULL,  PRIMARY KEY (`staff_id`,`subject_id`,`sec`)) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `course_planner` (  `subject_id` varchar(10) NOT NULL DEFAULT '',  `category` varchar(8) NOT NULL,  `topic` blob NOT NULL,  `planned_hrs` int(2) unsigned NOT NULL,  `section` varchar(1) NOT NULL,  `sno` int(10) unsigned NOT NULL AUTO_INCREMENT,  PRIMARY KEY (`sno`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE IF NOT EXISTS `elective_students` (  `student_id` varchar(15) NOT NULL,  `subject_id` varchar(8) NOT NULL,  PRIMARY KEY (`student_id`,`subject_id`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `electives` (  `subject_id` varchar(8) NOT NULL DEFAULT '',  `semester` varchar(1) NOT NULL DEFAULT '',  `subject_name` varchar(50) NOT NULL DEFAULT '',  PRIMARY KEY (`subject_id`)) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `mail` (  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,  `sender_id` varchar(45) NOT NULL,  `subject` varchar(45) NOT NULL,  `to` varchar(45) NOT NULL,  `msg` longblob NOT NULL,  `timestamp` varchar(45) NOT NULL,  `attachment` varchar(45) NOT NULL,  `status` varchar(45) NOT NULL DEFAULT 'UNREAD',  PRIMARY KEY (`id`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `marks` (  `student_id` varchar(15) NOT NULL,  `examid` varchar(30) NOT NULL,  `mark` varchar(30) NOT NULL,  PRIMARY KEY (`student_id`,`examid`) USING BTREE) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE `misc` (  `type` varchar(45) NOT NULL,  `value` varchar(100) NOT NULL) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `newsupdate` (  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,  `data` blob NOT NULL,  `date` datetime NOT NULL,  PRIMARY KEY (`id`)) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `questionbank` (  `semester` varchar(1) NOT NULL,  `filename` varchar(255) NOT NULL,  PRIMARY KEY  (`semester`,`filename`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `resource` (  `staff_id` int(10) unsigned NOT NULL,  `subject_id` varchar(45) NOT NULL,  `section` varchar(45) NOT NULL,  `semester` varchar(45) NOT NULL,  `filename` varchar(255) NOT NULL,  `date` varchar(45) NOT NULL,  `title` varchar(255) NOT NULL,  `desc` varchar(255) NOT NULL,  `category` varchar(45) NOT NULL,  `folder` varchar(45) NOT NULL) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `restricted_user` (  `user_id` varchar(30) NOT NULL,  `semester` varchar(1) NOT NULL,  PRIMARY KEY  (`user_id`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `section` (  `sectioncount` int(1) unsigned NOT NULL,  `periodcount` int(1) unsigned DEFAULT NULL,  `timing` varchar(200) DEFAULT NULL,  `year` varchar(3) NOT NULL,  `semester` varchar(3) NOT NULL,  `no_of_electives` varchar(1) DEFAULT NULL,  `grade` varchar(4) DEFAULT NULL,  PRIMARY KEY (`year`) USING BTREE) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `staff` (  `staff_id` int(10) unsigned NOT NULL AUTO_INCREMENT,  `staff_name` varchar(50) DEFAULT NULL,  `user_name` varchar(10) DEFAULT NULL,  `pass` varchar(15) DEFAULT NULL,  `qualification` varchar(25) DEFAULT NULL,  `day` datetime DEFAULT NULL,  `user_type` varchar(15) DEFAULT NULL,  `designation` varchar(45) DEFAULT NULL,  `subjects_handled` varchar(150) DEFAULT NULL,  `mailid` varchar(45) DEFAULT NULL,  `phone_number` varchar(13) DEFAULT NULL,  `specialization` varchar(150) DEFAULT NULL,  `about_u` varchar(45) DEFAULT NULL,  `priority` int(11) DEFAULT NULL,  `title` varchar(5) DEFAULT NULL,  PRIMARY KEY (`staff_id`)) ";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `staff_permissions` (  `staff_id` int(10) unsigned NOT NULL,  `report` int(10) unsigned NOT NULL,  PRIMARY KEY  (`staff_id`,`report`))";
    st.executeUpdate(sql);

    sql="CREATE TABLE  `students` (  `student_id` varchar(12) NOT NULL,  `student_name` varchar(45) NOT NULL,  `semester` int(10) unsigned NOT NULL,  `section` int(10) unsigned NOT NULL,  `pass` varchar(45) NOT NULL,  `batch` int(10) unsigned NOT NULL,  `sslc` varchar(5) DEFAULT NULL,  `hsc` varchar(5) DEFAULT NULL,  `ug` varchar(5) DEFAULT NULL,  `phone` varchar(13) DEFAULT NULL,  `email` varchar(50) DEFAULT NULL,  `address` blob,  `day` datetime DEFAULT NULL,  `uguniversity` varchar(45) DEFAULT NULL,  `ugcourse` varchar(45) DEFAULT NULL,  PRIMARY KEY (`student_id`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `subject` (  `subject_id` varchar(8) NOT NULL DEFAULT '',  `subject_name` varchar(100) NOT NULL,  `semester` varchar(1) DEFAULT NULL,  `elective` varchar(4) DEFAULT NULL,  `lab` varchar(4) DEFAULT NULL,  PRIMARY KEY (`subject_id`))";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `timetable_data` (  `day` int(2) unsigned NOT NULL,  `header_id` int(2) unsigned NOT NULL,  `data` varchar(45) NOT NULL,  `section` int(1) unsigned NOT NULL,  `semester` int(1) unsigned NOT NULL,  `date` date NOT NULL,  PRIMARY KEY (`day`,`section`,`semester`,`header_id`) USING BTREE)";
    st.executeUpdate(sql);
    
    sql="CREATE TABLE  `timetable_header` (  `semester` int(2) unsigned NOT NULL AUTO_INCREMENT,  `section` int(2) unsigned NOT NULL,  `header` varchar(45) NOT NULL,  `index` int(2) unsigned NOT NULL,  `count` int(2) unsigned NOT NULL,  `date` date NOT NULL,  PRIMARY KEY (`semester`,`section`,`index`)) ";
    st.executeUpdate(sql);
    
    sql="insert into misc values('hit_count',0)";
    st.executeUpdate(sql);
    
    sql="insert into misc values('college','"+CollegeName+"')";
    st.executeUpdate(sql);
    
    sql="insert into misc values('dept','"+Dept+"')";
    st.executeUpdate(sql);
    
    sql="insert into misc values('no_of_section','"+SECTION+"')";
    st.executeUpdate(sql);
    
    sql="insert into misc values('course_duration','"+DURATION+"')";
    st.executeUpdate(sql);
    
    sql="insert into misc values('max_unit',"+UNIT+")";
    st.executeUpdate(sql);
    
    sql="insert into misc values('max_period',"+PERIOD+")";
    st.executeUpdate(sql);
    
    sql="insert into staff (staff_name,user_name,pass,user_type) values('Root','"+adminuser+"','"+adminpass+"','Admin')";    
    st.executeUpdate(sql);
    
    // Create file 

    FileWriter fstream = new FileWriter(getServletContext().getRealPath("/")+".\\common\\config.ini",false);
        BufferedWriter appand = new BufferedWriter(fstream);

    appand.write("garc"+YEAR+SEMESTER);

    if(request.getParameter("alias").toString().equals(""))
        appand.write("="+"garc"+YEAR+SEMESTER);
    else
        appand.write("="+alias);
    appand.newLine();
    //Close the output stream
    appand.close();
    
    // Create file 

    FileWriter fstream_user = new FileWriter(getServletContext().getRealPath("/")+".\\common\\dbuser.ini",false);
        BufferedWriter appand_user = new BufferedWriter(fstream_user);

    appand_user.write(username+"="+password);
    appand_user.newLine();
    //Close the output stream
    appand_user.close();
    }catch (Exception e){//Catch exception if any
      System.err.println("Error: " + e.getMessage());
      return;
    }

    connection.close();
    
%>

<h4>Finish</h4>


<p>Congratulations! SUWEGA! is now installed.Click the Site button to view your ! Web site and the Admin login to take you to your administrator web page.</p>

<p>Please delete the startup folder before you use</p>
<p align="right"><input type="button" value="Go to My Site" onclick="javascript:window.location='/index.jsp'"/></p>

<%}
catch(Exception e){
    %>
    <h3>Oops! Installation Failed</h3>
    <p>The following error occur while installation</p>
    <p><%=e.toString()%></p>
<%
    }
%>