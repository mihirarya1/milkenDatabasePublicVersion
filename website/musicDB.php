<html>
<head><title>Music DB</title></head>
<body>
<h1>Music Database Query Webpage</h1> 

<?php

echo nl2br("In the search box below, please enter the exact query you wish to perform on the database. \n\n");


// Connect to sql database
$db = new mysqli('dba-mysql-odb-d01.it.ucla.edu', 'music', '');
if ($db->connect_errno > 0) { 
    die('Unable to connect to database [' . $db->connect_error . ']'); 
}
$db->select_db("music");


?>


<form action="musicResult.php" method="post">
Enter MySQL Query:<br><br><input type="text" name="query" size="75" maxlength="1000" style="font-size: 18pt; height: 40px;">
<br>
<br>
<input type="submit" value="Execute">
<br>
</form>


</body>
</html>

