
export interface PostModel{
  id?: string | any
  status?: string | any
  title?: string | any
  content?: string | any
  userId?: string | any
  mediaPosts: MediaPostModel[]
}

export interface MediaPostModel {
  fileType?: string | any
  fileUrl?: string | any
  postId?: string | any
}
