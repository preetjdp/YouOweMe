import { Request } from 'express'

/**
 * This is the context used by the entire application
 */
export interface ApplicationContext {
    req: Request;
    requestId: number
}