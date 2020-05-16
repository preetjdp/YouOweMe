import { config } from "firebase-functions"
import Twilio from "twilio"

const envConfig = config()
const accountSid = envConfig.twilio.sid; // Your Account SID from www.twilio.com/console
const authToken = envConfig.twilio.token;

const client = Twilio(accountSid, authToken)

interface sendMessageInterface {
    message: string, mobileNo: string
}
/**
 * This function accepts two parameters.
 * 1. The Message in String.
 * 2. The phone number. Eg => "+919594122345"
 */
const sendMessage = ({ message, mobileNo }: sendMessageInterface) => client.messages.create({
    from: "+18593502133",
    to: mobileNo,
    body: message
})

export {
    sendMessage
}