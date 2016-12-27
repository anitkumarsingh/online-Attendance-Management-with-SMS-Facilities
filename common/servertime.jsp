 

<%
        java.util.Date d=new  java.util.Date();
%>

var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
var currenttime =<%int hrs=((d.getHours()>12)?d.getHours()-12:(d.getHours()==0)?12:d.getHours());out.print("montharray["+d.getMonth()+"]+' "+d.getDate()+", "+(d.getYear()+1900)+" "+hrs+":"+d.getMinutes()+":"+d.getSeconds());%>'
var serverdate=new Date(currenttime)

function padlength(what){
var output=(what.toString().length==1)? "0"+what : what
return output
}

function displaytime(){
serverdate.setSeconds(serverdate.getSeconds()+1)
var datestring=montharray[serverdate.getMonth()]+" "+padlength(serverdate.getDate())+", "+serverdate.getFullYear()
var timestring=padlength(serverdate.getHours())+":"+padlength(serverdate.getMinutes())+":"+padlength(serverdate.getSeconds())
document.getElementById("servertime").innerHTML=datestring+" "+timestring
}


displaytime()
setInterval("displaytime()", 1000)



