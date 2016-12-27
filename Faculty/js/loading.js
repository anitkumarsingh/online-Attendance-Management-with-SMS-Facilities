/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



        var i=0;
        var div2 ;
        var waittime=0;
        function status(){
           // alert("abs");
           document.getElementById("mainload").innerHTML=((Math.round(i*100/17))+" % completed");
            div2.style.width = (i*100/17)+'%';
            if(i==17)return;
            waittime+=5;
            //if(waittime>=1000)
              //  location.reload();
            setTimeout ( "status()", 5 );
        }
function createProgressBar(elem) {
		var div1 = document.createElement('DIV');
		div1.className = 'progress-bar-background';
		div1.style.height = elem.offsetHeight + 'px';
		elem.appendChild(div1);

                div2 = document.createElement('DIV');
		div2.className = 'progress-bar-complete';
		div2.style.height = elem.offsetHeight + 'px';
		div2.style.top = '-' + elem.offsetHeight + 'px';
		elem.appendChild(div2);
	}
        var css;
        function include_css(css_file) {
            var html_doc = document.getElementsByTagName('head')[0];
            css = document.createElement('link');
            css.setAttribute('rel', 'stylesheet');
            css.setAttribute('type', 'text/css');
            css.setAttribute('href', css_file);
            html_doc.appendChild(css);
            css.onload= function () {

            }
            // alert state change
            css.onreadystatechange = function () {
               // alert(css.readyState);


            }
            return false;
        }


        var js;
        function getallscript(){

             $.getScript("../js/transform/jqtransformplugin/jquery.jqtransform.js", function(){
                                i++;
                              $.getScript("../js/jquery-ui.js", function(){
                                  i++;
                                    $.getScript("js/AssignedSubject.js", function(){
                                        i++;
                                       $.getScript("js/Assessment.js", function(){
                                            i++;
                                            $.getScript("js/CourseWork.js", function(){
                                                i++;
                                                $.getScript("js/SemesterReport.js", function(){
                                                i++;
                                                $.getScript("js/Attendance.js", function(){
                                                    i++;
                                                      $.getScript("js/Resource.js", function(){
                                                           i++;
                                                           $.getScript("js/Profile.js", function(){
                                                                i++;
                                                                //alert(i);
                                                                 $.getScript("nicEdit.js", function(){
                                                                     i++;
                                                                      $.getScript("js/Report.js", function(){
                                                                        i++;
                                                                        $.getScript("js/inbox.js", function(){
                                                                            i++;
                                                                            $.getScript("../js/jquery.ingrid.js", function(){
                                                                              i++;
                                                                              $.getScript("../js/jquery.autocomplete.pack.js", function(){
                                                                                 i++;
                                                                                    $.ajax({
                                                                                            type: "POST",
                                                                                            url: "template.jsp",
                                                                                            data:"action=list&rand="+Math.random(),
                                                                                            success: function(msg){

                                                                                                $('body').html(msg);
                                                                                                $('#left').hide();
                                                                                                $("#menu a").click(function () {

                                                                                                     $('#left').hide();
                                                                                                     $("#menu a").css("color","white");
                                                                                                     $(this).css("color", "#B0B3B4");
                                                                                                      $('#tooltip').hide();
                                                                                                });
                                                                                                 $("#sub_mnu a").click(function () {

                                                                                                     $('#left').hide();
                                                                                                     $("#sub_mnu a").css("color","green");
                                                                                                     $(this).css("color", "red");
                                                                                                     $('#tooltip').hide();
                                                                                                });
                                                                                                 $("#menu a").click(function () {
                                                                                                      if($(this).html()=="More &gt;&gt;")
                                                                                                          return;
                                                                                                     $('#left').hide();
                                                                                                     $('#tooltip').hide();
                                                                                                });
                                                                                                $("#menu a").mouseover(function () {
                                                                                                    if($(this).html()=="More &gt;&gt;")
                                                                                                          return;
                                                                                                    $("#floatmnu").slideUp();
                                                                                                    });
                                                                                                 $("#floatmnu a").click(function () {
                                                                                                     $('#tooltip').hide();
                                                                                                     $('#left').hide();
                                                                                                });


                                                                                                 $.getScript("../js/modelbox/scripts/modal-window.min.js", function(){
                                                                                                     i++;
                                                                                                    $.getScript("../common/servertime.jsp", function(){
                                                                                                        i++;
                                                                                                           $.getScript("../js/FileBrowser.js", function(){
                                                                                                               i++;
                                                                                                               welcome();
                                                                                                           });
                                                                                                    });
                                                                                                 });
                                                                                            }
                                                                                        });
                                                                                      });

                                                                                  });
                                                                               });
                                                                        });
                                                                    });
                                                                });
                                                            });
                                                        });
                                                    });
                                                 });
                                            });

                                    });
                                });
                            });
        }

function loadScript(url, callback){

    var script = document.createElement("script")
    script.type = "text/javascript";

    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" ||
                    script.readyState == "complete"){
                script.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        script.onload = function(){
            callback();
        };
    }

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
}
 window.onload = function() {
            createProgressBar(document.getElementById('progress-bar'));
            status();
            loadScript("../js/jquery.js", function(){
                getallscript();
            });
            include_css("../css/redmond/jquery-ui.css" );
            include_css("../js/transform/jqtransformplugin/jqtransform.css");
            include_css("../css/style.css");
            include_css("../css/table-style.css");
            include_css("../css/ingrid.css")
            
            include_css("../css/jquery.autocomplete.css")
            include_css("../css/FileBrowser.css")
            include_css("/js/modelbox/styles/modal-window.css")
 }
 