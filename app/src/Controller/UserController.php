<?php

class UserController extends PageController {
    public function index() {
        return $this->renderWith(['Login', 'Page']);
    }
}