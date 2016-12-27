
 $(document).ready( function() {
        $('#tabs').show();
        $('#right').css('width', '98%');
            $.getScript("../common/servertime.jsp", function(){
     });
 });
 function encodeMyHtml(url) {
                encodedHtml = escape(url);
                encodedHtml = encodedHtml.replace(/\//g,"%2F");
                encodedHtml = encodedHtml.replace(/\?/g,"%3F");
                encodedHtml = encodedHtml.replace(/=/g,"%3D");
                encodedHtml = encodedHtml.replace(/&/g,"%26");
                encodedHtml = encodedHtml.replace(/@/g,"%40");
                encodedHtml = encodedHtml.replace(/\+/g,"%2B");
                return encodedHtml;
}
(function($){
   $.validate = function(elem){
       $("#"+elem+" .error").remove();
     var flag=true;
     $("#"+elem+" .required").each(
    function(i,n) {
         $("#"+n.id).css("color","black");
        if(n.id!="none" || n.id!=undefined){
            //alert($("#"+n.id).val()+"--"+n.id)
            if($.trim($("#"+n.id).val())=='' || $.trim($("#"+n.id).val())=='selectone'){
                flag=false;
               $("#"+n.id).css("color","red");
               if( $.trim($("#"+n.id).val())=='selectone')
                    $("#"+n.id).parent().append("<span style='padding-left:160px;' class='error'>*</span>");
                else
                    $("#"+n.id).parent().append("<span style='padding-left:15px;' class='error'>*</span>");
                $("#"+n.id).focus();
        }
        }
      }
    );
        if(!flag)
            $('#'+elem).append("<div class='error'>*Required</div>")
    return flag;
   }
})(jQuery);