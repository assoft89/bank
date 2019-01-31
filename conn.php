<?php
//header ("Content-Type: text/html; charset=utf-8");
//echo $_FILES['userfile']['name'];

try {
   $dbh = new PDO('mysql:host=localhost;dbname=bank', 'root', '');
     //echo "Connected\n";
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  

   
} catch (PDOException $e) {
   print "Error!: " . $e->getMessage() . "<br/>";
   die();
}

?>

