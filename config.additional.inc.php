<?php

$verifyConf = [
    'verify_peer'       => false,
    'verify_peer_name'  => false,
    'verify_depth'      => 3,
    'allow_self_signed' => false,
    'cafile'            => '/etc/ssl/certs/ca-certificates.crt',
];

$config['imap_conn_options'] = [
    'ssl' => $verifyConf,
    'tls' => $verifyConf,
];
$config['smtp_conn_options'] = [
    'ssl' => $verifyConf,
    'tls' => $verifyConf,
];
