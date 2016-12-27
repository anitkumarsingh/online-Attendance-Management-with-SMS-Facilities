 
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@ include file="FlashPaperConfig.jsp" %>
<%
String file_name = URLDecoder.decode(request.getParameter("filename"));
String path="";
if(request.getParameter("type").equals("RESOURCE"))
    path=RESOURCE_UPLOAD;
if(request.getParameter("type").equals("QB"))
    path=QUESTIONBANK;
if(request.getParameter("type").equals("ARTICLE"))
    path=ARTICLE_UPLOAD;
if(request.getParameter("type").equals("EMAIL"))
    path=MAIL_UPLOAD;
String file =config.getServletContext().getRealPath("/")+"uploadedFiles/"+path+"/"+ file_name;
if(request.getParameter("type").equals("MYDOCUMENT"))
    file=file_name;
out.println(file);
File f = new File(file);
if(f.exists()){

	int filesize = (int)f.length();
	byte buff[] = new byte[2048];
	int bytesRead;

	try {
		response.setContentType("session/x-msdownload");
		response.setHeader("Content-Disposition","attachment; filename=\""+file_name+"\"");
		FileInputStream fin = new java.io.FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fin);
		ServletOutputStream fout = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(fout);

		while((bytesRead = bis.read(buff)) != -1) {
			  bos.write(buff, 0, bytesRead);
		  }
		bos.flush();

		fin.close();
		fout.close();
		bis.close();
		bos.close();

	} catch( IOException e){
		response.setContentType("text/html");
		out.println("Error : "+e.getMessage());
	}
} else {
	response.setContentType("text/html");
	out.println("The Requested file is not found");
}
%>
