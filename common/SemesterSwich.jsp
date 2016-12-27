 
<%@page import="java.io.*,java.util.Scanner"  %>
<select id="switchsemester" onChange="window.location='?cursemester='+this.value">

<%
File _file=new File(getServletContext().getRealPath("/")+".\\common\\config.ini");
Scanner scanner = new Scanner(_file);
String final_db="";
    try {
      //first use a Scanner to get each line
      while ( scanner.hasNextLine() ){
            Scanner _scanner = new Scanner( scanner.nextLine());
            _scanner.useDelimiter("=");
            if ( _scanner.hasNext() ){
              String name = _scanner.next();
              String alias = _scanner.next();
              %>
              <option <%=(name.trim().equals(session.getAttribute("DB_Name")))?"selected":""%> value='<%=name.trim()%>'><%= alias.trim()%></option>
              <%
              final_db=name.trim();
              
            }
            else {
              log("Empty or invalid line. Unable to process.");
            }
            //(no need for finally here, since String is source)
            _scanner.close();

      }
    }
    finally {
      //ensure the underlying stream is always closed
      scanner.close();
    }
    if(session.getAttribute("DB_Name")==null)
        session.setAttribute("DB_Name", final_db);
%>
</select>
