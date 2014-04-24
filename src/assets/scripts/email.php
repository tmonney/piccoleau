<?php
 $to = "steph.pythoud@bluewin.ch";
 $subject = "Contact sur piccoleau.ch";
 $message = $_POST['message'];
 $headers = "MIME-Version: 1.0" . "\r\n";
 $headers .= "Content-type:text/plain;charset=utf-8" . "\r\n";
 $headers .= "From: " . $_POST['name'] . '<' . $_POST['email']  ">\r\n";

 mail($to, $subject, $message, $headers);
?>
