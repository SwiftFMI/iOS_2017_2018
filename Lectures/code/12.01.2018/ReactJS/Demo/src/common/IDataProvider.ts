
import { IPost } from "../common/ICommonObjects";

interface IDataProvider {

    readUserPosts(): Promise<IPost[]>;

    updatePost(item: IPost): boolean;

}

export default IDataProvider;
