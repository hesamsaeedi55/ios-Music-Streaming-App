import * as functions from 'firebase-functions'


exports.testFunction = functions.https.onCall((data,context) => {
    console.log("hi the test function worked");
    return "hi the test function worked";
})

