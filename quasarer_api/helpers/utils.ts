import {Notify} from "quasar";

export const TOKEN_KEY = 'tokenKey'
export const LOGIN_INFO_KEY = 'loginInfoKey'
export function cleanObject(obj: any){
  return JSON.parse(JSON.stringify(obj))
}

export const crudMessage = {
  successMsg: (msg: string, timeout: number = 600) => {
    Notify.create({
      type: "positive",
      position: "top",
      message: msg,
      timeout: timeout
    })
  },

  errorMsg: (msg: string, timeout: number = 600) => {
    Notify.create({
      type: "negative",
      position: "top",
      message: msg,
      timeout: timeout
    })
  },

  successCreate: (timeout: number = 600) => {
    Notify.create({
      type: "positive",
      position: "top",
      message: 'បង្កើតបានដោយជោគជ័យ!',
      timeout: timeout
    })
  },

  errorCreate: (timeout: number = 600) => {
    Notify.create({
      type: "negative",
      position: "top",
      message: 'បរាជ័យក្នុងបង្កើត!',
      timeout: timeout
    })
  }

}
