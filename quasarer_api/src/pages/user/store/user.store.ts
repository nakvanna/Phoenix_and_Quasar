import {computed, reactive} from "vue";
import {userGraphql} from "pages/user/graphql/user.graphql";
import {useMutation, useQuery, useResult} from "@vue/apollo-composable";
import {createUserGraphql} from "pages/user/graphql/create-user.graphql";
import {LoginUserModel, UserModel} from "pages/user/model/users.model";
import {loginUserGraphql} from "pages/user/graphql/login-user.graphql";
import {LocalStorage} from 'quasar'
import {cleanObject, crudMessage, LOGIN_INFO_KEY} from "src/helpers/utils";

const userGraphqlState = {
  userQueryDoc: {
    listUser: userGraphql,
    createUser: createUserGraphql,
    loginUser: loginUserGraphql,
  }
}

export function readUser() {
  const state = reactive({
    queryVariable: {
      user: {
        first: 15,
        condition: JSON.stringify({})
      }
    },
    table: {
      columns: [
        {
          name: 'id',
          required: true,
          label: 'ID',
          align: 'left',
          field: 'id',
          sortable: true
        }, {
          name: 'profile',
          required: true,
          label: 'PROFILE',
          align: 'left',
          field: 'profile',
          sortable: true
        },
        {
          name: 'name',
          required: true,
          label: 'NAME',
          align: 'left',
          field: 'name',
          sortable: true
        },
        {
          name: 'username',
          required: true,
          label: 'USERNAME',
          align: 'left',
          field: 'username',
          sortable: true
        },
        {
          name: 'email',
          required: true,
          label: 'EMAIL',
          align: 'left',
          field: 'email',
          sortable: true
        },
        {
          name: 'role',
          required: true,
          label: 'ROLE',
          align: 'left',
          field: 'role',
          sortable: true
        },
        {
          name: 'verify',
          required: true,
          label: 'VERIFY',
          align: 'left',
          field: 'verify',
          sortable: true
        },
      ],
      data: computed(() => {
        return {
          record: queryUserResult.value?.edges?.map((x: any) => x.node) || []
        }
      }),
      tables: [
        {
          id: 1,
          name: 'NAK VANNA',
          username: 'nakvanna',
          email: 'nakvannamcu@gmail.com',
          role: 'user',
          verify: 'false',
        },
        {
          id: 2,
          name: 'Srey Cute',
          username: 'sreycute',
          email: 'sreycute@gmail.com',
          role: 'user',
          verify: 'false',
        },
      ]
    }
  })
  const md = {}

  //Query
  const queryUser = useQuery(userGraphqlState.userQueryDoc.listUser, state.queryVariable.user)
  const queryUserResult = <any>useResult(queryUser.result)

  return {
    state,
    md,
  }
}

export function createUser() {
  const state = reactive({
    user: {
      data: <UserModel>{}
    }
  })
  const md = {
    user: {
      create: () => {
        const data = JSON.parse(JSON.stringify(state.user.data))
        mutateUser.mutate({data})
          .then(_res => {
            crudMessage.successCreate()
          })
          .catch(_err => {
            crudMessage.errorCreate()
          })
      },
      clear: () => {

      }
    }
  }

  //mutates
  const mutateUser = useMutation(userGraphqlState.userQueryDoc.createUser)

  return {
    state,
    md
  }
}

export function loginUser() {
  const state = reactive({
    user: {
      data: <LoginUserModel>{}
    }
  })

  const md = {
    user: {
      login: () => {
        const data = cleanObject(state.user.data)
        console.log(data)
        mutationLogin.mutate({data})
          .then(res => {
            const userInfoAndToken = res?.data['login'] || null
            LocalStorage.set(LOGIN_INFO_KEY, userInfoAndToken)
            window.location.reload()
            crudMessage.successMsg('ចូលបានជោគជ័យ!')
          })
          .catch(_err => {
            crudMessage.errorMsg(_err.toString())
            // crudMessage.errorMsg('បរាជ័យក្នុងការចូល!')
          })
      },
      clear: () => {

      }
    }
  }

  const mutationLogin = useMutation(userGraphqlState.userQueryDoc.loginUser)

  return {
    state,
    md
  }
}
