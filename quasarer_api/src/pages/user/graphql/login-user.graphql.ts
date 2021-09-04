import gql from "graphql-tag";

export const loginUserGraphql = gql `

  mutation LoginUser($data: CreateSessionInput!){
    login(data: $data){
      token
      user{
        id
        name
        username
        email
        role
        verify
      }
    }
  }

`
