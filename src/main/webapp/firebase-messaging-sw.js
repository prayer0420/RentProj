importScripts("https://www.gstatic.com/firebasejs/11.6.0/firebase-app-compat.js");
// eslint-disable-next-line no-undef
importScripts("https://www.gstatic.com/firebasejs/11.6.0/firebase-messaging-compat.js");

const firebaseConfig = {
  apiKey: "AIzaSyA5LKk4IXgwG57Z495sfLcHg1XA0ILokTU",
  authDomain: "test-6b1b7.firebaseapp.com",
  projectId: "test-6b1b7",
  storageBucket: "test-6b1b7.firebasestorage.app",
  messagingSenderId: "1066743702766",
  appId: "1:1066743702766:web:e765caafcc8ff1b7817fff",
  measurementId: "G-YTCKLHYEX2"
};

if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
    console.log("Received background message ", payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    // eslint-disable-next-line no-restricted-globals
    self.registration.showNotification(
        notificationTitle,
        notificationOptions
    );
});