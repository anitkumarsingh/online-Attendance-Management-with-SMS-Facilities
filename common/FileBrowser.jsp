 
<%@page import="java.io.*"  %>
<%@ include file="../common/FlashPaperConfig.jsp" %>
<%
            String ROOT=config.getServletContext().getRealPath("/")+"uploadedFiles\\"+MYDOCUMENT+"\\"+session.getAttribute("userid");
            String CUR_PATH="";
            if(!request.getParameter("folder").equals("none"))
                CUR_PATH=request.getParameter("folder");
            else
                CUR_PATH=ROOT;
            new File(CUR_PATH).mkdirs();
            File dir = new File(CUR_PATH);
            CUR_PATH=dir.getCanonicalPath()+"\\";
            out.print("<b>Current Folder</b> <span class='currentFolder'>"+dir.getCanonicalPath().replace(ROOT, ".")+"</span>");

            String[] children = dir.list();
            if (children == null) {
                // Either dir does not exist or is not a directory
                 out.print("<span class='currentFolder'>Unknown Folder: "+CUR_PATH+"</span>");

                 return;
            } else {
                for (int i=0; i<children.length; i++) {
                    // Get filename of file or directory
                    File temp=new File(CUR_PATH+children[i]);
                    if(temp.isDirectory())
                        children[i]="<span class='afolder' title='"+temp.getCanonicalPath()+"\\'>"+children[i].toLowerCase()+"</span>";
                    else
                         children[i]="<span class='file' title='"+temp.getCanonicalPath()+"'>"+children[i].toLowerCase()+"</span>";
                }
            }
            java.util.Arrays.sort(children);
            if(new File(CUR_PATH).compareTo(new File(ROOT))!=0)
                out.print("<span class='afolder' title='"+CUR_PATH+"..\\"+"'>< Back</span>");
            for(int i=0;i<children.length;i++)
                out.print(children[i]);
        %>