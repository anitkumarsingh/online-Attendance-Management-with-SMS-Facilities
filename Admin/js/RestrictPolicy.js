

 $(function(){
                // Tabs
                $('#tabs').tabs();
                 $('#status').hide();
                 loadFaculty();
        });
function clearmsg(){
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
    clearTimeout(t);
}
function loadStudent(year){
      $('#status').show();
        url="./AjaxPages/ShowRestrictPolicy.jsp"
         $('#status').html("<center><img src='../images/loading.gif'/>Retriving Student</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"semester="+year*2+"&action=showallstudent",
                success: function(msg){
                       $('#status').html("<b>Loaded</b>");
                       $('#student').html(msg)
                      t=setTimeout("clearmsg()",3000);
                }
            });
 }
function loadFaculty(){
      $('#status').show();
        url="./AjaxPages/ShowRestrictPolicy.jsp"
         $('#status').html("<center><img src='../images/loading.gif'/>Retriving Faculty List</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"action=showallfaculty",
                success: function(msg){
                       $('#status').html("<b>Loaded</b>");
                       $('#faculty').html(msg)
                      t=setTimeout("clearmsg()",3000);
                }
            });
 }
function disableSelected(type){
    var arg="selected=";
    var url="./AjaxPages/ShowRestrictPolicy.jsp"
    $("input:checked").each(
    function(i,n) {
        //alert(n.id);
        if(n.id!="none"){
          arg=arg+$("#"+n.id).val()+'#';
        }
      }
    );
   alert("action=UpdateSelected&type="+type+"&semester="+($('#year').val()*2)+"&"+arg);
    $.ajax({
                type: "POST",
                url: url,
                data:"action=UpdateSelected&type="+type+"&semester="+($('#year').val()*2)+"&"+arg,
                success: function(msg){
                    //alert(msg)
                       $('#status').html("<b>Updated</b>");
                       if(type=='student')
                            loadStudent($('#year').val());
                       else
                            loadFaculty();
                      //t=setTimeout("clearmsg()",3000);
                }
            });
}
function disableAll(type){
    $("input[type='checkbox']").attr('checked', true);
    disableSelected(type);
}
function accept(id,type){
    //alert(id);
    $("#"+id).attr('checked', true);
    disableSelected(type);
}
