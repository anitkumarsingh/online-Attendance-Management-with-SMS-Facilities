 
<%@page import="java.sql.*"  %>
<%@ include file="../common/DBConfig.jsp" %>
<%@ include file="../common/FlashPaperConfig.jsp" %>
 <%!
            public boolean isContains(String arr[],String key){
                if(key.equals(""))
                    return false;
                for(int i=0;i<arr.length-1;i++)
                    if(arr[i].equalsIgnoreCase(key))
                       return true;

                return false;
            }
        %>
<%
 if((session.getAttribute("DB_Name")==null)){
        %>
        <script>

            window.location="./";
        </script>
        <%
        return;
    }
     Connection con=DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
     Statement st=con.createStatement();
     String sql="select a.staff_id,s.staff_name,a.title,a.desc,a.filename,year(a.date) year,a.date from article a,staff s where a.staff_id=s.staff_id order by date";
     ResultSet rs=st.executeQuery(sql);
%>
  <div id="top_div">
      <%
        if(!rs.next()){
            out.print("<h1><center>No Article Published!</center></h1>");
            con.close();
            return;
        }
      %>
    <h1>Article</h1>
    <div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">
        <div class="scrollTableContainer">

        <table class="dataTable" cellspacing="0" >
            <thead>
           
            <tr>
                <th>ArticleTitle</th>
                <th>Faculty</th>
                <th>Year</th>
                <th> </th>
            </tr>
        </thead>
        <tbody>
    <%
        do{
           
            %>
            <tr>
                <td><%=rs.getString("title")%></td>
                <td><%=rs.getString("staff_name")%></td>
                <td><%=rs.getString("year")%></td>
                <td>
                     <ul class="action">

                             <li onclick="window.location='./common/fileDownload.jsp?filename=<%=rs.getString("staff_id")+"/"+rs.getString("filename")+"&type=ARTICLE"%>'"  style="background:url('./images/download.png')  no-repeat ;padding-left:20px;cursor:hand;">&nbsp;</li>
                             <%
                             int mid= rs.getString("filename").lastIndexOf(".");
                              String ext=rs.getString("filename").substring(mid+1,rs.getString("filename").length());

                                if(FLASH_PAPER && isContains(FLASH_PAPER_SUPPORTS,ext)){%>
                             <li onclick="window.open('./common/fileViewer.jsp?filename=<%=rs.getString("staff_id")+"/"+rs.getString("filename")+"&type=ARTICLE"%>')" style="background:url('./images/view.png')  no-repeat ;padding-left:20px;cursor:hand">&nbsp;</li>
                             <%}%>

                         </ul>
                </td>
            </tr>
            <%
            
        }while(rs.next());
    %>
</tbody>
        </table>
    </div>
    </div>
  </div>
<div style="clear:both"></div>
   