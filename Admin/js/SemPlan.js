

 $(function(){
       $('#tabs').tabs();
       $('#status').html("<center><img src='../images/loading.gif'/>Loading...</center>");
       $('table').jqTransform({imgPath:'jqtransformplugin/img/'});
       $('#status').hide();
  });