# 🤖 Flutter Chatbot using Firebase AI (Gemini 2.5 Flash)

A simple **Flutter chatbot app** integrated with **Firebase AI Logic SDK**, **Cloud Firestore**, and a touch of humor.  
This app lets users send messages to a Gemini-powered AI and see responses in real-time.

---
## ⚠️ Warning Before Getting Started — About Gemini 2.5 Responses 

Just a heads-up — when I was testing this project using **Gemini 2.5**,  
I started getting some **really weird responses**.

At one point, I asked “What is Flutter?” and it started replying with **molecular formulas**.  
So yeah… it might go completely off-topic and act a bit too “creative.”

Use this project for **testing, learning, or experimenting with Firebase AI SDK**,  
but not for production — unless you enjoy unexpected chemistry lessons. 

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
