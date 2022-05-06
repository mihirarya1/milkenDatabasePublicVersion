<html>
<head><title>Music DB</title></head>
<body>
<h1>Music Database Query Results</h1> 


<?php

$db = new mysqli('dba-mysql-odb-d01.it.ucla.edu', 'music', '');
if ($db->connect_errno > 0) {
    die('Unable to connect to database [' . $db->connect_error . ']');
}
$db->select_db("music");

$query = $_POST["query"];

$queryStatement = $db->prepare($query);
$execResults = $queryStatement->execute();
if ( $execResults==false ) {
  die('Error in query execution: ' . htmlspecialchars($queryStatement->error));
}

$result = $queryStatement->get_result();

?>

<p style="font-size: 18pt; height: 40px;"><?php echo "Results for the query '".$query."' are:" ?></p>

<?php

echo nl2br("<table border='2'><tr>");
$colNames = $result->fetch_fields();

$imageDisplay=-1;

for ($x=0; $x < sizeof($colNames) ; $x++) {
    $tmp = $colNames[$x];		    
    if ($tmp->name=="localFilePath")
	{ $imageDisplay=$x; }
    echo nl2br("\t<th>$tmp->name</th>");
}

echo nl2br("\n</tr>");

while ($row = mysqli_fetch_row($result))
{
  echo "\n<tr>";

    for ($y=0; $y < sizeof($row) ; $y++) {
    if ($y==$imageDisplay)
         { echo "<td><a href = '$row[$y]'> \n\t $row[$y] </a><br /></td>"; }		  
       else
         { echo "\n\t<td> $row[$y] </td>"; }
    }

		
  echo "\n</tr>";  
}
echo "\n</table>\n";


$db->close();

?>

</body>
</html>
