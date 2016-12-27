/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Ramkumar @4 51 on sept 30
 */
function loadSoftware(){
    $.ajax({
            type: "POST",
            url: "/common/getSwFolder.jsp",
            success: function(msg){
                browse($.trim(msg));
            }
    });
}
function browse(folder){
    
   /*var pos = $("#list").position();
     $('#overlay').css("height",$('#list').css("height") )
   $('#overlay').css("left",pos.left);
    $('#overlay').css("top",pos.top);
    $('#overlay').css("width",$('#list').css("width"));*/
    $('#status').show();
    $("#status").html("Loading");
     $.ajax({
           type: "POST",
           url: "../common/FileBrowser.jsp",
           data: "folder="+folder,
           success: function(msg){
               //alert(msg)
               $('#status').fadeOut(100);
               $("#list").html( msg );
                $(".file").click(function () {
                    $('#span_file').html($(this).html())
                    $('#file').val($(this).attr("title"));
                    //alert(folder)
                });
                $(".afolder").click(function () {
                    $('#directory').val($(this).attr("title"));
                    browse($(this).attr("title"));
                    $('#span_dir').html($(this).html())
                });
                
           }
         });
}


