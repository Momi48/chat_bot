# 🤖 Flutter Chatbot using Firebase AI (Gemini 2.5 Flash)

A simple **Flutter chatbot app** integrated with **Firebase AI Logic SDK**, **Cloud Firestore**, and a touch of humor.  
This app lets users send messages to a Gemini-powered AI and see responses in real-time.

---


## 🚀 Getting Started

Follow these steps carefully to set up and run the project.

---

### 1️⃣ Clone the Project

```bash
git clone https://github.com/yourusername/flutter_firebase_ai_chat.git
cd flutter_firebase_ai_chat
```
### 2️⃣ Configure Firebase

Set up Firebase for your project:

Go to Firebase Console

Create a new project

Add your Flutter app (Android/iOS)

Download your google-services.json file
→ Place it inside
```bash
android/app/google-services.json
```
 For iOS

 ```bash
ios/Runner/GoogleService-Info.plist
```

Install Firebase dependencies:
```bash
flutter pub add firebase_core cloud_firestore
```

Initialize Firebase in your main.dart file:
```bash
await Firebase.initializeApp();
```


### Dependecies Used 
```bash
firebase_core: 
cloud_firestore:
firebase_ai: 
```


### 3️⃣ Add Firebase AI Logic SDK

Install Firebase AI SDK:
```bash
flutter pub add firebase_ai
```

Then import it in your Dart file:
```bash
import 'package:firebase_ai/firebase_ai.dart';
```
### To use Gemini
```bash
final model = FirebaseAI.googleAI().generativeModel(
  model: 'gemini-2.5-flash-lite',
);
```
### Official SDK Docs:
Link: https://firebase.google.com/docs/vertex-ai/flutter

### 4️⃣ Run the App

Once setup is done:

```bash
flutter pub get
flutter run
```

### App Screenshots 
<img width="436" height="817" alt="image" src="https://github.com/user-attachments/assets/4f2eef78-3444-4503-9ce6-7fc2588f80e8" />
<img width="432" height="809" alt="image" src="https://github.com/user-attachments/assets/c9f6abef-819b-49ae-8618-a31b647ac2d0" />

### Notice the Weird Response 
<img width="439" height="556" alt="image" src="https://github.com/user-attachments/assets/c031fa64-f1ee-44f7-ba42-e0cc8b28d496" />


