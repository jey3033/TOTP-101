<?php

use OTPHP\TOTP;

class UserController extends PageController {
    private static $allowed_actions = [
        'createOTP', 'verifyOTP'
    ];

    public function index() {
        return $this->renderWith(['Login', 'Page']);
    }
    
    public function createOTP() {
        $dataUser = User::get()->where("Name = '{$_POST['email']}'")->first();
        if ($dataUser) {
            $OTP = TOTP::create($dataUser->Secret);
            $OTP->setLabel('Test 1');
            $ID = $dataUser->ID;
        }else{
            $OTP = TOTP::create();
            $User = User::create();
            $User->Name = $_POST['email'];
            $User->Secret = $OTP->getSecret();
            $ID = $User->write();
            $OTP->setLabel('Test 1');
        }

        $grCodeUri = $OTP->getQrCodeUri('https://api.qrserver.com/v1/create-qr-code/?data=[DATA]&size=300x300&ecc=M',
        '[DATA]');

        return json_encode([
            'ID' => $ID,
            'uri' => $grCodeUri
        ]);
    }

    public function verifyOTP() {
        $dataUser = User::get()->byID($_POST['user_id']);
        $OTP = TOTP::create($dataUser->Secret);
        if ($OTP->verify($_POST['verification'])) {
            return 200;
        } else {
            return 400;
        }
    }
}