import { config } from "firebase-functions"
import Twilio from "twilio"

const envConfig = config()
const accountSid = envConfig.twilio.sid; // Your Account SID from www.twilio.com/console
const authToken = envConfig.twilio.token;
const twilioNumber = "+18593502133"

const client = Twilio(accountSid, authToken)

interface sendMessageInterface {
    message: string, mobileNo: string
}
/**
 * The function is used to send a SMS to anyone using Twilio
 * 
 * @param message This is the content of the SMS
 * 
 * @param mobileNo Whom the message is sent to
 * Eg => "+919594122345"
 * 
 * @returns Function
 */
const sendMessage = ({ message, mobileNo }: sendMessageInterface) => client.messages.create({
    from: twilioNumber,
    to: mobileNo,
    body: message
})

export {
    sendMessage
}