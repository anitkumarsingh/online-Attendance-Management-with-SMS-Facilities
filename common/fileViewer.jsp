 
<%!
            public boolean isContains(String arr[],String key){
                if(key.equals(""))
                    return true;
                for(int i=0;i<arr.length-1;i++)
                    if(arr[i].equalsIgnoreCase(key))
                       return true;

                return false;
            }
        %>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@ include file="FlashPaperConfig.jsp" %>
<%@ include file="../common/pageConfig.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style>
    #Search_box{
        font-size:medium;
    }
</style>
</head>
<body style="width:600px;margin:auto">
    <div id="banner">
	<div id="logo">
			<div class="logo1">SUWEGA</div>
			<div class="logo2">Resource Center</div>

		</div>
	<div id="Search_box"><center><%=college%></center></div>
    <div id="servertime" align="right"></div>
	</div>
<%
String file_name = URLDecoder.decode(request.getParameter("filename"));
String path="";
String BROWSER_SUPPORT[]={"GIF","TIFF","JPG","BMP","PNG","TIF","JPEG"};
if(request.getParameter("type").equals("RESOURCE"))
    path=RESOURCE_UPLOAD;
if(request.getParameter("type").equals("ARTICLE"))
    path=ARTICLE_UPLOAD;
if(request.getParameter("type").equals("MYDOCUMENT"))
    path=MYDOCUMENT;

String file =config.getServletContext().getRealPath("/")+"uploadedFiles/"+path+"/"+ file_name+".swf";
boolean exists = (new File(file)).exists();
    if (exists) {
        file ="../uploadedFiles/"+path+"/"+ file_name+".swf";
        %>
        <div style="float:left;"">
        <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="800" height="500" title="FLASH LOGO">
        <param name="movie" value="<%=file%>">
        <param name="quality" value="high"><param name="SCALE" value="noborder">
        <embed src="<%=file%>" width="800" height="500" scale="noborder" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="session/x-shockwave-flash"></embed>
      </object>
      </div>
        <div style="float:left;padding-top:20px;">
     
          <ul style="list-style:none">
              <li style="background:url('../images/download48x48.png')  no-repeat;padding-left: 40px;height:40px;cursor:default" onclick="window.location='../common/fileDownload.jsp?filename=<%=request.getParameter("filename")%>&type=<%=request.getParameter("type")%>'" >Download</li>
              <li style="background:url('../images/delete48x48.png')  no-repeat;padding-left: 40px;height:40px;cursor:default" onclick="window.close();">Close</li>
          </ul>
      </div>
        
     
        <%
    }

    else {
        file=config.getServletContext().getRealPath("/")+"uploadedFiles/"+path+"/"+ file_name;
        int mid= file_name.lastIndexOf(".");
        String ext=file_name.substring(mid+1,file_name.length());
        if(isContains(BROWSER_SUPPORT,ext)){
            %>
             <div style="float:left;">
                 <img src="<%="../uploadedFiles/"+path+"/"+ file_name%>"/>
             </div>
              <div style="float:left;padding-top:20px;">

              <ul style="list-style:none">
                  <li style="background:url('../images/download48x48.png')  no-repeat;padding-left: 40px;height:40px;cursor:default" onclick="window.location='../common/fileDownload.jsp?filename=<%=request.getParameter("filename")%>&type=<%=request.getParameter("type")%>'" >Download</li>
                  <li style="background:url('../images/delete48x48.png')  no-repeat;padding-left: 40px;height:40px;cursor:default" onclick="window.close();">Close</li>
              </ul>
          </div>
            <%
        }
        else if(FLASH_PAPER && isContains(FLASH_PAPER_SUPPORTS,ext)){
            out.print("Trying to Convert");
            String ConvertQuery=FLASH_PAPER_EXE+" "+file+" -o "+file+".swf";
            Runtime r=Runtime.getRuntime();
            Process p=null;
            p=r.exec(ConvertQuery);
            p.waitFor();
            exists = (new File(file)).exists();
            if (exists) {
                file ="../uploadedFiles/"+path+"/"+ file_name+".swf";
            %>
            <div style="float:left;">
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="800" height="500" title="FLASH LOGO">
            <param name="movie" value="<%=file%>">
            <param name="quality" value="high"><param name="SCALE" value="noborder">
            <embed src="<%=file%>" width="800" height="500" scale="noborder" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="session/x-shockwave-flash"></embed>
          </object>
          </div>
            <div style="float:left;padding-top:20px;">

              <ul style="list-style:none">
                  <li style="background:url('../images/download48x48.png')  no-repeat;padding-left: 40px;height:40px;cursor:default" onclick="window.location='../common/fileDownload.jsp?filename=<%=request.getParameter("filename")%>&type=<%=request.getParameter("type")%>'" >Download</li>
                  <li style="background:url('../images/delete48x48.png')  no-repeat;padding-left: 40px;height:40px;cursor:default" onclick="window.close();">Close</li>
              </ul>
          </div>


            <%
        } else {out.print("Failed to Convert the file");//out.print(ConvertQuery);
        }
           }
        // File or directory does not exist
    }

%>

</body>
</html>