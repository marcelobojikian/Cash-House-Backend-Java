INSERT INTO OAUTH_CLIENT_DETAILS (
	CLIENT_ID, 
	CLIENT_SECRET,
	SCOPE, 
	AUTHORIZED_GRANT_TYPES,
    WEB_SERVER_REDIRECT_URI, AUTHORITIES, ACCESS_TOKEN_VALIDITY, REFRESH_TOKEN_VALIDITY, ADDITIONAL_INFORMATION, AUTOAPPROVE)
VALUES (
	'cueva', 
	'{bcrypt}$2a$10$a.jUkhyX88ouqg4pNZk.ZOXRfjAlEDhwcyl35SifJzt6dKOH9tuAy', 
	'read,write',
	'password,authorization_code,refresh_token',
	null, null, 36000, 36000, null, true);