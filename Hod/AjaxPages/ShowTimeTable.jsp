<%-- 
    Document   : ShowTimeTable
    Created on : Jan 19, 2009, 1:43:45 AM
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
<%@ include file="../../common/pageConfig.jsp" %>
<%@page import="java.sql.*"  %>
<%
  try{
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        String sql="select sectioncount,year,semester from section";
        //out.print(sql);
        ResultSet rs=st.executeQuery(sql);
        %>
        Year: 
        <select id="semester" onchange="gettimetable()">
            <%while(rs.next()){%>
            <option value="<%=rs.getInt("semester")%>"><%=rs.getInt("year")%></option>
            <%}%>
        </select>
        Section: 
        <select id="section" onchange="gettimetable()">
            <%  for(int i=1;i<=NO_OF_SECTIONS;i++){
                %>
            <option value="<%=i%>"><%=(char)('A'+i-1)%></option>
                <%}%>
        </select>
        <div id="timetable"></div>
        <%
        connection.close();
     }
  catch(Exception e){
      
  }
%>
    
