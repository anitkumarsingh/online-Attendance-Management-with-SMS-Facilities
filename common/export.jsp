
<%
response.reset();
//response.setContentType("session/vnd.ms-excel");
//sponse.reset();
response.setHeader("Content-type","application/vnd.ms-excel");
response.setHeader("Content-disposition","inline; filename=report.xls");
out.print(request.getParameter("data"));
%>

