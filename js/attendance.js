/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(function() {
		$("#date").datepicker();
	});

var xmlHttp

function display(type,hrs)
{
    document.getElementById('result').innerHTML = "<img src='../images/waiting.gif'/>please wait..."

xmlHttp=GetXmlHttpObject()
if (xmlHttp==null)
 {
 alert ("Browser does not support HTTP Request")
 return
 }
var url="../common/attendanceajax.jsp?type="+type+"&hrs="+hrs+"&date="+document.getElementById("date").value +"&rand="+Math.random();

xmlHttp.onreadystatechange=stateChanged
xmlHttp.open("GET",url,true)
xmlHttp.send(null)
}

function stateChanged()
{
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 {
 document.getElementById("result").innerHTML=xmlHttp.responseText
 }
}

function GetXmlHttpObject()
{
var xmlHttp=null;
try
 {
 // Firefox, Opera 8.0+, Safari
 xmlHttp=new XMLHttpRequest();
 }
catch (e)
 {
 //Internet Explorer
 try
  {
  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
  }
 catch (e)
  {
  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
return xmlHttp;
}








function read()
{
document.getElementById("topic").innerHTML="<img src='../images/waiting.gif'/>please wait..."
var w = document.myform.select.selectedIndex;
var url="../common/loadtopic.jsp?read=yes&unit="+(w+1)+"&rand="+Math.random()
$('#topic').load(url)

}

var xmlHttpCheck

function check(x,sec,sem,elective,staff,sub)
{
var date=document.getElementById("date").value
if(date=="")
{
document.getElementById('hrs').value=""
alert ("Date is Empty")
return
}
xmlHttpCheck=GetXmlHttpObject()
document.getElementById('chk').innerHTML="<img src='../images/waiting.gif'/>please wait..."
var y=document.getElementById(x).value;
var url="../common/duplicate.jsp?semester="+sem+"&hrs="+y+"&sec="+sec+"&date="+date+"&elective="+elective+"&staff_id="+staff+"&subject_id="+sub+"&rand="+Math.random()
xmlHttpCheck.onreadystatechange=stateCheck
xmlHttpCheck.open("GET",url,true)
xmlHttpCheck.send(null)

}
function stateCheck()
{
if (xmlHttpCheck.readyState==4 || xmlHttpCheck.readyState=="complete")
 {
 document.getElementById("chk").innerHTML=xmlHttpCheck.responseText
 }
}


var xmlHttpEdit

function checkEdit(sec,sem,elective,staff,sub)
{
var date=document.getElementById("date").value
if(date=="")
{
document.getElementById('hrs').value=""
alert ("Date is Empty")
return
}
xmlHttpEdit=GetXmlHttpObject()
document.getElementById('chk').innerHTML="<img src='../images/waiting.gif'/>please wait..."
var y=document.getElementById("hrs").value;
var url="../common/duplicate.jsp?semester="+sem+"&hrs="+y+"&sec="+sec+"&date="+date+"&elective=X&staff_id="+staff+"&subject_id="+sub+"&rand="+Math.random()
xmlHttpEdit.onreadystatechange=stateEdit
xmlHttpEdit.open("GET",url,true)
xmlHttpEdit.send(null)

}
function stateEdit()
{
if (xmlHttpEdit.readyState==4 || xmlHttpEdit.readyState=="complete")
 {
 document.getElementById("chk").innerHTML=xmlHttpEdit.responseText
 }
}




function validate()
            {



                var value=document.getElementById("date").value
                if(value=="")
                {
                    alert ("Date is Empty")
                    return
                }
                var value=document.getElementById("hrs").value

                if(value=="")
                {
                    alert("Hour Box Should not be Empty")
                }
				var value=document.getElementById("chk").innerHTML
                 if((value=="Available"));
                 else{
                  alert("Please check the Input")
                  return
              }
                //alert("test")
                document.myform.submit()

            }

              function readtable(option)
            {
                var value=document.getElementById("hrs").value
                display(option,value);
            }

            function xtra_oper(option)
            {
                var value=document.getElementById("date").value
                if(value=="")
                {
                    alert ("Date is Empty")
                    return
                }
		    if(option=="delete")
		    {
			   /*if(!confirm("Are u sure want to DELETE ?"))
				return;*/
                     $('#dialog').dialog('open');
					return false;
            }
                display(option,value);
            }
             function empty()
            {
                document.getElementById('hrs').value=''
            }
        function selects(x)
        {

            if(document.getElementById(x).value=='A')
                document.getElementById(x).value=''
            else
                document.getElementById(x).value='A'

        }
        function InvertSelect()
        {
            for(i=1;i<=document.getElementById('count').innerHTML;i++)
                selects(i)
        }
        function add(){
             var w = document.myform.desc.selectedIndex;
            var selected_desc = document.myform.desc.options[w].text;
            if(selected_desc=="Select Topic"){
                alert("select the Topic")
                return
            }
            validate()
        }
