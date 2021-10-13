import gql from "graphql-tag";


export const createPostGraphql = gql `

  mutation CreatePost($data: CreatePostInputType!){
    createPost(data: $data){
      message
      success
    }
  }

`
