<?php


namespace App\Model;


class PostManager extends AbstractManager
{
    const TABLE = 'post';

    /**
     *  Initializes this class.
     */
    public function __construct()
    {
        parent::__construct(self::TABLE);
    }

    public function selectAllWithLanguage(): array
    {
        return $this->pdo->query('SELECT *, post.id as post_unique_id, (post.like - post. dislike) as popularity FROM ' . $this->table . ' LEFT JOIN language ON post.language_id = language.id;')->fetchAll();
    }

    public function selectPostsOrderedBy($orderedBy): array
    {
        return $this->pdo->query('SELECT *, post.id as post_unique_id, (post.like - post. dislike) as popularity FROM ' . $this->table . ' LEFT JOIN language ON post.language_id = language.id ORDER BY ' . $orderedBy . ' DESC;')->fetchAll();
    }

    public function postByLanguage($id): array
    {
        return $this->pdo->query('SELECT *, post.id as post_unique_id,(post.like - post. dislike) as popularity FROM ' . $this->table . ' LEFT JOIN language ON post.language_id = language.id WHERE language.id=' . $id . ';')->fetchAll();
    }



}