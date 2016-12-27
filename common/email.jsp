 
<%@ page  import="java.util.Properties,javax.mail.Message,javax.mail.MessagingException,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeMessage" %>
<%@ include file="mailConfig.jsp" %>
<%
    String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
    String to = "president@XYZ.info"; // out going email id
    String from = user; //Email id of the recipient
    String subject = "Newsletter SUWEGA";
    String messageText = "<b>Ass hole</b>";
    boolean sessionDebug = true;
    boolean WasEmailSent=true;
    Properties props = System.getProperties();
    props.setProperty("mail.transport.protocol", "smtp");
    props.setProperty("mail.host", host);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", "465");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class",
    "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.socketFactory.fallback", "false");
    props.setProperty("mail.smtp.com", "false");
    Session mailSession = Session.getDefaultInstance(props, null);
    mailSession.setDebug(sessionDebug);
    Message msg = new MimeMessage(mailSession);
    msg.setFrom(new InternetAddress(from));
    InternetAddress[] address = {new InternetAddress(to)};
    msg.setRecipients(Message.RecipientType.TO, address);
    msg.setSubject(subject);
    msg.setContent(messageText, "text/html"); // use setText if you want to send text
    Transport transport = mailSession.getTransport("smtp");
    transport.connect(host, user, pass);
    try {
    transport.sendMessage(msg, msg.getAllRecipients());
    WasEmailSent = true; // assume it was sent
    }
    catch (Exception err) {
    WasEmailSent = false; // assume it's a fail
    }
    transport.close();
    out.print(WasEmailSent);

%>