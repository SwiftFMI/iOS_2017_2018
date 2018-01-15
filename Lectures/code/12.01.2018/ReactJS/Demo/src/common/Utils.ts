export default class Utils {
    
        /**
         *  global flag that enable or disable the logging
         */
        logToConsole: boolean = true;


        public DebugLog(message: string): void {
            if (this.logToConsole) {
                console.log(message);
            }
        }
        
        public DebugLogWithMessage(message: string, obj: any): void {
            if (this.logToConsole) {
                console.log(message);
                console.log(obj);
            }
        }


        public validTextColour(stringToTest: string): boolean {
            //Alter the following conditions according to your need.
            if (stringToTest === "") { return false; }
            if (stringToTest === "inherit") { return false; }
            if (stringToTest === "transparent") { return false; }
        
            var image = document.createElement("img");
            image.style.color = "rgb(0, 0, 0)";
            image.style.color = stringToTest;
            if (image.style.color !== "rgb(0, 0, 0)") { return true; }
            image.style.color = "rgb(255, 255, 255)";
            image.style.color = stringToTest;
            return image.style.color !== "rgb(255, 255, 255)";
        }
}
    