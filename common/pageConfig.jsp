
<%@page import="java.sql.*,java.util.Scanner,java.io.*"  %>

<%
/*
if(request.getParameter("cursemester")!=null)
   session.setAttribute("DB_Name", request.getParameter("cursemester"));
System.out.println("1111111");
 //   session.setAttribute("DB_Name", "garc2014odd"));
    System.out.println(session.getAttribute("DB_Name")+"page config one" +request.getParameter("cursemester"));

if(session.getAttribute("DB_Name")==null || session.getAttribute("DB_Name").equals("")){
        System.out.println("page config2");
File _file=new File(getServletContext().getRealPath("/")+".\\common\\config.ini");
System.out.println("page config3");
Scanner scanner = new Scanner(_file);
System.out.println("page config4");
String final_db="";
    try {
    System.out.println("page config1111111111111111"+final_db);
      //first use a Scanner to get each line
          while ( scanner.hasNextLine() ){
                Scanner _scanner = new Scanner( scanner.nextLine());
                _scanner.useDelimiter("=");
                if ( _scanner.hasNext() ){
                  final_db = _scanner.next();
                  _scanner.next();
                  System.out.println("page config1111111111111111"+final_db);
                  session.setAttribute("DB_Name", final_db);
                   }
                else {
                System.out.println("Empty or invalid line. Unable to process.");
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
        
    }
    String USER_NAME="";
    String PASSWORD="";
   // String CONNECTION_URL="jdbc:mysql://localhost:3306/"+session.getAttribute("DB_Name");
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
    */
         
         String CONNECTION_URL="jdbc:mysql://localhost:3306/garc2014odd";
         
String USER_NAME = "root";
String PASSWORD = "root";
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection _connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement _st=_connection.createStatement();

    ResultSet _rs=_st.executeQuery("select * from misc");
    _rs.next();

    _rs.next();

    final String college=_rs.getString(2);

    _rs.next();
    final String dept=_rs.getString(2);

    _rs.next();

    final int NO_OF_SECTIONS=_rs.getInt(2);
    _rs.next();

    final int NO_OF_YEARS=_rs.getInt(2);
    _rs.next();

    final int NO_OF_UNITS=_rs.getInt(2);
    _rs.next();

    final int MAX_NO_OF_PERIODS=_rs.getInt(2);/* MAX NO OF HOUR =9*/
    


    
    String[] exam_months={"Mar/Apr","Nov/Dec"};
    String[] GRADE_LETTER={"S","A","B","C","D","E","U","W","I",};
    int[] GRADE_POINT={10,9,8,7,6,5,0,0,0};
    
    String[] STAFF_DESIGNATION={"Professor","Asst. Professor","S.G. Lecturer","Sr. Lecturer","Lecturer","Guest Lecturer","Office Assitant","Library Assistant","Lab Assistant"};
    int[] STAFF_PRIORITY={1,2,3,4,5,6,7,8,9};
    
    
%>