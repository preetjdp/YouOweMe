# Description

👉 New release for the YouOweMe

 <!-- Insert Anecdote here -->

## 🚀 Updates

 <!-- These are updates made to the service -→

- <!-- Insert Update --> @user [Linear]() | # | [Docs]()
- <!-- Insert Update --> @user [Linear]() | # | [Docs]()
- <!-- Insert Update --> @user [Linear]() | # | [Docs]()
- Added an API to fetch the `track` for a Project @utkarsh-var [Linear](https://linear.app/devfolio/issue/BE-412/datalayer-api-for-fetching-the-project-tracks) | #554
- Bring in support for event-based notifications to the Datalayer, this will be used to power the email sent notifications flow for the organizer dashboard @iamazhar @utkarsh-var [Linear](https://linear.app/devfolio/issue/BE-260/notification-data-layer-logic) | #500
    - This is powered by Amazon SNS
    - Added an API to create a new Notification Topic `POST /notifications/`
    - Added an API to subscribe a user to a Topic `POST /notifications/subscribe`
    - Added an API to register the device using FCM Token `POST /notifications/register_device`

## 🐛Bug Fixes

- Add better email validation to allow only valid emails to be used @iamazhar [Linear](https://linear.app/devfolio/issue/BE-305/failed-to-send-critical-email) | #515 | [Sentry](https://sentry.io/organizations/hack-inout-tech-llp/issues/2116662182/?referrer=Linear)

## 🚄Optimizations

- Introduce caching to the users' extras API @preetjdp [Linear](https://linear.app/devfolio/issue/BE-317/users-extra-api-datalayer-changes) | #517

## 🧹Housekeeping

- Added more type information, documentation, and overall refactoring to some services and controllers @devfolioco/backend
- Refactored user extra services and controllers @preetjdp #517
- Remove `send_grid` dependencies, services, interfaces that are no longer being used @iamazhar @utkarsh-var #495
- Reactor some bits of the user hackathon services to follow the updated code style @utkarsh-var #495

## 🧑🏼‍💻Developer Info

- Added a new shared generic type for Pagination [Reference](https://github.com/devfolioco/projectx/blob/d8f5ab478ed8b2a90c543b65e48af9f14ef4f08a/src/shared/types.ts#L23-L36)

## 🧪Testing

- Bring in the CI to run the email service tests using [Localstack](https://www.notion.so/devfolio/Release-Notes-Backend-3dc804bf920c4ab9994e2b64ecce4355) @devfolioco/backend [Linear](https://linear.app/devfolio/issue/BE-368/add-ses-tests) | #540
- Added tests for the user extra services @preetjdp #517
- Added tests for the refactored CSV flow @pushkar-anand #536

## Cross service updates

- Use the updated internal APIs in devfolio API [Release Notes](https://github.com/devfolioco/devfolio-api/releases/tag/v2.0.0)

## 🔐 Environment Keys

- Added `The key that was added`
- Removed `The key that was removed`

## Migrations

- Add a `sns_arns` table
