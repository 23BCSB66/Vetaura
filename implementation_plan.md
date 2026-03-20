# Vetaura System Architecture & Implementation Plan

This document outlines the architecture, technology stack, and phase-by-phase implementation strategy for the Vetaura platform.

## Proposed Architecture

1. **Frontend**: Flutter (Mobile App for Android & iOS)
2. **Backend API**: Python (FastAPI recommended for high performance, asynchronous capabilities, and clean documentation)
3. **Database**: Firebase Firestore (NoSQL document database, good for scalable data and real-time reads)
4. **Authentication**: Firebase Authentication (Handles secure sign-in, manages users)
5. **Storage**: Firebase Cloud Storage (For animal photos, NGO documentation, etc.)

> [!TIP]
> Using FastAPI for the backend provides automatic Swagger documentation and excellent performance, while Firebase handles the heavy lifting of user auth and real-time database needs.

## Module Implementation Strategy

### 1. Foundation & Authentication
- **Current State**: The UI for Login/Signup exists but currently just bypasses auth logic.
- **Action**: Integrate Firebase Auth logic into [login_screen.dart](file:///c:/Users/Mohit/Documents/Vetaura/lib/screens/login_screen.dart) and [signup_screen.dart](file:///c:/Users/Mohit/Documents/Vetaura/lib/screens/signup_screen.dart).
- **Database**: Design Firestore schema defining user roles: `Citizen`, `NGO`, `Vet`.

### 2. Rescue SOS (Emergency Module)
- **Frontend**: Add a prominent, one-tap SOS button using `geolocator` to fetch exact device coordinates.
- **Backend**: Create a Python API endpoint that receives a lat/lng pair, queries the Firebase Firestore for nearest active NGOs (using geospatial indices), and routes the emergency request to them via Firebase Cloud Messaging (FCM).

### 3. Forever Homes (Adoption Marketplace)
- **Frontend**: Build a scrollable feed/grid of animal profiles. Include tags for personality.
- **Backend/DB**: Collections in Firestore for `Animals`. Create an admin panel/interface for NGOs to review digital background checks (adoption forms).

### 4. Care Map
- **Frontend**: Integrate `google_maps_flutter` to show map interface with smart filters (NGOs, Shelters, Vets).
- **Backend**: Python endpoint to fetch verified institutions dynamically based on the user's visible map area. 

### 5. Vetaura Premium (Monetization Engine)
- **Frontend**: Premium UI tabs for booking services.
- **Payment Gateway**: Integrate Razorpay (popular in India) or Stripe.
- **Backend**: Python backend securely verifies payment signatures. Manage booking slots in Firestore to prevent double bookings.

## Verification Plan

### Automated Tests
- **Backend**: Use `pytest` to write automated tests for the Python FastAPI endpoints (e.g., verify that the geospatial matching returns the correct mock NGO).
- **Frontend**: Flutter widget tests to ensure the UI renders the modules correctly (e.g., verifying SOS button visibility).

### Manual Verification
- **App Flow Validation**: Run the Flutter app on an Android Emulator or physical device.
- **Auth Flow**: Manually log in, sign up, and test invalid credentials.
- **SOS Test**: Mock a GPS location on the emulator and trigger an SOS to verify the backend assignment logic in the Firebase Console.
- **Payments**: Use Stripe/Razorpay test cards to verify a successful premium booking transaction.
