/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



        var i=0;
        var div2 ;
        var waittime=0;
        function status(){
           // alert("abs");
           document.getElementById("mainload").innerHTML=((Math.round(i*100/9))+" % completed");
            div2.style.width = (i*100/9)+'%';
            if(i==9)return;
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

             $.getScript("js/home.js", function(){
                                i++;
                              $.getScript("../js/jquery-ui.js", function(){
                                  i++;
                                    $.getScript("js/Result.js", function(){
                                        i++;
                                       $.getScript("js/curriculam.js", function(){
                                            i++;
                                            $.getScript("js/changeProfile.js", function(){
                                                i++;
                                                $.getScript("../js/dropshadow.js", function(){
                                                i++;

                                                $.getScript("../js/jquery.ingrid.js", function(){
                                                  i++;
                                                  $.getScript("../js/jquery.autocomplete.pack.js", function(){
                                                     i++;
                                                     $.getScript("/js/garcEssentials.js", function(){
                                                     i++;
                                                        $.ajax({
                                                                type: "POST",
                                                                url: "template.jsp",
                                                                data:"action=list&rand="+Math.random(),
                                                                success: function(msg){

                                                                    $('body').html(msg);
                                                                     $('#status').hide();
                                                                    $('#floatmnu ul li').click(function(){
                                                                        $('#floatmnu').slideToggle();
                                                                    });
                                                                    $('body').focus(function(){
                                                                        $('#floatmnu').slideToggle();
                                                                    });
                                                                    $("#menu a").click(function () {
                                                                         $('#left').hide();
                                                                         $("#menu a").css("color","white");
                                                                         $(this).css("color", "#B0B3B4");
                                                                    });


                                                                     $.getScript("../js/modelbox/scripts/modal-window.min.js", function(){
                                                                         i++;
                                                                        $.getScript("../common/servertime.jsp", function(){
                                                                            i++;
                                                                               $.getScript("../js/FileBrowser.js", function(){
                                                                                   i++;
                                                                                    home();
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
                       
            include_css("../css/style.css");
            include_css("../css/table-style.css");
            include_css("../css/ingrid.css")
            include_css("../css/jquery.autocomplete.css")
            include_css("../css/FileBrowser.css")
            include_css("/js/modelbox/styles/modal-window.css")
 }

         function showmymenu(obj){
            $('#floatmnu').slideToggle();
            var pos = $(obj).position();
            var top= pos.top+25;
            $('#floatmnu').css("left", pos.left)
            var top= pos.top+25;
            $('#floatmnu').css("top", top)
        }
        function home(){
            $('#status').show();
            $('#status').html("<center><img src='../images/loading.gif'/>Loading ...</center>");
            $.ajax({
                        type: "POST",
                        url: "./AjaxPages/home.jsp",
                        data:"action=none&rand="+Math.random(),
                        success: function(msg){
                                $('#status').html("<center>Loaded Successful</center>");
                                $('#curriculam').html(msg);
                                $("#curriculam").show();
                                $("#report").hide();
                                smartColumns(200,250);
                                loadhome();
                                loadinboxcount();
                                loadAttendance();
                                loadNews();
                                loadSoftware();
                                t=setTimeout("clearmsg()",3000);
                                }
            });
            }
