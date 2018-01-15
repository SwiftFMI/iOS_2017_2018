import * as React from 'react';
import {
    Image, DefaultButton, IButtonProps, TeachingBubble
} from 'office-ui-fabric-react';

export interface IShowButtonState {
    isTeachingBubbleVisible?: boolean;
}

export default class ShowButton extends React.Component<{}, IShowButtonState> {

    private _menuButtonElement: HTMLElement;

    public constructor() {
        alert("00-1");
        super();

        this._onDismiss = this._onDismiss.bind(this);

        this.state = {
            isTeachingBubbleVisible: false,
        };
    }


    public render() {

        // return (
        //     <span>
        //         opaaaa 2

        //     <i className="ms-Icon ms-Icon--MessageFill"
        //             aria-hidden="true"
        //             onClick={this._showMessage}
        //         ></i>
        //     </span>
        // );
        let { isTeachingBubbleVisible } = this.state;
        let examplePrimaryButton: IButtonProps = {
            children: 'Try it out'
        };
        let exampleSecondaryButtonProps: IButtonProps = {
            children: 'Maybe later',
            onClick: this._onDismiss
        };

        return (
            <span className='notifierWrapperSing'>
                <span ref={(menuButton) => this._menuButtonElement = menuButton!}>
                    {/* <DefaultButton
                        onClick={this._onDismiss}
                        text={isTeachingBubbleVisible ? 'Hide' : 'Show'}
                    /> */}

                    <a id="notifierIconSing" onClick={this._onDismiss} href="javascript:void(0)" >
                        <i className="ms-Icon ms-Icon--MessageFill"
                            aria-hidden="true"
                            onClick={this._showMessage}>
                            <span className="notifierInboxCount">1</span>
                        </i>
                        <span className='notifierTextSing'>Messages</span>
                    </a>
                </span>
                {isTeachingBubbleVisible ? (
                    <TeachingBubble
                        targetElement={this._menuButtonElement}
                        primaryButtonProps={examplePrimaryButton}
                        secondaryButtonProps={exampleSecondaryButtonProps}
                        onDismiss={this._onDismiss}
                        headline='Discover what’s trending around you'
                    >
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Facere, nulla, ipsum? Molestiae quis aliquam magni harum non?
                </TeachingBubble>
                ) : (null)}
            </span>
        );
    }

    private _onDismiss(event: any) {

        this.setState({
            isTeachingBubbleVisible: !this.state.isTeachingBubbleVisible
        });

        event.preventDefault();
        return false;
    }

    private _showMessage(e: any): void {
        console.log("custom logic 005");
        // alert("OK, this works!");
    }

}