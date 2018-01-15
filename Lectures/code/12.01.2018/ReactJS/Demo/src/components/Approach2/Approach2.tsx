import * as React from 'react';
import { IPost, IComment } from "../../common/ICommonObjects"

export default class Approach2 extends React.Component<{}, {}> {

    // this is not coorect use of REACT !
    _allPosts: IPost[] = [];

    constructor() {
        super();

        for (var i = 0; i < 10; i++) {
            this._allPosts.push({
                UserName: "Demo User " + i,
                UserImage: "/assets/images/001/avatar-user-001.jpg?key=" + i,
                ImageUrl: "/assets/images/001/Image001.jpg?key=" + i,
                ImageLocation: "Sofia, Bulgaria #" + i,
                ImageLikes: i + " Likes",
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
    }

    public render() {

        return (
            <div>
                {this._allPosts.map(post => (
                    <div className="article-wrapper">
                        <div className="user-details">
                            <div className="user-avatar">
                                <img className="avatar" src={post.UserImage} alt={post.UserName} />
                            </div>
                            <div className="user-names">
                                <div className="name">{post.UserName}</div>
                                <div className="location">{post.ImageLocation}</div>
                            </div>
                        </div>
                        <div className="article-image">
                            <img src={post.ImageUrl} alt="" className="fmi-responsive" />
                        </div>
                        <div className="social-actions">
                            <div className="actions">
                                <a href="">
                                    <span className="action-like"></span>
                                </a>
                                <a href="">
                                    <span className="action-comment"></span>
                                </a>
                                <a href="">
                                    <span className="action-share"></span>
                                </a>
                            </div>
                            <div>
                                {post.ImageLikes} Likes
                            </div>
                            <div className="comment">
                                {post.ImageComment}
                            </div>
                            <div id="comments_ID" className="allcomments">
                                {post.Comments.map(comment => (
                                    <div>   {comment.Text} </div>
                                ))
                                }
                            </div>
                            <div className="comment">
                                <textarea id="textarea_ID" placeholder="Add a comment..." className="add-comment"></textarea>
                            </div>
                        </div>

                    </div>
                ))
                }
            </div>
        );

    }

}