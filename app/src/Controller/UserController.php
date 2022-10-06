<?php

use OTPHP\TOTP;

class UserController extends PageController {
    private static $allowed_actions = [
        'createOTP'
    ];

    public function index() {
        return $this->renderWith(['Login', 'Page']);
    }
    
    public function createOTP() {
        $OTP = TOTP::create();
        $User = User::create();
        $User->Name = $_POST['email'];
        $User->Secret = $OTP->getSecret();
        $User->Password = $OTP->now();
        $OTP->setLabel('Test 1');

        $grCodeUri = $OTP->getQrCodeUri('https://api.qrserver.com/v1/create-qr-code/?data=[DATA]&size=300x300&ecc=M',
        '[DATA]');

        return $grCodeUri;
    }
}