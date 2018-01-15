import * as React from 'react';

import { IPost, IComment } from "../../common/ICommonObjects"
import { IApproach3Props } from "./IApproach3Props"
import { IApproach3State } from "./IApproach3State"

export default class Approach3 extends React.Component<IApproach3Props, IApproach3State> {

    public constructor(props: IApproach3Props) {
        super();

        this.state = {
            IsLoading: true,
            AllPosts: [],
        };
    }

    public render() {

        if (this.state.IsLoading) {
            return (
                <span className='loading'>Loading...</span>);
        }
        else {

            return (
                <div>
                    {this.state.AllPosts.map(post => (
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

    public componentDidMount() {
        debugger;

        this.props.dataProvider.readUserPosts().then(
            (items: IPost[]) => {
                debugger;

                this.setState({
                    IsLoading: false,
                    AllPosts: items
                });


            }).catch((e) => {
                debugger;
                console.log(e);
                this.setState({
                    // setup text
                    ExceptionMessage: "Cannot load the data."
                });
            });
    }
}