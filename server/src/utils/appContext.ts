import { Request } from 'express'

export interface ApplicationContext {
    req: Request;
    requestId: number
}