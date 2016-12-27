/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var semester;
var section;
var batch;

function SemesterReport(){
url="AjaxPages/ViewSemesterReport.jsp";
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=showBatch&rand="+Math.random(),
                success: function(msg){
                        $('#left').show();
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#Batch1').html(msg)
                        $('#right').html("")
                         $("#Batch").dynatree({
                          fx: { height: "toggle", duration: 200 },
                          autoCollapse: true,
                          onActivate: function(dtnode) {
                            $("#echoActive").text(dtnode.data.title);
                          },
                          onDeactivate: function(dtnode) {
                            $("#echoActive").text("-");
                          }
                        });
                       $("#HistoryReport").dynatree({
                          fx: { height: "toggle", duration: 200 },
                          autoCollapse: true,
                          onActivate: function(dtnode) {
                            $("#echoActive").text(dtnode.data.title);
                          },
                          onDeactivate: function(dtnode) {
                            $("#echoActive").text("-");
                          }
                        });
                        t=setTimeout("clearmsg()",3000);
                   }
 });
}
function ReportGetSection(bat,sem){
url="AjaxPages/ViewSemesterReport.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=showSection&semester="+sem+"&batch="+bat,
                success: function(msg){
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#subSection').html(msg)
                        $("#Section").dynatree({
                          fx: { height: "toggle", duration: 200 },
                          autoCollapse: true,
                          onActivate: function(dtnode) {
                            $("#echoActive").text(dtnode.data.title);
                          },
                          onDeactivate: function(dtnode) {
                            $("#echoActive").text("-");
                          }
                        });
                        $("#Report").dynatree({
                          fx: { height: "toggle", duration: 200 },
                          autoCollapse: true,
                          onActivate: function(dtnode) {
                            $("#echoActive").text(dtnode.data.title);
                          },
                          onDeactivate: function(dtnode) {
                            $("#echoActive").text("-");
                          }
                        });
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function HistoryReport(subj_id,subj_name){
url="AjaxPages/ViewSemesterReport.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=showHistoryReport&subj_id="+subj_id+"&subject_name="+subj_name,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#reportSheet').html(msg)
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}


function SemesterClassReport(){
url="AjaxPages/ViewSemesterReport.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=showclassreport&semester="+semester+"&batch="+batch+"&section="+section,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#reportSheet').html(msg)
                        t=setTimeout("clearmsg()",3000);
                       }
 });
}


function SemesterSubjectReport(){
url="AjaxPages/ViewSemesterReport.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=showsubjectreport&semester="+semester+"&batch="+batch+"&section="+section,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#reportSheet').html(msg);
                       t=setTimeout("clearmsg()",3000);
                        }
 });
}

function OverallReport(){
url="AjaxPages/ViewSemesterReport.jsp"
$('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$.ajax({
                type: "POST",
                url: url,
                data:"action=overallreport&semester="+semester+"&batch="+batch+"&section="+section,
                success: function(msg){
                        //alert(msg+"hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        $('#reportSheet').html(msg);
                        t=setTimeout("clearmsg()",3000);
                        }
 });
}

function SelectSection(sem,bat,sec){
semester=sem;
batch=bat;
section=sec;
}
