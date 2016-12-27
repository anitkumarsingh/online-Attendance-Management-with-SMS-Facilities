<%-- 
    Document   : CreateSession
    Created on : Jul 30, 2009, 10:37:57 PM
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
<%

session.setAttribute("subject_id", request.getParameter("subject_id"));
session.setAttribute("elective",  request.getParameter("elective"));
session.setAttribute("section",  request.getParameter("section"));
session.setAttribute("semester",  request.getParameter("semester"));
session.setAttribute("subject_name",  request.getParameter("subject_name"));

out.print("Created");
%>