/* Based on: https://github.com/andryyy/mailcow/commit/d4baca7bd3ed88747c47581fbb8ddd4a575a49c3 */

DROP VIEW IF EXISTS grouped_aliases;
DROP VIEW IF EXISTS sogo_view;

CREATE VIEW grouped_aliases (dest, aliases) AS
SELECT destination, IFNULL(GROUP_CONCAT(source SEPARATOR ' '), '') AS address
FROM miab_aliases
WHERE source != destination
AND source NOT LIKE '@%'
GROUP BY destination;

CREATE VIEW sogo_view (c_uid, c_name, c_password, c_cn, mail, aliases, home) AS
SELECT email, email, PASSWORD, name, CONVERT(email USING latin1), IFNULL(ga.aliases, ''), CONCAT('$STORAGE_ROOT/mail/mailboxes/', maildir)
FROM miab_users
LEFT OUTER JOIN grouped_aliases ga ON ga.dest = miab_users.email
WHERE active=1;