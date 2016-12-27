<%@page import="java.util.Scanner,java.io.*" %>
<%
    /*
    ** Format
    ** jdbc:mysql//domainname:port/dbname;
    */
    String USER_NAME="root";
    String PASSWORD="root";
    String CONNECTION_URL="jdbc:mysql://localhost:3306/garc2014odd";
    
    File file_=new File(getServletContext().getRealPath("/")+".\\common\\dbuser.ini");
    Scanner scanner_ = new Scanner(file_);
        try {
      //first use a Scanner to get each line
      while ( scanner_.hasNextLine() ){
            Scanner _scanner = new Scanner( scanner_.nextLine());
            _scanner.useDelimiter("=");
            if ( _scanner.hasNext() ){
               USER_NAME = _scanner.next();
               PASSWORD = _scanner.next();              
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
      scanner_.close();
    }
    
    
    Class.forName ("com.mysql.jdbc.Driver");

   // out.print(CONNECTION_URL);
    /*
     *Connection polling
    */

%>