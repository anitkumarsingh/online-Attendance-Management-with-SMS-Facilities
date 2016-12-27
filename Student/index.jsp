<%-- 
    Document   : newindex
    Created on : May 22, 2010, 6:03:00 PM
    Author     : Ram
--%>
        <style type="text/css">

		.progress-bar-background {
                        -webkit-border-radius: 5px;
			background-color: white;
			width: 100%;
			position: relative;
			overflow:hidden;
			top: 0;
			left: 0;
		}

		.progress-bar-complete {
			background-color: #3399CC;
			width: 50%;
			position: relative;
			overflow:hidden;
			top: -12px;
			left: 0;
		}

		#progress-bar {

                        -webkit-border-radius: 5px;
			width: 200px;
			height: 15px;
			overflow:hidden;
			border: 1px black solid;
		}
                #floatmnu{
                position:absolute;
                border:1px dotted #FFFFFF;
                display:none;
                background-color:#4F5557;
                z-index:9999;
            }
            #floatmnu ul{
                list-style:none;
                min-width:80px;
                padding:0px;
                margin:0px;
            }
            #floatmnu ul li:hover{
                background-color:gray;
            }
            #floatmnu ul li{
                padding:5px 5px 5px 5px;
            }
            #floatmnu ul li a{
                color:white;
                font-weight:bolder;
                text-decoration:none;
            }
       #right{
        width:640px;
    }
    th{
        font-size:small;
}
td{
    font-size: small;
}
	</style>

        <script type="text/javascript" src="js/loading.js"></script>

        <title>SUWEGA- Student</title>
    </head>
    <body>

        <div align="right" style="color:gray;margin-top:10px;"><%@ include file="../common/SemesterSwich.jsp" %> </div>
        <div style="margin-top:20%;margin-left:40%">
         <div id="mainload"></div>
         <div id="progress-bar"></div>
        </div>

         </body>
</html>