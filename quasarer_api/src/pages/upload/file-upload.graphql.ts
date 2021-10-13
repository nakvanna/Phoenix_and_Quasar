import gql from "graphql-tag";


export const fileUploadGraphql = gql `

  mutation FileUpload($file: Upload!){
    fileUpload(file: $file)
  }

`
