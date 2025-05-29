import { initializeApp } from "https://www.gstatic.com/firebasejs/11.6.0/firebase-app.js";
import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/11.6.0/firebase-messaging.js";

// Firebase config
const firebaseConfig = {
  apiKey: "AIzaSyA5LKk4IXgwG57Z495sfLcHg1XA0ILokTU",
  authDomain: "test-6b1b7.firebaseapp.com",
  projectId: "test-6b1b7",
  storageBucket: "test-6b1b7.firebasestorage.app",
  messagingSenderId: "1066743702766",
  appId: "1:1066743702766:web:e765caafcc8ff1b7817fff",
  measurementId: "G-YTCKLHYEX2"
};

initializeApp(firebaseConfig);

const messaging = getMessaging();
console.log(messaging); 

export const requestForToken = () => {
  return getToken(messaging, {
    vapidKey: "BKf2ZnmnAxGrBS6VogRScPinuISeM-n_I7Dn4k-4uSZ7FxAjeJCFxg7tJMFfZ0HvlKCeH4qv85F8L7r4rdweVT8"})
    .then((currentToken) => {
      if (currentToken) {
        console.log(currentToken);
        fetch(`http://localhost:8080/fcm/fcmToken?fcmToken=${currentToken}`)
        .then(result =>{
			console.log(result);
		});
      } else {
        console.log("No registration token available. Request permission to generate one.");
      }
    })
    .catch((err) => {
      console.log("Error:", err);
    });
};

export const onMessageListener = () =>
  new Promise((resolve) => {
    onMessage(messaging, (payload) => {
      /*console.log("OnMessage Payload", payload);*/
      resolve(payload);
    });
  });

requestForToken();
onMessageListener();
