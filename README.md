# phone_auth_demo

A new Flutter project that implements Firebase Phone Auth to log the user in.
If the user already exists, HomeScreen will be displayed.
Else if the user is new, Sign up process will start in which the user gives his name and email. This name and email are saved in FirbaseAuth "User" DB and also in the Firestore under 'users' collection. 
Next, the user has to select a city after which HomeScreen gets displayed with the products available in that city.

## Faults :

The user gets logged out on restart.
Haven't implemented the else-if blocks correctly which leads to wrong states when phoneNumber, smsCode verification and smsCodeAutoRetrieval times out.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# phone_auth_using_bloc


https://user-images.githubusercontent.com/85786622/182884190-ba66cb52-a5df-4233-aa43-a9fbf08daa2b.mp4

