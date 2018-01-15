import 'whatwg-fetch'
import IDataProvider from "./IDataProvider"
import { IPost, IComment } from "../common/ICommonObjects"

export class DataProvider implements IDataProvider {

      _loginName: string;

      constructor(loginName?: string) {
            this._loginName = loginName;
      }


      public readUserPosts(): Promise<IPost[]> {
            debugger;
            const queryUrlGetCurrentUserPosts: string = "instagram.feed/instagramdemofeed.json";
            return fetch(queryUrlGetCurrentUserPosts,
                  {
                        method: "GET",
                        // headers: {
                        //       "Accept": "application/json; odata=verbose",
                        // },
                        //credentials: "same-origin"
                  })
                  .then((response: any) => {
                        debugger;
                        if (response.status >= 200 && response.status < 300) {
                              return response.json();
                        } else {
                              return Promise.reject(new Error(JSON.stringify(response)));
                        }
                  })
                  .then((data: any) => {
                        debugger;
                        let result: IPost[] = [];
                        console.log(data);

                        for (var i = 0; i < data.length; i++) {
                              var item = data[i];
                              console.log(item);

                              var userName = item.avatar.name;
                              var userImage = item.avatar.url;
                              var imageUrl = item.image;
                              var imageLocation = "...";
                              var imageLikes = item.likes + " Likes";
                              var imageComment = "My perfect day is starting...";
                              var comments = item.comments;

                              result.push({
                                    Id: i.toString(),
                                    UserName: item.avatar.name,
                                    UserImage: item.avatar.url,
                                    ImageUrl: item.image,
                                    ImageLocation: "...",
                                    ImageLikes:  item.likes + " Likes",
                                    ImageComment: "My perfect day is starting...",
                                    Comments: [
                                          {
                                                Id: "123",
                                                Text: "This is so cool"
                                          },
                                          {
                                                Id: "124",
                                                Text: "WoW..."
                                          }
                                    ]
                              });

                        }

                        return result;
                  });
      }

      updatePost(item: IPost): boolean {
            return true;
      }

}

export default DataProvider;