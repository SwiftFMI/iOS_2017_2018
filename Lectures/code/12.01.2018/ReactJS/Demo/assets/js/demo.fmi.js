'use strict'

console.log("demo.fmi.js is loaded");

document.addEventListener("DOMContentLoaded", function (event) {

    console.log("executing custom logic");

    // demo 1: Load Async data
    LoadData1();

    // demo 2
    // LoadData2();

    // demo 3
    // LoadData3();

});


function LoadData1() {
    //Jquery will be neded for easy work with async calls
    $.ajax({
        url: "instagram.feed/instagramdemofeed.json",
        method: "GET",
        headers: { "Accept": "application/json; odata=verbose" },
        dataType: "json",
        success: function (data) {
            //render logic is here
            var wallHtml = "";
            if (data) {
                //data.forEach(function (item) {
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

                    wallHtml += GetPostHtml(i, userName, userImage, imageUrl, imageLocation, imageLikes, imageComment, comments) + "<br /><br />";

                }
                //});

                //render data
                var element = document.getElementById("element-root");
                if (element) {
                    element.innerHTML = wallHtml;
                }
            }

        }.bind(this),
        error: function (data) {
            console.log("Error: " + data);
        }
    });
}

function LoadData2() {

    // get data
    var wallHtml = "";
    for (var i = 0; i < 10; i++) {
        wallHtml += postTemplate + "<br /><br />";
    }

    // render data
    var element = document.getElementById("element-root");
    if (element) {
        element.innerHTML = wallHtml;
    }


}

function LoadData3() {

    var wallHtml = "";
    for (var i = 0; i < 10; i++) {

        var userName = "Demo User " + i;
        var userImage = "/assets/images/001/avatar-user-001.jpg?key=" + i;
        var imageUrl = "/assets/images/001/Image001.jpg?key=" + i;
        var imageLocation = "Sofia, Bulgaria #" + i;
        var imageLikes = i + " Likes";
        var imageComment = "My perfect day is starting...";
        var comments =
            [
                {
                    "id": 123,
                    "text": "This is so cool"
                },
                {
                    "id": 124,
                    "text": "WoW..."
                },
                {
                    "id": 125,
                    "text": "this is fake image!"
                },
                {
                    "id": 126,
                    "text": "I like it"
                }
            ];

        wallHtml += GetPostHtml(i, userName, userImage, imageUrl, imageLocation, imageLikes, imageComment, comments) + "<br /><br />";
    }

    //render data
    var element = document.getElementById("element-root");
    if (element) {
        element.innerHTML = wallHtml;
    }

}

function HandleAddComment(elementId) {

    if (event.keyCode == 13) {

        // GET USER DATA
        var textElement = document.getElementById("textarea_" + elementId);
        if (textElement) {
            var text = textElement.value;

            //DISPLAY ACTION
            textElement.value = ""; //clear 
            textElement.blur(); //remove focus
            var commentsElement = document.getElementById("comments_" + elementId);
            if (commentsElement) {
                commentsElement.innerHTML += text + "<br />";

            }

            //SEND DATA TO SERVER
            /*
             - send our change
             - read server version of the data (maybe other new commentes are added)
             - display data (if needed)
               -- get element by ID
               -- render again the comments  [ UI Libraries ....]
               / we manipulate the DOM /
            */
        }
    }
}

function GetPostHtml(id, userName, userImage, imageUrl, imageLocation, imageLikes, imageComment, comments) {

    var post = postTemplateReal
        .replaceAll("#user_image#", userImage)
        .replaceAll("#user_name#", userName)
        .replaceAll("#image_location#", imageLocation)
        .replaceAll("#image_url#", imageUrl)
        .replaceAll("#image_totallinkes#", imageLikes)
        .replaceAll("#image_comment#", imageComment)
        .replaceAll("#all_comments#", GetComments(comments))

        .replaceAll("#ID#", id);

    return post;

}

function GetComments(comments) {
    var allComents = "";
    for (var i = 0; i < comments.length; i++) {
        allComents += comments[i].text + "<br />";
    }
    return allComents;
}

var postTemplate =
    '<div class="article-wrapper"> \
  <div class="user-details"> \
      <div class="user-avatar"> \
          <img class="avatar" src="/assets/images/001/avatar-user-001.jpg" alt="Demo User" /> \
      </div> \
      <div class="user-names"> \
          <div class="name">Demo User</div> \
          <div class="location">Sofia, Bulgaria</div> \
      </div> \
  </div> \
  <div class="article-image"> \
      <img src="/assets/images/001/Image001.jpg" alt="Demo User" class="fmi-responsive" /> \
  </div> \
  <div class="social-actions"> \
      <div class="actions"> \
          <a href=""> \
              <span class="action-like"></span> \
          </a> \
          <a href=""> \
              <span class="action-comment"></span> \
          </a> \
          <a href=""> \
              <span class="action-share"></span> \
          </a> \
      </div> \
      <div>  \
          13 Likes \
      </div> \
      <div class="comment"> \
          My perfect day is starting... \
      </div> \
      <div class="comment"> \
          <textarea rows="1" cols="50" placeholder="Add a comment..." class="add-comment"></textarea> \
      </div> \
  </div> \
</div>';

var postTemplateReal =
    '<div class="article-wrapper"> \
  <div class="user-details"> \
      <div class="user-avatar"> \
          <img class="avatar" src="#user_image#" alt="#user_name#" /> \
      </div> \
      <div class="user-names"> \
          <div class="name">#user_name#</div> \
          <div class="location">#image_location#</div> \
      </div> \
  </div> \
  <div class="article-image"> \
      <img src="#image_url#" alt="" class="fmi-responsive" /> \
  </div> \
  <div class="social-actions"> \
      <div class="actions"> \
          <a href=""> \
              <span class="action-like"></span> \
          </a> \
          <a href=""> \
              <span class="action-comment"></span> \
          </a> \
          <a href=""> \
              <span class="action-share"></span> \
          </a> \
      </div> \
      <div>  \
      #image_totallinkes# \
      </div> \
      <div class="comment"> \
          #image_comment# \
      </div> \
      <div id="comments_#ID#" class="allcomments">#all_comments#</div> \
      <div class="comment"> \
          <textarea id="textarea_#ID#" onkeydown="HandleAddComment(#ID#);" rows="1" cols="50" placeholder="Add a comment..." class="add-comment"></textarea> \
      </div> \
  </div> \
</div>';


String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};