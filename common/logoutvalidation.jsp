 
Please wait ...
<%
session.removeAttribute("staff_id");
session.removeAttribute("userid");
session.removeAttribute("dept");
session.removeAttribute("dept");
session.removeAttribute("class_incharge");
session.removeAttribute("subject_id");
session.removeAttribute("semester");
session.removeAttribute("section");
session.removeAttribute("elective");
session.removeAttribute("usertype");
response.sendRedirect("../index.jsp");
%>