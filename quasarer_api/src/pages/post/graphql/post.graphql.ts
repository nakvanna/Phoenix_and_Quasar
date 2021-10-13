import gql from "graphql-tag";

export const postGraphql = gql `

  query Post($first: Int!, $condition: Json!, $userArg: ArgCondition!){
    posts(first: $first, condition: $condition, userArg: $userArg, orderBy: "id-desc"){
      count
      edges{
        node{
          id
          title
          content
          status
          user{
            id
            profile
            name
            username
            email
            role
            verify
          }
          mediaPosts{
            id
            fileType
            fileUrl
          }
        }
      }
    }
  }

`
