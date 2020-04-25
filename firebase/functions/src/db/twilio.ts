import Twilio from "twilio"

const accountSid = 'ACb9762f4f844357cda8df00fc1c355462'; // Your Account SID from www.twilio.com/console
const authToken = 'f5e66a7777c2e8ed976d09f0e47bfc32';

const client = Twilio(accountSid, authToken)

/**
 * This function accepts two parameters.
 * 1. The Message in String.
 * 2. The phone number. Eg => "+919594122345"
 */
const sendMessage = async (message: string, mobileNo: string) => client.messages.create({
    from: "+18593502133",
    to: mobileNo,
    body: message
})

export {
    sendMessage
}