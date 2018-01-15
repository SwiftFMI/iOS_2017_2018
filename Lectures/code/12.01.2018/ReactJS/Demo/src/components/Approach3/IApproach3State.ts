
import { IPost, IComment } from "../../common/ICommonObjects"

export interface IApproach3State {
    AllPosts?: IPost[];
    IsLoading: boolean,
    ExceptionMessage?: string;
}
