<?php 
header ("Content-Type: text/html; charset=utf-8");
?>

<DOCTYPE html>
<html>
<body>
<head>

<link rel="stylesheet" href="css1.css" />

<style>

</style>
<!-- 
<meta charset="windows-1251" /> 
<meta charset="utf-8" />
-->
<script src="1.4.5/jquery-1.11.3.js"></script>

		<label for="search1">Мкр./улица</label>
		<input type="search" name="password" id="search11" value="" tabindex="1"/>
		
<table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>id</th>
                    <th>Naim</th>
                    <th>balance</th>
                    <th>---</th>
                </tr>
                </thead>
                <tbody id="table1">
                    <tr>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                    </tr>
	
                </tbody>
            </table>
    

	
<script>
	
	$("#data").on('click-row.bs.table', function (e, row, $element) {
		window.location = $element.data('href');
	});



function onClickVisvat(ser){
	        $.ajax({
            type: 'GET',
            url: 'clients.php',
            data: 'ser=' + ser,
            contentType: false,
            cache: false,
            processData:false,
            beforeSend: function(){

            },
            success: function(msg){
				$('#table1 tr').remove();
				
				msg.forEach(function(item,e){
					var id = item['id'];
					var naim = item['naim'];
					var balance = item['balance'];
					
					$('#table1').append('<tr><td>'+id+'</td><td><a href="clientinfo.php?id='+id+'">'+naim+'</a></td><td>'+balance+'</td><td>--</td></tr>');
			
				});
	

                //$('#fupForm').css("opacity","");
                //$(".submitBtn").removeAttr("disabled");
            }
        });
		
		
	
}
onClickVisvat('');

$("#search11").keyup(function(o){
		
					
		//$("#searchresultFrom____").html(list);	
	});
$("#search11").on('input',function(e){
		var ser = search11.value;
		onClickVisvat(ser);		
});
	</script>
	
	<!--<input type="button" class="ui-button-a" value="Вызвать" onclick="onClickVisvat()">
	-->
</body>
</html>

