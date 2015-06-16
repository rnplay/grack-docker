# Authenticating smart HTTP git server for React Native Playground

This container runs Grack under Passenger, and assuming a few things:

* You use Rails for your site authentication
* You need to authenticate using the same user model as Rails
* You use devise and token authentication

This should allow Grack to authenticate git requests with the following format:

```
git clone https://mysecrettoken:@git.rnplay.org
```

# Running

```
docker run grack-passenger-docker -d -v /path/to/rails:/rails  -v /path/to/repos:/var/repos
```
