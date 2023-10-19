SELECT
    repository_name,
    owner_username,
    stars_count,
    forks_count,
    created_at,
    last_pushed_at
FROM
    github_repositories
WHERE
    language = 'SQL'
    AND stars_count >= 1000
ORDER BY
    stars_count DESC;