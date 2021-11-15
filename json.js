function parse(root, message) {
    var JsonString = message; //'{"a":"A whatever, run","b":"B fore something happens"}';
    var JsonObject = JSON.parse(JsonString);

    //retrieve values from JSON again
    var aString = JsonObject.handle;
    var bString = JsonObject.text;

    print("handle: " + aString);
    print("text: " + bString);

    textArea.append(aString + ": " + bString)
    textField.clear()
    scrollView.contentItem.contentY = textArea.height - scrollView.contentItem.height
}
