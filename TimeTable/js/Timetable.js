/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Ramkumar
 * 2:18PM sept 1
 */
//

        function formatItem(row) {
		return row[0] + " (<strong>Name: " + row[1] + "</strong>)";
	}
	function formatResult(row) {
		return row[0].replace(/(<.+?>)/gi, '');
	}


  function submittable(){
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Saving...</center>");
     var semester=$("#semester").val();
     var section=$("#section").val();
     var date=$("#date").val();
     var arg="date="+date+"&action=savetable&semester="+semester+"&section="+section+"&data=";
     var url="../TimeTable/timetable.jsp";
     var count=0;
     $("#timetable input[type=text]").each(
    function(i,n) {
        if($.trim($('#'+n.id).val())!=""){
          count++;
          arg+=n.id+"-"+$('#'+n.id).val()+","
        }
      }
    );
        arg+="&count="+count;
    //alert(arg)
      $.ajax({
                type: "POST",
                url: url,
                data: arg,
                success: function(msg){
                   //alert("saved");
                   //$('#result').html(msg);
                    $('#status').html("Saved Successfully");
                    t=setTimeout("clearmsg()",3000);
                }
            });

  }
 function submitheader(){
     $('#status').show();
     $('#status').html("<center><img src='../images/loading.gif'/>Saving...</center>");
     var semester=$("#semester").val();
     var section=$("#section").val();
     var date=$("#date").val();
     var arg="&date="+date+"&action=addheader&semester="+semester+"&section="+section+"&header=";
     var url="../TimeTable/timetable.jsp";
     var count=0;
     $("#timeheader input[type=text]").each(
    function(i,n) {
        if($.trim($('#'+n.id).val())!=""){
          count++;
          arg+=$('#'+n.id).val()+","
        }
      }
    );

        arg+="&count="+count;
        //alert(arg)
        $.ajax({
                type: "POST",
                url: url,
                data: arg,
                success: function(msg){
                $.ajax({
                    type: "POST",
                    url: url,
                    data: "action=showtable&semester="+semester+"&section="+section+"&date="+date,
                    success: function(msg){
                       $('#result').html(msg);
                       $(".list").autocomplete('../TimeTable/search.jsp', {
                            width: 300,
                            multiple: false,
                            matchContains:false,
                            formatItem: formatItem,
                            formatResult: formatResult
                    });
                    $('#status').html("Saved");
                     t=setTimeout("clearmsg()",3000);
                    }
                });

                }
            });

 }
  function  loadAllDates(){
     var url="../TimeTable/timetable.jsp";
      var semester=$("#semester").val();
     var section=$("#section").val();
 $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
  $.ajax({
                type: "POST",
                url: url,
                data: "action=getalldates&semester="+semester+"&section="+section,
                success: function(msg){
                   $('#result').html(msg);
                   $('#status').html("Loaded");
                    t=setTimeout("clearmsg()",3000);
                }
            });
 }
 function  loadSemester(){
    var url="../TimeTable/timetable.jsp";
 $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
$("#right").html("<div id='option'></div><div id='result'></div>");
  $.ajax({
                type: "POST",
                url: url,
                data: "action=getsemesterinfo",
                success: function(msg){
                    $('#status').html("Loaded");
                   $('#option').html(msg);
                    $('#date').datepicker({ dateFormat: 'dd/mm/yy' });
                     t=setTimeout("clearmsg()",3000);
                }
            });
 }
 function periods(){
     var semester=$("#semester").val();
     var section=$("#section").val();
     var date=$("#date").val();
 var url="../TimeTable/timetable.jsp";
 $('#status').show();
$('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
//alert("action=period&section="+section+"&semester="+semester+"&date="+date)
  $.ajax({
                type: "POST",
                url: url,
                data: "action=period&section="+section+"&semester="+semester+"&date="+date,
                success: function(msg){
                    $('#status').html("Loaded");
                   $('#result').html(msg);
                    t=setTimeout("clearmsg()",3000);
                }
            });
 }