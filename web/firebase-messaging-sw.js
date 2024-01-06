importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDW17txVZK6rztMZDkUbxdKm2dPg1RysCI",
  authDomain: "ikict-f49f6.firebaseapp.com",
  databaseURL: "https://ikict-f49f6-default-rtdb.firebaseio.com",
  projectId: "ikict-f49f6",
  storageBucket: "ikict-f49f6.appspot.com",
  messagingSenderId: "753383357173",
  appId: "1:753383357173:web:611c991c7dc7eb479fe3bc",
  measurementId: "G-2PD5H6E2C2"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});