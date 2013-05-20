<?php
$payload = '{
     "aps" : { "alert" : "You are an amazing mom! Your first baby book is done! Save $15 when you order it today!"},
     "type" : "2"}';
$deviceToken = "2b0b1fdb064f522e51877bcf772fa5e53519cb19a9ba1b56c014c621e939d965";

$apnsHost = 'gateway.sandbox.push.apple.com';
$apnsPort = 2195;
$apnsCert = 'certs/babyappdev-cert.pem';

$streamContext = stream_context_create();
stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);

$apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);

$apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '', $deviceToken)) . chr(0) . chr(strlen($payload)) . $payload;
fwrite($apns, $apnsMessage);

@socket_close($apns);
fclose($apns);

?>