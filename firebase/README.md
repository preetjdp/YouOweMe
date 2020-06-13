# You Owe Me Firebase

This contains the Firebase configuration used to run YouOweMe.
Most importantly the Firebase Serverless Functions.

### Add Environment Variable to Firebase Functions

```bash
firebase functions:config:set someservice.key="THE API KEY" someservice.id="THE CLIENT ID"
```

### Check for Environment Variables

```bash
firebase functions:config:get
```

### Remove Environment Variables

```bash
firebase functions:config:unset key1 key2
```

### Take Backup of Firestore Data

```bash
$timestamp = Get-Date -Format "HH-mm MM-dd-yyyy"
gcloud firestore export gs://yom-backup/$timestamp
```

References

- https://medium.com/@BrodaNoel/how-to-backup-firebase-firestore-8be94a66138c

### Copy backup to localDisk

```bash
gsutil cp -r gs://yom-backup .
```

### Run Firebase Emulator With This Data

```bash
firebase emulators:start --import ./data/
```

### Start Firebase-UI with the project

Make sure you're in the firebase-ui folder

```bash
$env:GCLOUD_PROJECT="youoweme-6c622"
$env:FIREBASE_EMULATOR_HUB="localhost:4400"
npm start
```

### Environment Varables Structure

```json
{
  "secret": {
    "web_api_key": "WEB_API_KEY"
  },
  "twilio": {
    "token": "TWILIO_TOKEN",
    "sid": "TWILIO_SID"
  }
}
```
