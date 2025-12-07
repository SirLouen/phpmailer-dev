<?php

require __DIR__ . '/PHPMailer/src/Exception.php';
require __DIR__ . '/PHPMailer/src/PHPMailer.php';
require __DIR__ . '/PHPMailer/src/SMTP.php';
require __DIR__ . '/testbootstrap.php';


$to = "test@example.com";
$from = "sender@example.com";
$subject = "Test Email";
$body = "This is a test email sent using PHPMailer.";

$mail = new PHPMailer\PHPMailer\PHPMailer();
$mail->isSMTP();
$mail->Host = $_REQUEST['mail_host'];
$mail->Port = $_REQUEST['mail_port'];
$mail->setFrom($from);
$mail->addAddress($to);
$mail->Subject = $subject;

$mail->Body = $body;
if ($mail->send()) {
    echo "Email sent successfully to $to\n";
} else {
    echo "Failed to send email. Error: " . $mail->ErrorInfo . "\n";
}
