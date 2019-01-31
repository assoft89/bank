<?php 
header ("Content-Type: text/html; charset=utf-8");
?>

<DOCTYPE html>
<html>
<body>
<head>

<script src="1.4.5/jquery-1.11.3.js"></script>
</head>




<!-- Тип кодирования данных, enctype, ДОЛЖЕН БЫТЬ указан ИМЕННО так -->
<form enctype="multipart/form-data" action="uploadFile.php?pp=1" method="POST" >
    <!-- Поле MAX_FILE_SIZE должно быть указано до поля загрузки файла -->
    <input type="hidden" name="MAX_FILE_SIZE" value="30000" />
    <!-- Название элемента input определяет имя в массиве $_FILES -->
    Отправить этот файл: <input name="userfile" type="file" />
    <input type="submit" value="Отправить файл" />
</form>

<p class="statusMsg"></p>
<form enctype="multipart/form-data" id="fupForm"  >
    <div class="form-group">
        <label for="name">NAME</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required />
    </div>
    <div class="form-group">
      <label for="email">EMAIL</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required />
    </div>
    <div class="form-group">
        <label for="file">File</label>
        <input type="file" class="form-control" id="file" name="file" required />
    </div>
    <input type="submit" name="submit" class="btn btn-danger submitBtn" value="SAVE"/>
</form>


<script>
$(document).ready(function(e){
	$('#fupForm').hide();
	
    $("#fupForm").on('submit', function(e){
        e.preventDefault();
        $.ajax({
            type: 'POST',
            url: 'uploadFile.php',
            data: new FormData(this),
            contentType: false,
            cache: false,
            processData:false,
            beforeSend: function(){
                $('.submitBtn').attr("disabled","disabled");
                $('#fupForm').css("opacity",".5");
            },
            success: function(msg){
                $('.statusMsg').html('');
                if(msg == 'ok'){
                    $('#fupForm')[0].reset();
                    $('.statusMsg').html('<span style="font-size:18px;color:#34A853">Form data submitted successfully.</span>');
                }else{
                    $('.statusMsg').html('<span style="font-size:18px;color:#EA4335">Some problem occurred, please try again.</span>');
                }
                $('#fupForm').css("opacity","");
                $(".submitBtn").removeAttr("disabled");
            }
        });
    });
    
    //file type validation
    $("#file").change(function() {
        var file = this.files[0];
        var imagefile = file.type;
        var match= ["image/jpeg","text/plain",];
        if(!((imagefile==match[0]) || (imagefile==match[1]) || (imagefile==match[2]))){
            alert('Please select a valid image file (JPEG/JPG/PNG).');
            $("#file").val('');
            return false;
        }
    });
});
</script>

</body>
</html>

<?php

require('conn.php');



$ftmp = $_FILES['userfile']['tmp_name'];

if ($ftmp == '')
	exit;

echo $ftmp . '<br>';

$row = 1;
$handle = fopen($ftmp, "r");

$first = fgetcsv($handle, 0, "	");



$cntFindedRow = 0;

while (($data = fgetcsv($handle, 0, "	")) !== FALSE) {
    $num = count($data);
	
    //echo "<p> $num полей в строке $row: <br /></p>\n";
    $row++;
	
	
	

		for ($c=0; $c < $num; $c++) { //перебор всех полей в строке

					//$data[$c] = mb_convert_encoding($data[c], "utf-8", "windows-1251");
			
			
				//echo $c . ' ( ' . $first[$c] . ' ) ====' .$data[$c] . "<br />\n";
		}

		
	$plat_vid = 		$data[41];//41 ( Операции по счету: Вид платежа ) ====электронно
	$plat_dataspis = 	$data[46];//46 ( Операции по счету: Дата списания со счета плательщика
	$plat_innkorr = 	$data[47];//47 ( Операции по счету: ИНН корреспондента ) ====891302134629
	$plat_naznachplat = $data[53];//53 ( Операции по счету: Назначение платежа )
	$plat_naimkorr = 	$data[54];//54 ( Операции по счету: Наименование корреспондента )
	$plat_nomerdocSMFR = $data[57];//57 ( Операции по счету: Номер документа в СМФР ) 
	$plat_nomerrasdoc = $data[59];//59 ( Операции по счету: Номер расчетного документа ) 
	$plat_summaplatpokred = $data[77];//77 ( Операции по счету: Сумма платежа по кредиту ) 
	$plat_unicalidplat = $data[79];//79 ( Операции по счету: Уникальный Идентификатор Платежа ) 
	

	if ($plat_vid !==''){	
		$cntFindedRow++;
		
		

	
	
	
		$pr=[
			  $plat_vid
			  ,$plat_dataspis
			  ,$plat_innkorr
			  ,$plat_naznachplat
			  ,$plat_naimkorr
			  ,$plat_nomerdocSMFR
			  ,$plat_nomerrasdoc
			  ,$plat_summaplatpokred
			  ,$plat_unicalidplat,
			  
			];

			$stmt = $dbh->prepare("INSERT IGNORE  INTO payments (
				plat_vid 
				,plat_dataspis
				,plat_innkorr
			  ,plat_naznachplat
			  ,plat_naimkorr
			  ,plat_nomerdocSMFR
			  ,plat_nomerrasdoc
			  ,plat_summaplatpokred
			  ,plat_unicalidplat) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			

			
			foreach ($pr as $key => &$val) {	
					$val = mb_convert_encoding($val, "utf-8", "windows-1251");
	
					
				$stmt->bindParam($key+1, $val);			
			}
			
			$stmt->execute();
			$textout = $plat_naimkorr . ' summa= ' . $plat_summaplatpokred . 'data= ' . $plat_dataspis . '<br>';
			echo mb_convert_encoding($textout, "utf-8", "windows-1251"); 

	}

	
    }
	

	
$dbh = null;
fclose($handle);

echo 'FINISH cnt finded = ' . $cntFindedRow;
?>

