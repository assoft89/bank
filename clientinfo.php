<?php 
//header ("Content-Type: text/html; charset=windows-1251");
header('Content-Type: application/json; charset=utf-8');
//require('conn.php');

$ser = $_GET['id'];
if ($ser == '')
	$ser = $_POST['id'];
if ($ser == '')
	$ser = '%%';


 
require('conn.php');


	$query = "select id, balance, naim from clients where id = ?";

	$stmt = $dbh->prepare($query);
	$stmt->bindParam(1, $ser);	
	
	


	

  $stmt->execute();
  $result = $stmt->fetchAll();
  
		//$rows = array();
		//foreach ($result as $row) {
		//	$rows[] = $row;
		//}

  
  echo json_encode($result,JSON_UNESCAPED_UNICODE);
  
  $dbh = null;
  
  

?>

