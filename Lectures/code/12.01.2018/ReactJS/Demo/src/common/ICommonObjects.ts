

export interface IPost {
    Id?: string;
    UserName?: string;
    UserImage?: string;
    ImageUrl?: string;
    ImageLocation?: string;
    ImageLikes?: string;
    ImageComment?: string;
    Comments?: IComment[];
}

export interface IComment {
    Id?: string;
    Text?: string;
}
