
$(document).ready(function () {
     $('#status').hide();
     $('#right table').jqTransform({imgPath:'jqtransformplugin/img/'});

 });
 var t
function clearmsg(){
 $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
 $('#status').hide();
     clearTimeout(t);
}

  function loadElective(year){

      $('#status').show();
        url="./AjaxPages/ShowElectiveStudent.jsp"
         $('#status').html("<center><img src='../images/loading.gif'/>Retriving Student</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"semester="+year*2+"&action=showelectivesubject",
                success: function(msg){
                       $('#status').html("<b>Loaded</b>");
                       $('#elective').html(msg)
                       $('#elective elective').jqTransform({imgPath:'jqtransformplugin/img/'});
                      t=setTimeout("clearmsg()",3000);
                }
            });
 }
  function loadElectiveStudents(id){
//alert($('#year').val());
      $('#status').show();
        url="./AjaxPages/ShowElectiveStudent.jsp"
         $('#status').html("<center><img src='../images/loading.gif'/>Retriving Student</center>");
         $.ajax({
                type: "POST",
                url: url,
                data:"semester="+$('#year').val()*2+"&subject_id="+id+"&action=showallstudent",
                success: function(msg){
                       $('#status').html("<b>Loaded</b>");
                       $('#selected').html(msg)
                      t=setTimeout("clearmsg()",3000);
                }
            });
 }
 function acceptStudent(student_id){
     $("#"+student_id).attr('checked', true);
     addStudent();
 }
 function disableAll(){
    $("input[type='checkbox']").attr('checked', true);
    addStudent();
}
 function addStudent(){
         if($.validate('right')==false)
            return;
      $('#status').show();
       var url="./AjaxPages/ShowElectiveStudent.jsp"
         $('#status').html("<center><img src='../images/loading.gif'/>Retriving Student</center>");
         var arg="action=addelectivestudent&subject_id="+encodeMyHtml($('#subject_id').val())+"&student_id=";
          $("input:checked").each(
    function(i,n) {
        if(n.id!="none"){
          arg=arg+$("#"+n.id).val()+'#';
        }
      }
    );


         $.ajax({
                type: "POST",
                url: url,
                data:arg,
                success: function(msg){
                       $('#status').html("<b>Loaded</b>");
                       $('#selected').html(msg)
                      loadElectiveStudents($('#subject_id').val());
                }
            });
 }