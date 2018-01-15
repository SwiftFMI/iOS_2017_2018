import * as React from "react";
import * as ReactDOM from "react-dom";

import Approach1 from "./components/Approach1/Approach1";
import Approach2 from "./components/Approach2/Approach2";
import Approach3 from "./components/Approach3/Approach3";

import DataProvider from "./common/DataProvider";
import IDataProvider from "./common/IDataProvider";

export default class Notifier {
    public Init(): void {

        const search = window.document.location.search; // could be '?approach=1'
        const params = new URLSearchParams(search);
        const approachNumber = params.get('approach'); // 1


        var parentNode = document.getElementById('react-root');
        if (parentNode) {

            let element: any;
            switch (approachNumber) {
                case "2":
                    element = React.createElement(Approach2, {});
                    break;
                case "3":
                    element = React.createElement(Approach3, {});
                    break;
                default:
                    let dataProvider = new DataProvider("todo_login_name");
                    element = React.createElement(Approach3, {
                        dataProvider: dataProvider
                    });
                    break;
            }
            ReactDOM.render(element, parentNode);
        }
        else {
            console.log("missing wrapper element");
        }
    }
}


document.addEventListener("DOMContentLoaded", function (event) {
    let ntf = new Notifier();
    ntf.Init();
});

