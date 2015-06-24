The following is a rough sketch of the API I would like to expose.
The intent is to expose some sort of User and Auth service, so that
others may use it without having to have intimate knowledge of how
to set up such a thing.

# Creating users

POST /api/:app/users {
  // Either an email or a username must be provided. If only
  // a username is provided, then the user will not be able
  // to recover their password should they lose it.
  "email": "hi@drwrf.com",
  "username": "drwrf",

  // Passwords are sent in the clear, over HTTPS
  "password": "hunter42"
}

# Retrieving a user

GET /api/:app/users/:id => {
  "id": 1,
  "email": "hi@drwrf.com",
  "username": "hi@drwrf.com",
  "is-verified": true,
  "is-deleted": false,
  "is-recoverable": true,
  "created-at": "2015-06-21T18:24:18+00:00",
  "updated-at": "2015-06-21T18:24:18+00:00",
  "last-login": null,
}
