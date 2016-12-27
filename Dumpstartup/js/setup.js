
 $(document).ready( function() {
    $('#status').hide();
 });
 function loadDetail(){
    $('#status').show();
    url="/startup/Details.jsp"
     $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
     $.ajax({
            type: "POST",
            url: url,
            success: function(msg){
                   $('#top_div').html(msg);
                   $('#status').html("Loaded");
                    t=setTimeout("clearmsg()",3000);
            }
     });
 }
 function clearmsg(){
    $('.status').hide();
    clearTimeout(t);
}
function save(){
    //alert("ji")
    $('#status').show();
    var arg="";
    url="/startup/save.jsp";
     $("input[type=text]").each(
        function(i,n) {

              arg+=this.id+"="+$(this).val()+"&";
          }
    );
    $("select").each(
        function(i,n) {

              arg+=this.id+"="+$(this).val()+"&";
          }
    );
    arg+="password="+$('#password').val();
    arg+="&adminpassword="+$('#adminpassword').val();
   //document.write(arg);
    //return;
     $('#status').html("<center><img src='../images/loading.gif'/>This May Take Long Time ...</center>");
     $.ajax({
            type: "POST",
            url: url,
            data:arg,
            success: function(msg){
                   $('#top_div').html(msg);
                   $('#status').html("Created");
                    t=setTimeout("clearmsg()",3000);
            }
     });
}