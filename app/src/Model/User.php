<?php

use SilverStripe\ORM\DataObject;

class User extends DataObject {
    private static $db = [
        "Name" => 'Varchar',
        "Secret" => 'Text',
        "Password" => 'Text'
    ];
}
