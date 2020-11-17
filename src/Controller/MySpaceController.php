<?php

namespace App\Controller;

use App\Model\FavoriteManager;
use App\Model\LanguageManager;
use App\Model\PostManager;
use App\Model\UserManager;
use App\Service\FormValidator;

class MySpaceController extends AbstractController
{


    /**
     * Display My space page
     *
     * @return string
     * @throws \Twig\Error\LoaderError
     * @throws \Twig\Error\RuntimeError
     * @throws \Twig\Error\SyntaxError
     */
    public function main($user)
    {
            $theUser = new UserManager();
            $theUser = $theUser->userInfos($user);
            $languageManager = new LanguageManager();
            $languageManager = $languageManager->selectAll();
            $allMyFavorites = new PostManager();
            $allMyFavorites = $allMyFavorites->selectAllMyFavorites($user);
            $allMyPosts = new PostManager();
            $allMyPosts = $allMyPosts->selectAllMyPosts($user);
        if (($_SERVER["REQUEST_METHOD"] === "POST")) {
            $thePost = new PostManager();
            $user = $theUser['id'];
            $title = $_POST['newPostTitle'];
            $content = $_POST['newPostContent'];
            $language = $_POST['newPostLanguage'];
            $thePost->createPost($user, $title, $content, $language);
        }
        $_SESSION['userid'] = $theUser['id'];
        if (isset($_SESSION['userid'])) {
            $postManager = new PostManager();
            $likesAndDislikes = $postManager->selectAllLikesAndDislikesPerUser($_SESSION['userid']);

            $favoriteManager = new FavoriteManager();
            $favorites = $favoriteManager->selectAllFavoritePostId($_SESSION['userid']);
        } else {
            $likesAndDislikes = [];
            $favorites=[];
        }

        $_SESSION['userid'] = $theUser['id'];


        $this->twig->addGlobal('session', $_SESSION);

        return $this->twig->render('MySpace/myspacepage.html.twig', [
            'languages' => $languageManager,
            'favorites' => $allMyFavorites,
            'myposts' => $allMyPosts,
            'user' => $theUser,
            'likesAndDislikes' => $likesAndDislikes
        ]);
    }

    public function add()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $userManager = new UserManager();
            if ($newUserData = $userManager->selectOneByName($_POST['name'])) {
                $_SESSION['nameErrorAlreadyExists'] = 'Ce nom est déjà utilisé, choisis en un autre';
                $errorsQueryString = http_build_query($_SESSION);
                header('Location: /#registration?' . $errorsQueryString);
            } else {
                $newUserData = [];
                $newUserData['name'] = trim($_POST['name']);
                $newUserData['email'] = trim($_POST['email']);
                $newUserData['email'] = filter_var($newUserData['email'], FILTER_VALIDATE_EMAIL);
                $newUserData['password'] = password_hash($_POST['password'], PASSWORD_DEFAULT);
                $userManager->createUser($newUserData);
                $userData = $userManager->selectOneByName($_POST['name']);
                $_SESSION['user'] = $userData;
                header('Location: /MySpace/main/' . $userData['id']);
            }
        } else {
            header('Location: /#registration');
        }
    }
    public function check()
    {
        $userManager = new UserManager();
        $_POST['name'] = trim($_POST['name']);
        $_POST['password'] = trim($_POST['password']);
        if (empty($_POST['name'])) {
            $_SESSION['nameError'] = 'Renseignes ton nom';
            $errorsQueryString = http_build_query($_SESSION);
            header('Location: /#login?' . $errorsQueryString);
        }
        if (empty($_POST['password'])) {
            $_SESSION['passwordError'] = 'Renseignes ton mot de passe';
            $errorsQueryString = http_build_query($_SESSION);
            header('Location: /#login?' . $errorsQueryString);
        } else {
            if ($userData = $userManager->selectOneByName($_POST['name'])) {
                if (password_verify($_POST['password'], $userData['password'])) {
                    $_SESSION['user'] = $userData;
                    header('Location: /MySpace/main/' . $userData['id']);
                } else {
                    $_SESSION['passwordWrongError'] = 'Tu as dû te tromper sur de mot de passe';
                    $errorsQueryString = http_build_query($_SESSION);
                    header('Location: /#login?' . $errorsQueryString);
                }
            } else {
                $_SESSION['nameWrongError'] = 'Tu as dû te tromper de nom';
                $errorsQueryString = http_build_query($_SESSION);
                header('Location: /#login?' . $errorsQueryString);
            }
        }
    }

    public function adminAccess()
    {
        $userManager = new UserManager();
        $admins = $userManager->selectAdmins();
        if (isset($_SESSION['user'])) {
            foreach ($admins as $admin => $adminData) {
                if (($_SESSION['user']['id']) === ($adminData['id'])) {
                    return $this->twig->render('MySpace/admin.html.twig');
                }
            }
        } else {
            header('Location: /');
        }
    }


    public function logout()
    {
        session_destroy();
        session_unset();
        header('Location: /');
    }
}
