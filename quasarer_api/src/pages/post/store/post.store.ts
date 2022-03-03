import {computed, reactive} from "vue";
import {useMutation, useQuery, useResult} from "@vue/apollo-composable";
import {postGraphql} from "pages/post/graphql/post.graphql";
import {cleanObject, crudMessage, getGlobalUser} from "src/helpers/utils";
import {createPostGraphql} from "pages/post/graphql/create-post.graphql";
import {MediaPostModel, PostModel} from "pages/post/model/post.model";

const userGraphqlState = {
  userQueryDoc: {
    listPost: postGraphql,
    createPost: createPostGraphql,
  }
}

export function readPost() {

  const state = reactive({
    queryVariable: {
      post: {
        first: 10,
        condition: JSON.stringify({}),
        userArg: {
          condition: JSON.stringify({
            'id-eq': getGlobalUser().id
          })
        }
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
          name: 'title',
          required: true,
          label: 'TITLE',
          align: 'left',
          field: 'title',
          sortable: true
        }, {
          name: 'content',
          required: true,
          label: 'CONTENT',
          align: 'left',
          field: 'content',
          sortable: true
        }, {
          name: 'status',
          required: true,
          label: 'STATUS',
          align: 'left',
          field: 'status',
          sortable: true
        },
      ],
      data: computed(() => {
        return {
          record: queryPostResult.value?.edges?.map((x: any) => x.node) || []
        }
      }),
    }
  })
  const md = {}

  //Query
  const queryPost = useQuery(userGraphqlState.userQueryDoc.listPost, state.queryVariable.post)
  const queryPostResult = <any>useResult(queryPost.result)

  return {
    state,
    md,
  }
}

export function createPost() {
  const state = reactive({
    post: {
      input: <PostModel>{
        status: 'public',
        content: '<pre>Leave your content here!</pre>',
        mediaPosts: <MediaPostModel[]>[]
      }
    }
  })
  const md = {
    post: {
      create: () => {
        const user = getGlobalUser()
        const data = <PostModel>cleanObject(state.post.input)
        data.userId = user.id
        mutatePost.mutate({data})
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

  //Graphql
  //--Mutations
  const mutatePost = useMutation(userGraphqlState.userQueryDoc.createPost)

  return {
    state,
    md
  }
}
