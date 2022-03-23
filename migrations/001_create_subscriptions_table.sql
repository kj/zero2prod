CREATE TABLE subscriptions (
  id uuid NOT NULL,
  email text UNIQUE NOT NULL,
  name text NOT NULL,
  subscribed_at timestamp with time zone NOT NULL,
  PRIMARY KEY (id)
);
