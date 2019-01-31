<?php 
//header ("Content-Type: text/html; charset=windows-1251");
header('Content-Type: application/json; charset=utf-8');
//require('conn.php');

$ser = $_GET['ser'];

if ($ser == '')
	$ser = '%%';

$ser =  '%' . $ser . '%';
 
require('conn.php');


	$query = "select id, balance, naim, 'rrrrrrrrrrrrrrrr' as ddf from clients where naim like(?)";

	$stmt = $dbh->prepare($query);
	$stmt->bindParam(1, $ser);	
	
	
  //$stmt = $con->prepare($query);
  //$stmt->bind_param($ser);	

	

  $stmt->execute();
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
  
		//$rows = array();
		//foreach ($result as $row) {
		//	$rows[] = $row;
		//}
   
  
  echo json_encode($result,JSON_UNESCAPED_UNICODE);
  
  $dbh = null;
  
  

?>

