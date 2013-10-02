<?php

$email = $_POST['email'];
$body = $_POST['body'];

mail($email, "GeoLocation Tool Log", $body, "From: noone@none.com\r\n");

?>


