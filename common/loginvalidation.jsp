<%@page import  = "java.sql.*"%>
<%@page import  = "java.util.*"%>


<%
try{
String username=request.getParameter("username");
String password=request.getParameter("password");
    System.out.println("login valid try block.");
 String CONNECTION_URL="jdbc:mysql://localhost:3306/garc2014odd";

String USER_NAME = "root";
String PASSWORD = "root";

   
//Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
//Statement st= connection.createStatement();
//Class.forName("org.gjt.mm.mysql.Driver");
Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    System.out.println("login valid.");

//Connection connection = DriverManager.getConnection(conn_string);



Statement st=connection.createStatement();
String query =  "select staff_id,user_type,DATE_FORMAT(day, '%W %d,%M %Y') ,DATE_FORMAT(day, '%r')  from staff where user_name = '"+username.replace("'", "''").replace("\\", "\\\\")+"' and pass =  '"+password.replace("'", "''").replace("\\", "\\\\")+"'";
System.out.println(query);
ResultSet rs = st.executeQuery(query);

if (rs.next())
 {
    System.out.println("rs in login"); 	
    String user_id=rs.getString(1);
    String user_type=rs.getString(2);
    session.isNew();
    session.setAttribute("userid",user_id);
    session.setAttribute("usertype",user_type);
    session.setAttribute("logintime",rs.getString(3)+" at "+rs.getString(4));
    String sql="update staff set day=now() where `staff_id`='"+session.getAttribute("userid")+"'";
    st.executeUpdate(sql);
    connection.close();
    if(user_type.equals("Admin")||user_type.equalsIgnoreCase("GARC"))
    {session.setAttribute("userid",user_id);out.print("./Admin");}
  else if(user_type.equalsIgnoreCase("Staff"))
     {out.print("./Faculty");}
  else if(user_type.equalsIgnoreCase("office"))
     {out.print("./Office");}
     else if(user_type.equalsIgnoreCase("Director"))
     {out.print("./Director");}
  else if(user_type.equalsIgnoreCase("HOD"))
     {out.print("./Hod");}
    }
    else
    {
            rs=st.executeQuery("select semester,section, DATE_FORMAT(day, '%W %d,%M %Y') ,DATE_FORMAT(day, '%r')  from students where student_id='"+username.replace("'", "''").replace("\\", "\\\\")+"' and pass='"+password.replace("'", "''").replace("\\", "\\\\")+"'");
            boolean flag=false;
            if(rs.next())flag=true;
            if(flag){
                    String sql="update students set day=now() where `student_id`='"+username+"'";
                    session.setAttribute("userid",username);
                    session.setAttribute("semester",rs.getString(1));
                    session.setAttribute("section",rs.getString(2));
                    session.setAttribute("usertype","student");
                    session.setAttribute("logintime",rs.getString(3)+" at "+rs.getString(4));
                    st.executeUpdate(sql);connection.close();
                    out.print("./Student");
             }
     else{
                connection.close();
            out.print("error");
            }

    }
 

       %>

 <%
 }catch (Exception ex) {
    out.println("error e="+ex.toString());
    }%>