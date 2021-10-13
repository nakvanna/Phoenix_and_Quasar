import {computed, reactive} from "vue";
import {useQuery, useResult} from "@vue/apollo-composable";
import {postGraphql} from "pages/post/graphql/post.graphql";
import {getGlobalUser} from "src/helpers/utils";

const homeGraphqlState = {
  homeQueryDoc: {
    listHomePost: postGraphql,
  }
}

export function readHomePost() {

  const state = reactive({
    queryVariable: {
      homePost: {
        first: 15,
        condition: JSON.stringify({}),
        userArg: {
          condition: JSON.stringify({})
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
        },
        {
          name: 'title',
          required: true,
          label: 'TITLE',
          align: 'left',
          field: 'title',
          sortable: true
        },
        {
          name: 'content',
          required: true,
          label: 'CONTENT',
          align: 'left',
          field: 'content',
          sortable: true
        },
        {
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
  const queryPost = useQuery(homeGraphqlState.homeQueryDoc.listHomePost, state.queryVariable.homePost)
  const queryPostResult = <any>useResult(queryPost.result)

  return {
    state,
    md,
  }
}
