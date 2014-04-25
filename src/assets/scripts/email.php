<?php
        $to = "steph.pythoud@bluewin.ch";
        //$to = "thierry.monney@gmail.com";
        $subject = "Contact sur piccoleau.ch";
        $data = json_decode(file_get_contents('php://input'), true);
        $message = $data['message'];
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/plain;charset=utf-8" . "\r\n";
        $headers .= "From: " . $data['name'] . '<' . $data['email'] . ">\r\n";

        mail($to, $subject, $message, $headers, "-f contact@piccoleau.ch");
?>